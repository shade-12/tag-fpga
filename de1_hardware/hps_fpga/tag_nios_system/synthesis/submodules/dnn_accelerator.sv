module dnn_accelerator(
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

    /**
     * This DNN accelerator will accept memory addresses as direct arguments, 
     * but will then need to read the values (inputs, weights, inputs length) 
     * from memory over the Avalon master interface.
     *
     * To set up the computation, the ARM CPU will write addresses of the 
     * weight matrix, input activations, and the input activation vector length 
     * to the following word offsets in the accelerator component's address range:
    */

    // |--------|-------------------------------------------------------------|
    // |  Word  |                          Meaning                            |
    // |--------|-------------------------------------------------------------|
    // |   0    | write: starts accelerator; read: stalls and provides result |
    // |   1    | reserved                                                    |
    // |   2    | weight matrix byte address                                  |
    // |   3    | input activations vector byte address                       |
    // |   4    | reserved                                                    |
    // |   5    | input activations vector length                             |
    // |   6    | reserved                                                    |
    // |   7    | reserved                                                    |
    // |--------|-------------------------------------------------------------|
    
    logic [31:0] temp_weight_addr;
    logic [31:0] temp_input_addr;
    logic [31:0] temp_len;
    logic [31:0] weight_addr;
    logic [31:0] input_addr;
    logic [31:0] len;
    logic signed [31:0] input_val;
    logic signed [31:0] weight;
    logic signed [63:0] prod;
    logic signed [31:0] sum;
    logic [3:0] state;
    logic [31:0] data;

    `define GET_PARAM 4'd0
    `define START_READ_WEIGHT 4'd1
    `define WAIT_READ_WEIGHT 4'd2
    `define START_READ_INPUT 4'd3
    `define WAIT_READ_INPUT 4'd4
    `define CALC_PROD 4'd5
    `define INC 4'd6
    `define END 4'd7

    // slave 
    always @(posedge clk or negedge rst_n) begin
        if (rst_n == 1'b0) begin
            slave_waitrequest <= 1'b1;
            master_read <= 1'b0;
            master_write <= 1'b0;
            master_address <= 32'b0;
            master_writedata <= 32'b0;
            sum <= 32'd0;
            state <= `GET_PARAM;
        end
        else begin
            case (state) 
                `GET_PARAM: begin
                    slave_waitrequest <= 1'b0;
                    if (slave_address == 4'd2 && slave_write == 1'b1) begin
                        weight_addr <= slave_writedata;
                    end
                    else if (slave_address == 4'd3 && slave_write == 1'b1) begin
                        input_addr <= slave_writedata;
                    end
                    else if (slave_address == 4'd5 && slave_write == 1'b1) begin
                        len <= slave_writedata;
                    end
                    else if (slave_address == 4'd0 && slave_write == 1'b1) begin
                        if (len == 0) begin
                            state <= `END;//END;
                        end
                        else begin
                            temp_weight_addr <= weight_addr;
                            temp_input_addr <= input_addr;
                            temp_len <= len;
                            state <= `START_READ_WEIGHT;
                        end
                    end
                end
                `START_READ_WEIGHT: begin
                    slave_waitrequest <= 1'b1;
                    master_address <= temp_weight_addr;
                    master_read <= 1'b1;
                    state <= `WAIT_READ_WEIGHT;
                end
                `WAIT_READ_WEIGHT: begin
                    if (master_readdatavalid == 1'b1 && master_waitrequest == 1'b0) begin
                        weight <= master_readdata;
                        state <= `START_READ_INPUT;
                        master_read <= 1'b0;
                    end
                end
                `START_READ_INPUT: begin
                    master_read <= 1'b1;
                    master_address <= temp_input_addr;
                    state <= `WAIT_READ_INPUT;
                end
                `WAIT_READ_INPUT: begin
                    if (master_waitrequest == 1'b0 && master_readdatavalid == 1'b1) begin
                        master_read <= 1'b0;
                        input_val <= master_readdata;
                        state <= `CALC_PROD;
                    end
                end
                `CALC_PROD: begin
                    prod <= input_val * weight;
                    state <= `INC;
                end
                `INC: begin
                    // delay 1 cycle to let it write, update addresses, check loop termination condition
                    temp_input_addr <= temp_input_addr + 4;
                    temp_weight_addr <= temp_weight_addr + 4;
                    sum <= sum + prod[47:16];
                    temp_len <= temp_len - 1;
                    if (temp_len - 1 == 0) begin
                        state <= `END;
                    end
                    else begin
                        state <= `START_READ_WEIGHT;
                    end
                end
                `END: begin
                    slave_waitrequest <= 1'd0;
                    slave_readdata <= sum;
                    master_read <= 1'b0;
                    master_write <= 1'b0;
                    master_address <= 32'b0;
                    master_writedata <= 32'b0;
                    sum <= 32'd0;
                    state <= `GET_PARAM;
                end
                default: begin
                    slave_waitrequest <= 1'bx;
                    slave_readdata <= {32{1'bx}};
                    master_read <= 1'bx;
                    master_write <= 1'bx;
                    master_address <= {32{1'bx}};
                    master_writedata <= {32{1'bx}};
                    state <= {4{1'bx}};
                end
            endcase
        end
    end

endmodule: dnn_accelerator