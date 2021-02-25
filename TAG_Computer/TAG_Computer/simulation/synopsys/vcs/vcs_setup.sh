
# (C) 2001-2021 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and 
# other software and tools, and its AMPP partner logic functions, and 
# any output files any of the foregoing (including device programming 
# or simulation files), and any associated documentation or information 
# are expressly subject to the terms and conditions of the Altera 
# Program License Subscription Agreement, Altera MegaCore Function 
# License Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by Altera 
# or its authorized distributors. Please refer to the applicable 
# agreement for further details.

# ACDS 15.0 145 win32 2021.02.25.01:01:48

# ----------------------------------------
# vcs - auto-generated simulation script

# ----------------------------------------
# initialize variables
TOP_LEVEL_NAME="TAG_Computer"
QSYS_SIMDIR="./../../"
QUARTUS_INSTALL_DIR="C:/altera/15.0/quartus/"
SKIP_FILE_COPY=0
SKIP_ELAB=0
SKIP_SIM=0
USER_DEFINED_ELAB_OPTIONS=""
USER_DEFINED_SIM_OPTIONS="+vcs+finish+100"
# ----------------------------------------
# overwrite variables - DO NOT MODIFY!
# This block evaluates each command line argument, typically used for 
# overwriting variables. An example usage:
#   sh <simulator>_setup.sh SKIP_ELAB=1 SKIP_SIM=1
for expression in "$@"; do
  eval $expression
  if [ $? -ne 0 ]; then
    echo "Error: This command line argument, \"$expression\", is/has an invalid expression." >&2
    exit $?
  fi
done

# ----------------------------------------
# initialize simulation properties - DO NOT MODIFY!
ELAB_OPTIONS=""
SIM_OPTIONS=""
if [[ `vcs -platform` != *"amd64"* ]]; then
  :
else
  :
fi

# ----------------------------------------
# copy RAM/ROM files to simulation directory
if [ $SKIP_FILE_COPY -eq 0 ]; then
  cp -f $QSYS_SIMDIR/submodules/TAG_Computer_Onchip_SRAM.hex ./
fi

vcs -lca -timescale=1ps/1ps -sverilog +verilog2001ext+.v -ntb_opts dtm $ELAB_OPTIONS $USER_DEFINED_ELAB_OPTIONS \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v \
  $QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/synopsys/cyclonev_atoms_ncrypt.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/synopsys/cyclonev_hmi_atoms_ncrypt.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_atoms.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/synopsys/cyclonev_hssi_atoms_ncrypt.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_hssi_atoms.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/synopsys/cyclonev_pcie_hip_atoms_ncrypt.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_pcie_hip_atoms.v \
  $QSYS_SIMDIR/submodules/verbosity_pkg.sv \
  $QSYS_SIMDIR/submodules/avalon_utilities_pkg.sv \
  $QSYS_SIMDIR/submodules/avalon_mm_pkg.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_avalon_st_adapter_001_error_adapter_0.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv \
  $QSYS_SIMDIR/submodules/altera_avalon_mm_slave_bfm.sv \
  $QSYS_SIMDIR/submodules/altera_avalon_interrupt_sink.sv \
  $QSYS_SIMDIR/submodules/altera_avalon_clock_source.sv \
  $QSYS_SIMDIR/submodules/altera_avalon_reset_source.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_ARM_A9_HPS_hps_io_border_memory.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_ARM_A9_HPS_hps_io_border_hps_io.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_ARM_A9_HPS_hps_io_border.sv \
  $QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_1_rsp_mux.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_1_rsp_demux.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_1_cmd_mux.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_1_cmd_demux.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_1_router_001.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_1_router.sv \
  $QSYS_SIMDIR/submodules/altera_merlin_axi_slave_ni.sv \
  $QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv \
  $QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v \
  $QSYS_SIMDIR/submodules/credit_producer.v \
  $QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_avalon_st_adapter_001.v \
  $QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_avalon_st_adapter.v \
  $QSYS_SIMDIR/submodules/altera_merlin_width_adapter.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_rsp_mux_002.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_rsp_mux.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_rsp_demux_011.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_rsp_demux_001.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_rsp_demux.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_cmd_mux_011.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_cmd_mux_001.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_cmd_mux.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_cmd_demux_002.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_cmd_demux.sv \
  $QSYS_SIMDIR/submodules/altera_merlin_burst_adapter.sv \
  $QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_uncmpr.sv \
  $QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_13_1.sv \
  $QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_new.sv \
  $QSYS_SIMDIR/submodules/altera_incr_burst_converter.sv \
  $QSYS_SIMDIR/submodules/altera_wrap_burst_converter.sv \
  $QSYS_SIMDIR/submodules/altera_default_burst_converter.sv \
  $QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_stage.sv \
  $QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v \
  $QSYS_SIMDIR/submodules/altera_merlin_traffic_limiter.sv \
  $QSYS_SIMDIR/submodules/altera_merlin_reorder_memory.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_router_016.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_router_008.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_router_007.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_router_006.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_router_005.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_router_003.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_router_002.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_router.sv \
  $QSYS_SIMDIR/submodules/altera_merlin_slave_agent.sv \
  $QSYS_SIMDIR/submodules/altera_merlin_master_agent.sv \
  $QSYS_SIMDIR/submodules/altera_merlin_axi_master_ni.sv \
  $QSYS_SIMDIR/submodules/altera_merlin_slave_translator.sv \
  $QSYS_SIMDIR/submodules/altera_merlin_master_translator.sv \
  $QSYS_SIMDIR/submodules/altera_up_avalon_reset_from_locked_signal.v \
  $QSYS_SIMDIR/submodules/TAG_Computer_System_PLL_sys_pll.vo \
  $QSYS_SIMDIR/submodules/TAG_Computer_JTAG_To_FPGA_Bridge_p2b_adapter.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_JTAG_To_FPGA_Bridge_b2p_adapter.sv \
  $QSYS_SIMDIR/submodules/altera_avalon_packets_to_master.v \
  $QSYS_SIMDIR/submodules/altera_avalon_st_packets_to_bytes.v \
  $QSYS_SIMDIR/submodules/altera_avalon_st_bytes_to_packets.v \
  $QSYS_SIMDIR/submodules/TAG_Computer_JTAG_To_FPGA_Bridge_timing_adt.sv \
  $QSYS_SIMDIR/submodules/altera_avalon_st_jtag_interface.v \
  $QSYS_SIMDIR/submodules/altera_jtag_dc_streaming.v \
  $QSYS_SIMDIR/submodules/altera_jtag_sld_node.v \
  $QSYS_SIMDIR/submodules/altera_jtag_streaming.v \
  $QSYS_SIMDIR/submodules/altera_avalon_st_clock_crosser.v \
  $QSYS_SIMDIR/submodules/altera_avalon_st_idle_remover.v \
  $QSYS_SIMDIR/submodules/altera_avalon_st_idle_inserter.v \
  $QSYS_SIMDIR/submodules/TAG_Computer_ARM_A9_HPS_hps_io.v \
  $QSYS_SIMDIR/submodules/questa_mvc_svapi.svh \
  $QSYS_SIMDIR/submodules/mgc_common_axi.sv \
  $QSYS_SIMDIR/submodules/mgc_axi_master.sv \
  $QSYS_SIMDIR/submodules/mgc_axi_slave.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_ARM_A9_HPS_fpga_interfaces_h2f_mpu_events.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_ARM_A9_HPS_fpga_interfaces.sv \
  $QSYS_SIMDIR/submodules/altera_reset_controller.v \
  $QSYS_SIMDIR/submodules/altera_reset_synchronizer.v \
  $QSYS_SIMDIR/submodules/TAG_Computer_irq_mapper_001.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_irq_mapper.sv \
  $QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_1.v \
  $QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0.v \
  $QSYS_SIMDIR/submodules/TAG_Computer_System_PLL.v \
  $QSYS_SIMDIR/submodules/TAG_Computer_SysID.vo \
  $QSYS_SIMDIR/submodules/TAG_Computer_Slider_Switches.v \
  $QSYS_SIMDIR/submodules/TAG_Computer_SDRAM.v \
  $QSYS_SIMDIR/submodules/TAG_Computer_SDRAM_test_component.v \
  $QSYS_SIMDIR/submodules/TAG_Computer_PushButtons.v \
  $QSYS_SIMDIR/submodules/TAG_Computer_Onchip_SRAM.v \
  $QSYS_SIMDIR/submodules/TAG_Computer_LEDS.v \
  $QSYS_SIMDIR/submodules/TAG_Computer_JTAG_UART_For_ARM0.v \
  $QSYS_SIMDIR/submodules/TAG_Computer_JTAG_To_FPGA_Bridge.v \
  $QSYS_SIMDIR/submodules/TAG_Computer_Interval_Timer.v \
  $QSYS_SIMDIR/submodules/TAG_Computer_IO_Bridge.v \
  $QSYS_SIMDIR/submodules/TAG_Computer_HEX0_1.v \
  $QSYS_SIMDIR/submodules/TAG_Computer_ARM_A9_HPS.v \
  $QSYS_SIMDIR/TAG_Computer.v \
  -top $TOP_LEVEL_NAME
# ----------------------------------------
# simulate
if [ $SKIP_SIM -eq 0 ]; then
  ./simv $SIM_OPTIONS $USER_DEFINED_SIM_OPTIONS
fi
