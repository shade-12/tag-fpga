//////////////////////////////////////////////////////////////////////////////////
// Top level WHOLE system not just Qsys generated NIOS II system
//////////////////////////////////////////////////////////////////////////////////

module tag_nios_computer(
	// Clock pin
    input logic CLOCK_50,

    // Push buttons
    input logic [3:0] KEY, // KEY[3] is async active-low reset

    // Slider Switches
    input logic [9:0] SW,
    
    // LEDs
    output logic [9:0] LEDR,

    // SDRAM on FPGA Side
    output logic DRAM_CLK,
    output logic DRAM_CKE,
    output logic DRAM_CAS_N,
    output logic DRAM_RAS_N,
    output logic DRAM_WE_N,
    output logic [12:0] DRAM_ADDR,
    output logic [1:0] DRAM_BA,
    output logic DRAM_CS_N,
    inout logic [15:0] DRAM_DQ,
    output logic DRAM_UDQM,
    output logic DRAM_LDQM,

    // Seven Segment Displays
	// These are the names of the 6 seven segment display on the DE1 and those in the PIN Planner,
	// so stick to these names.
    output logic [6:0] HEX0, output logic [6:0] HEX1, output logic [6:0] HEX2,
    output logic [6:0] HEX3, output logic [6:0] HEX4, output logic [6:0] HEX5,

    // 40-Pin Headers
	inout unsigned [35:0] GPIO_0,
	inout unsigned [35:0] GPIO_1
);

    assign HEX1 = 7'b1111111;
    assign HEX2 = 7'b1111111;
    assign HEX3 = 7'b1111111;
    assign HEX4 = 7'b1111111;
    assign HEX5 = 7'b1111111;
    assign LEDR[8:0] = 9'b000000000;

    ///////////////////////////////////////////////////////////////////////////////////////
	// sys is an instanace of the QSYS generated computer
	// map its IO ports as described below
	///////////////////////////////////////////////////////////////////////////////////////

    tag_nios_system sys(
        .clk_clk           (CLOCK_50),
		.reset_reset_n     (KEY[3]),
		.sdram_clk_clk     (DRAM_CLK),
		.pll_locked_export (LEDR[9]),
		.sdram_addr        (DRAM_ADDR),
		.sdram_ba          (DRAM_BA),
		.sdram_cas_n       (DRAM_CAS_N),
		.sdram_cke         (DRAM_CKE),
		.sdram_cs_n        (DRAM_CS_N),
		.sdram_dq          (DRAM_DQ),
		.sdram_dqm         ({DRAM_UDQM, DRAM_LDQM}),
		.sdram_ras_n       (DRAM_RAS_N),
		.sdram_we_n        (DRAM_WE_N),
		.hex_export        (HEX0),
		.bt_uart_RXD       (GPIO_1[18]),
		.bt_uart_TXD       (GPIO_1[19]),
        .wifi_uart_RXD     (GPIO_1[15]),
		.wifi_uart_TXD     (GPIO_1[14])
    );

endmodule: tag_nios_computer