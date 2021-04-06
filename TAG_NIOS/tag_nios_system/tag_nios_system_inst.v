	tag_nios_system u0 (
		.bt_uart_RXD        (<connected-to-bt_uart_RXD>),        //    bt_uart.RXD
		.bt_uart_TXD        (<connected-to-bt_uart_TXD>),        //           .TXD
		.clk_clk            (<connected-to-clk_clk>),            //        clk.clk
		.hex_export         (<connected-to-hex_export>),         //        hex.export
		.pll_locked_export  (<connected-to-pll_locked_export>),  // pll_locked.export
		.reset_reset_n      (<connected-to-reset_reset_n>),      //      reset.reset_n
		.sdram_addr         (<connected-to-sdram_addr>),         //      sdram.addr
		.sdram_ba           (<connected-to-sdram_ba>),           //           .ba
		.sdram_cas_n        (<connected-to-sdram_cas_n>),        //           .cas_n
		.sdram_cke          (<connected-to-sdram_cke>),          //           .cke
		.sdram_cs_n         (<connected-to-sdram_cs_n>),         //           .cs_n
		.sdram_dq           (<connected-to-sdram_dq>),           //           .dq
		.sdram_dqm          (<connected-to-sdram_dqm>),          //           .dqm
		.sdram_ras_n        (<connected-to-sdram_ras_n>),        //           .ras_n
		.sdram_we_n         (<connected-to-sdram_we_n>),         //           .we_n
		.sdram_clk_clk      (<connected-to-sdram_clk_clk>),      //  sdram_clk.clk
		.wifi_uart_RXD      (<connected-to-wifi_uart_RXD>),      //  wifi_uart.RXD
		.wifi_uart_TXD      (<connected-to-wifi_uart_TXD>),      //           .TXD
		.sd_card_b_SD_cmd   (<connected-to-sd_card_b_SD_cmd>),   //    sd_card.b_SD_cmd
		.sd_card_b_SD_dat   (<connected-to-sd_card_b_SD_dat>),   //           .b_SD_dat
		.sd_card_b_SD_dat3  (<connected-to-sd_card_b_SD_dat3>),  //           .b_SD_dat3
		.sd_card_o_SD_clock (<connected-to-sd_card_o_SD_clock>)  //           .o_SD_clock
	);

