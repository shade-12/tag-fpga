module dp_accelerator (
    input logic clk, input logic rst_n,
    // slave (CPU-facing)
    output logic slave_waitrequest,
    input logic [3:0] slave_address,
    input logic slave_read, output logic [31:0] slave_readdata,
    input logic slave_write, input logic [31:0] slave_writedata,
    // master (memory-facing)
    input logic master_waitrequest,
    output logic [31:0] master_address,
    output logic master_read, input logic [31:0] master_readdata, input logic master_readdatavalid,
    output logic master_write, output logic [31:0] master_writedata
);

    logic done_dot, slave_waitrequest_out;
    logic [31:0] slave_readdata_out, 
                 weight_addr, vector_addr, vector_length, start_indicator,
                 stored_weight_addr, stored_vector_addr, stored_vector_length;

    // Master

    `define IDLE    3'b000
    `define READ_W  3'b001      // Read w[i] value from memory
    `define WAIT_W  3'b010
    `define READ_V  3'b011      // Read ifmap[i] value from memory
    `define WAIT_V  3'b100
    `define CALC    3'b101      // Add value of w[i] * ifmap[i] to sum
    `define DONE    3'b110

    logic start_dot, start_new_dot, master_read_out, sign_bit;
    logic [2:0] state;
    logic [31:0] master_address_out;
    logic signed [63:0] prod;
    integer count, weight_val, vector_val, sum, int_prod;

    assign slave_readdata = slave_readdata_out;

    /* A slave asserts waitrequest when unable to respond to a read or write request. 
     * Forces the master to wait until the interconnect is ready to proceed with the transfer. */
    assign slave_waitrequest = slave_waitrequest_out;

    always @(*) begin
        if (rst_n == 1'b0)
            slave_waitrequest_out = 1'b1;
        else
            if (state == `READ_W || state == `WAIT_W || state == `READ_V || state == `WAIT_V || state == `CALC)
                slave_waitrequest_out = 1'b1;
            else
                slave_waitrequest_out = 1'b0;
    end

    always @(posedge clk)
        if (rst_n == 1'b0)
            slave_readdata_out <= 32'b0;
        else begin
            if (slave_read & (slave_address == 4'd0) & done_dot)
                slave_readdata_out <= sum;
            if (slave_write) begin
                if (slave_address == 4'd0) start_indicator <= slave_writedata;
                if (slave_address == 4'd2) weight_addr <= slave_writedata;
                if (slave_address == 4'd3) vector_addr <= slave_writedata;
                if (slave_address == 4'd5) vector_length <= slave_writedata;
            end
        end


    // Master

    assign start_dot = slave_write && (slave_address == 4'd0);
    assign master_read = master_read_out;
    assign master_address = master_address_out;

    // Dot does not write to memory
    assign master_write = 1'b0;
    assign master_writedata = 32'bx;

    assign start_new_dot = (stored_weight_addr != weight_addr) || (stored_vector_addr != vector_addr) || (stored_vector_length != vector_length);
    assign sign_bit = weight_val[31] ^ vector_val[31];

    /* SPECS: Able to handle multiple requests.
     * 1. Stays in `DONE state if offsets 1 to 7 are the same for two writes to offset 0
     */
    always @(posedge clk)
        if (rst_n == 1'b0) begin
            state = `IDLE;
            master_read_out = 1'b0;
            master_address_out = 32'bx;
            done_dot = 1'b0;
        end else
            case (state)
                `IDLE: begin
                    done_dot = 1'b0;
                    master_read_out = 1'b0;
                    master_address_out = 32'bx;
                    count = 0;
                    sum = 0;
                    if (start_dot) begin
                        stored_weight_addr = weight_addr;
                        stored_vector_addr = vector_addr;
                        stored_vector_length = vector_length;
                        state = `READ_W;
                    end
                end
                `READ_W: begin
                    if (count < stored_vector_length) begin
                        done_dot = 1'b0;
                        master_read_out = 1'b1;
                        master_address_out = stored_weight_addr + (count * 4);
                        state = `WAIT_W;
                    end else begin
                        state = `DONE;
                        done_dot = 1'b1;
                    end
                end
                `WAIT_W: begin
                    done_dot = 1'b0;
                    if (master_waitrequest == 1'b0) begin
                        master_read_out = 1'b0;
                        state = `READ_V;
                    end
                end
                `READ_V: begin
                    done_dot = 1'b0;
                    if (master_readdatavalid == 1'b1) begin
                        master_read_out = 1'b1;
                        master_address_out = stored_vector_addr + (count * 4);
                        state = `WAIT_V;
                        weight_val = master_readdata;    // Keep track of w[i] value
                    end
                end
                `WAIT_V: begin
                    done_dot = 1'b0;
                    if (master_waitrequest == 1'b0) begin
                        master_read_out = 1'b0;
                        state = `CALC;
                    end
                end
                `CALC: begin
                    done_dot = 1'b0;
                    if (master_readdatavalid == 1'b1) begin
                        master_read_out = 1'b0;
                        // Dot product calculation
                        vector_val = master_readdata;
                        prod = weight_val * vector_val; // Integer: prod[63:32], fraction: prod[31:0]
                        // Round up if MSB is 1
                        if (prod[31] == 1'b1)
                            if (sign_bit == 1'b1)
                                int_prod = prod[63:32] - 1'b1;
                            else
                                int_prod = prod[63:32] + 1'b1;
                        else
                            int_prod = prod[63:32];
                         
                        sum += int_prod;
                        count += 1;
                        state = `READ_W;
                    end
                end
                `DONE: begin
                    master_read_out = 1'b0;
                    master_address_out = 32'bx;
                    count = 0;
                    if (start_dot & start_new_dot) begin
                        sum = 0;
                        stored_weight_addr = weight_addr;
                        stored_vector_addr = vector_addr;
                        stored_vector_length = vector_length;
                        state = `READ_W;
                        done_dot = 1'b0;
                    end else
                        done_dot = 1'b1;
                end
                default: begin
                    master_read_out = 1'b0;
                    master_address_out = 32'bx;
                    done_dot = 1'b0;
                end
            endcase

endmodule: dp_accelerator