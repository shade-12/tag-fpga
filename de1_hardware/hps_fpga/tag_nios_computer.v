// ##################################################
// tag_nios_computer.v
// ==================================================
// BOARD : DE1-SoC from Terasic
// ###################################################

module tag_nios_computer(

	// ###############################################
    // FPGA pins
    // ###############################################

    // Clock pins
    input CLOCK_50, CLOCK2_50, CLOCK3_50, CLOCK4_50,

    // FPGA-side SDRAM
	output unsigned [12:0] DRAM_ADDR,
	output unsigned [1:0] DRAM_BA,
	output DRAM_CAS_N,
	output DRAM_CKE,
	output DRAM_CLK,
	output DRAM_CS_N,
	inout unsigned [15:0] DRAM_DQ,
	output DRAM_LDQM,
	output DRAM_RAS_N,
	output DRAM_UDQM,
	output DRAM_WE_N,

    // SEG7
	output unsigned [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,

    // KEY
    input unsigned [3:0] KEY,

    // LED
	output unsigned [9:0] LEDR,

    // SW
	input unsigned [9:0] SW,

    // GPIO pins
	inout unsigned [35:0] GPIO_0,
	inout unsigned [35:0] GPIO_1,


    // ###############################################
    // HPS pins
    // ###############################################

    // DDR3 SDRAM
	output unsigned [14:0] HPS_DDR3_ADDR,
	output unsigned [2:0] HPS_DDR3_BA,
	output HPS_DDR3_CAS_N,
	output HPS_DDR3_CKE,
	output HPS_DDR3_CK_N,
	output HPS_DDR3_CK_P,
	output HPS_DDR3_CS_N,
	output unsigned [3:0] HPS_DDR3_DM,
	inout unsigned [31:0] HPS_DDR3_DQ,
	inout unsigned [3:0] HPS_DDR3_DQS_N,
	inout unsigned [3:0] HPS_DDR3_DQS_P,
	output HPS_DDR3_ODT,
	output HPS_DDR3_RAS_N,
	output HPS_DDR3_RESET_N	,
	input HPS_DDR3_RZQ,
	output HPS_DDR3_WE_N,

    // Ethernet
	output HPS_ENET_GTX_CLK,
	inout HPS_ENET_INT_N,
	output HPS_ENET_MDC,
	inout HPS_ENET_MDIO,
	input HPS_ENET_RX_CLK,
	input unsigned [3:0] HPS_ENET_RX_DATA,
	input HPS_ENET_RX_DV,
	output unsigned [3:0] HPS_ENET_TX_DATA,
	output HPS_ENET_TX_EN,

    // Flash
	inout unsigned [3:0] HPS_FLASH_DATA,
	output HPS_FLASH_DCLK,
	output HPS_FLASH_NCSO,
	
	// Accelerometer
	inout HPS_GSENSOR_INT,
			
	// General Purpose I/O
	inout unsigned [1:0] HPS_GPIO,
		
	// I2C
	inout HPS_I2C_CONTROL,
	inout HPS_I2C1_SCLK,
	inout HPS_I2C1_SDAT,
	inout HPS_I2C2_SCLK,
	inout HPS_I2C2_SDAT,
	
	// Pushbutton
	inout HPS_KEY,
	
	// LED
	inout HPS_LED,
			
	// SD Card
	output HPS_SD_CLK,
	inout HPS_SD_CMD,
	inout unsigned [3:0] HPS_SD_DATA,
	
	// SPI
	output HPS_SPIM_CLK,
	input HPS_SPIM_MISO,
	output HPS_SPIM_MOSI,
	inout HPS_SPIM_SS,
	
	// UART
	input HPS_UART_RX,
	output HPS_UART_TX,
	
	// USB
	inout HPS_CONV_USB_N,
	input HPS_USB_CLKOUT,
	inout unsigned [7:0] HPS_USB_DATA,
	input HPS_USB_DIR,
	input HPS_USB_NXT,
	output HPS_USB_STP
);

	wire wifi_reset;

	assign GPIO_1[1] = KEY[0] & wifi_reset;
	assign GPIO_1[10] = 1'b1;	// WIFI_EN
	assign GPIO_1[21] = 1'b0;	// WIFI_UART0_RTS

	assign HEX0 = 7'b1111111;
	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;

	// #######################################################
    // sys is an instanace of the QSYS generated computer
	// map its IO ports as described below
    // #######################################################

    tag_nios_system sys(

        // ###############################################
		// FPGA side
		// ###############################################
		.sdram_clk_clk                   (DRAM_CLK),
		.sdram_addr        				 (DRAM_ADDR),
		.sdram_ba          				 (DRAM_BA),
		.sdram_cas_n       				 (DRAM_CAS_N),
		.sdram_cke         				 (DRAM_CKE),
		.sdram_cs_n        				 (DRAM_CS_N),
		.sdram_dq          				 (DRAM_DQ),
		.sdram_dqm         				 ({DRAM_UDQM, DRAM_LDQM}),
		.sdram_ras_n       				 (DRAM_RAS_N),
		.sdram_we_n        				 (DRAM_WE_N),
		.clk_clk                         (CLOCK_50),
		.reset_reset                     (~KEY[3]),
		.bt_uart_RXD       				 (GPIO_1[18]),
		.bt_uart_TXD       				 (GPIO_1[19]),
        .wifi_uart_RXD     				 (GPIO_1[14]),
		.wifi_uart_TXD     				 (GPIO_1[15]),
		.wifi_reset_export               (wifi_reset),
		.leds_export                     (LEDR),
		.switches_export                 (SW),

		// ###############################################
		// HPS side
		// ###############################################

		// DDR3 SDRAM
		.memory_mem_a                    (HPS_DDR3_ADDR),
		.memory_mem_ba                   (HPS_DDR3_BA),
		.memory_mem_ck                   (HPS_DDR3_CK_P),
		.memory_mem_ck_n                 (HPS_DDR3_CK_N),
		.memory_mem_cke                  (HPS_DDR3_CKE),
		.memory_mem_cs_n                 (HPS_DDR3_CS_N),
		.memory_mem_ras_n                (HPS_DDR3_RAS_N),
		.memory_mem_cas_n                (HPS_DDR3_CAS_N),
		.memory_mem_we_n                 (HPS_DDR3_WE_N),
		.memory_mem_reset_n              (HPS_DDR3_RESET_N),
		.memory_mem_dq                   (HPS_DDR3_DQ),
		.memory_mem_dqs                  (HPS_DDR3_DQS_P),
		.memory_mem_dqs_n                (HPS_DDR3_DQS_N),
		.memory_mem_odt                  (HPS_DDR3_ODT),
		.memory_mem_dm                   (HPS_DDR3_DM),
		.memory_oct_rzqin                (HPS_DDR3_RZQ),

		// Ethernet
		.hps_io_hps_io_gpio_inst_GPIO35	 (HPS_ENET_INT_N),
		.hps_io_hps_io_emac1_inst_TX_CLK (HPS_ENET_GTX_CLK),
		.hps_io_hps_io_emac1_inst_TXD0	 (HPS_ENET_TX_DATA[0]),
		.hps_io_hps_io_emac1_inst_TXD1	 (HPS_ENET_TX_DATA[1]),
		.hps_io_hps_io_emac1_inst_TXD2	 (HPS_ENET_TX_DATA[2]),
		.hps_io_hps_io_emac1_inst_TXD3	 (HPS_ENET_TX_DATA[3]),
		.hps_io_hps_io_emac1_inst_RXD0	 (HPS_ENET_RX_DATA[0]),
		.hps_io_hps_io_emac1_inst_MDIO	 (HPS_ENET_MDIO),
		.hps_io_hps_io_emac1_inst_MDC	 (HPS_ENET_MDC),
		.hps_io_hps_io_emac1_inst_RX_CTL (HPS_ENET_RX_DV),
		.hps_io_hps_io_emac1_inst_TX_CTL (HPS_ENET_TX_EN),
		.hps_io_hps_io_emac1_inst_RX_CLK (HPS_ENET_RX_CLK),
		.hps_io_hps_io_emac1_inst_RXD1	 (HPS_ENET_RX_DATA[1]),
		.hps_io_hps_io_emac1_inst_RXD2	 (HPS_ENET_RX_DATA[2]),
		.hps_io_hps_io_emac1_inst_RXD3	 (HPS_ENET_RX_DATA[3]),

		// Flash
		.hps_io_hps_io_qspi_inst_IO0	 (HPS_FLASH_DATA[0]),
		.hps_io_hps_io_qspi_inst_IO1	 (HPS_FLASH_DATA[1]),
		.hps_io_hps_io_qspi_inst_IO2	 (HPS_FLASH_DATA[2]),
		.hps_io_hps_io_qspi_inst_IO3	 (HPS_FLASH_DATA[3]),
		.hps_io_hps_io_qspi_inst_SS0	 (HPS_FLASH_NCSO),
		.hps_io_hps_io_qspi_inst_CLK	 (HPS_FLASH_DCLK),

		// Accelerometer
		.hps_io_hps_io_gpio_inst_GPIO61	 (HPS_GSENSOR_INT),

		// General Purpose I/O
		.hps_io_hps_io_gpio_inst_GPIO40	 (HPS_GPIO[0]),
		.hps_io_hps_io_gpio_inst_GPIO41	 (HPS_GPIO[1]),

		// I2C
		.hps_io_hps_io_gpio_inst_GPIO48	 (HPS_I2C_CONTROL),
		.hps_io_hps_io_i2c0_inst_SDA	 (HPS_I2C1_SDAT),
		.hps_io_hps_io_i2c0_inst_SCL	 (HPS_I2C1_SCLK),
		.hps_io_hps_io_i2c1_inst_SDA	 (HPS_I2C2_SDAT),
		.hps_io_hps_io_i2c1_inst_SCL	 (HPS_I2C2_SCLK),

		// Pushbutton
		.hps_io_hps_io_gpio_inst_GPIO54	 (HPS_KEY),

		// LED
		.hps_io_hps_io_gpio_inst_GPIO53	 (HPS_LED),

		// SD Card
		.hps_io_hps_io_sdio_inst_CMD	 (HPS_SD_CMD),
		.hps_io_hps_io_sdio_inst_D0		 (HPS_SD_DATA[0]),
		.hps_io_hps_io_sdio_inst_D1		 (HPS_SD_DATA[1]),
		.hps_io_hps_io_sdio_inst_CLK	 (HPS_SD_CLK),
		.hps_io_hps_io_sdio_inst_D2		 (HPS_SD_DATA[2]),
		.hps_io_hps_io_sdio_inst_D3		 (HPS_SD_DATA[3]),

		// SPI
		.hps_io_hps_io_spim1_inst_CLK	 (HPS_SPIM_CLK),
		.hps_io_hps_io_spim1_inst_MOSI	 (HPS_SPIM_MOSI),
		.hps_io_hps_io_spim1_inst_MISO	 (HPS_SPIM_MISO),
		.hps_io_hps_io_spim1_inst_SS0	 (HPS_SPIM_SS),

		// UART
		.hps_io_hps_io_uart0_inst_RX	 (HPS_UART_RX),
		.hps_io_hps_io_uart0_inst_TX	 (HPS_UART_TX),

		// USB
		.hps_io_hps_io_gpio_inst_GPIO09	 (HPS_CONV_USB_N),
		.hps_io_hps_io_usb1_inst_D0		 (HPS_USB_DATA[0]),
		.hps_io_hps_io_usb1_inst_D1		 (HPS_USB_DATA[1]),
		.hps_io_hps_io_usb1_inst_D2		 (HPS_USB_DATA[2]),
		.hps_io_hps_io_usb1_inst_D3		 (HPS_USB_DATA[3]),
		.hps_io_hps_io_usb1_inst_D4		 (HPS_USB_DATA[4]),
		.hps_io_hps_io_usb1_inst_D5		 (HPS_USB_DATA[5]),
		.hps_io_hps_io_usb1_inst_D6		 (HPS_USB_DATA[6]),
		.hps_io_hps_io_usb1_inst_D7		 (HPS_USB_DATA[7]),
		.hps_io_hps_io_usb1_inst_CLK	 (HPS_USB_CLKOUT),
		.hps_io_hps_io_usb1_inst_STP	 (HPS_USB_STP),
		.hps_io_hps_io_usb1_inst_DIR	 (HPS_USB_DIR),
		.hps_io_hps_io_usb1_inst_NXT	 (HPS_USB_NXT)
    );

endmodule