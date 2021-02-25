
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
# ncsim - auto-generated simulation script

# ----------------------------------------
# initialize variables
TOP_LEVEL_NAME="TAG_Computer"
QSYS_SIMDIR="./../"
QUARTUS_INSTALL_DIR="C:/altera/15.0/quartus/"
SKIP_FILE_COPY=0
SKIP_DEV_COM=0
SKIP_COM=0
SKIP_ELAB=0
SKIP_SIM=0
USER_DEFINED_ELAB_OPTIONS=""
USER_DEFINED_SIM_OPTIONS="-input \"@run 100; exit\""

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
if [[ `ncsim -version` != *"ncsim(64)"* ]]; then
  :
else
  :
fi

# ----------------------------------------
# create compilation libraries
mkdir -p ./libraries/work/
mkdir -p ./libraries/altera_common_sv_packages/
mkdir -p ./libraries/error_adapter_0/
mkdir -p ./libraries/border/
mkdir -p ./libraries/rsp_mux/
mkdir -p ./libraries/rsp_demux/
mkdir -p ./libraries/cmd_mux/
mkdir -p ./libraries/cmd_demux/
mkdir -p ./libraries/router_001/
mkdir -p ./libraries/router/
mkdir -p ./libraries/ARM_A9_HPS_f2h_axi_slave_agent/
mkdir -p ./libraries/avalon_st_adapter_001/
mkdir -p ./libraries/avalon_st_adapter/
mkdir -p ./libraries/ARM_A9_HPS_h2f_axi_master_wr_to_SDRAM_s1_cmd_width_adapter/
mkdir -p ./libraries/rsp_mux_002/
mkdir -p ./libraries/rsp_demux_011/
mkdir -p ./libraries/rsp_demux_001/
mkdir -p ./libraries/cmd_mux_011/
mkdir -p ./libraries/cmd_mux_001/
mkdir -p ./libraries/cmd_demux_002/
mkdir -p ./libraries/SDRAM_s1_burst_adapter/
mkdir -p ./libraries/ARM_A9_HPS_h2f_axi_master_wr_limiter/
mkdir -p ./libraries/router_016/
mkdir -p ./libraries/router_008/
mkdir -p ./libraries/router_007/
mkdir -p ./libraries/router_006/
mkdir -p ./libraries/router_005/
mkdir -p ./libraries/router_003/
mkdir -p ./libraries/router_002/
mkdir -p ./libraries/SDRAM_s1_agent/
mkdir -p ./libraries/JTAG_To_FPGA_Bridge_master_agent/
mkdir -p ./libraries/ARM_A9_HPS_h2f_axi_master_agent/
mkdir -p ./libraries/SDRAM_s1_translator/
mkdir -p ./libraries/JTAG_To_FPGA_Bridge_master_translator/
mkdir -p ./libraries/reset_from_locked/
mkdir -p ./libraries/sys_pll/
mkdir -p ./libraries/p2b_adapter/
mkdir -p ./libraries/b2p_adapter/
mkdir -p ./libraries/transacto/
mkdir -p ./libraries/p2b/
mkdir -p ./libraries/b2p/
mkdir -p ./libraries/fifo/
mkdir -p ./libraries/timing_adt/
mkdir -p ./libraries/jtag_phy_embedded_in_jtag_master/
mkdir -p ./libraries/hps_io/
mkdir -p ./libraries/fpga_interfaces/
mkdir -p ./libraries/rst_controller/
mkdir -p ./libraries/irq_mapper_001/
mkdir -p ./libraries/irq_mapper/
mkdir -p ./libraries/mm_interconnect_1/
mkdir -p ./libraries/mm_interconnect_0/
mkdir -p ./libraries/System_PLL/
mkdir -p ./libraries/SysID/
mkdir -p ./libraries/Slider_Switches/
mkdir -p ./libraries/SDRAM/
mkdir -p ./libraries/PushButtons/
mkdir -p ./libraries/Onchip_SRAM/
mkdir -p ./libraries/LEDS/
mkdir -p ./libraries/JTAG_UART_For_ARM0/
mkdir -p ./libraries/JTAG_To_FPGA_Bridge/
mkdir -p ./libraries/Interval_Timer/
mkdir -p ./libraries/IO_Bridge/
mkdir -p ./libraries/HEX0_1/
mkdir -p ./libraries/ARM_A9_HPS/
mkdir -p ./libraries/altera_ver/
mkdir -p ./libraries/lpm_ver/
mkdir -p ./libraries/sgate_ver/
mkdir -p ./libraries/altera_mf_ver/
mkdir -p ./libraries/altera_lnsim_ver/
mkdir -p ./libraries/cyclonev_ver/
mkdir -p ./libraries/cyclonev_hssi_ver/
mkdir -p ./libraries/cyclonev_pcie_hip_ver/

# ----------------------------------------
# copy RAM/ROM files to simulation directory
if [ $SKIP_FILE_COPY -eq 0 ]; then
  cp -f $QSYS_SIMDIR/submodules/TAG_Computer_Onchip_SRAM.hex ./
fi

# ----------------------------------------
# compile device library files
if [ $SKIP_DEV_COM -eq 0 ]; then
  ncvlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v"                      -work altera_ver           
  ncvlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"                               -work lpm_ver              
  ncvlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"                                  -work sgate_ver            
  ncvlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"                              -work altera_mf_ver        
  ncvlog -sv "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"                          -work altera_lnsim_ver     
  ncvlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cadence/cyclonev_atoms_ncrypt.v"          -work cyclonev_ver         
  ncvlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cadence/cyclonev_hmi_atoms_ncrypt.v"      -work cyclonev_ver         
  ncvlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_atoms.v"                         -work cyclonev_ver         
  ncvlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cadence/cyclonev_hssi_atoms_ncrypt.v"     -work cyclonev_hssi_ver    
  ncvlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_hssi_atoms.v"                    -work cyclonev_hssi_ver    
  ncvlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cadence/cyclonev_pcie_hip_atoms_ncrypt.v" -work cyclonev_pcie_hip_ver
  ncvlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_pcie_hip_atoms.v"                -work cyclonev_pcie_hip_ver
fi

# ----------------------------------------
# compile design files in correct order
if [ $SKIP_COM -eq 0 ]; then
  ncvlog -sv "$QSYS_SIMDIR/submodules/verbosity_pkg.sv"                                                        -work altera_common_sv_packages                                  -cdslib ./cds_libs/altera_common_sv_packages.cds.lib                                 
  ncvlog -sv "$QSYS_SIMDIR/submodules/avalon_utilities_pkg.sv"                                                 -work altera_common_sv_packages                                  -cdslib ./cds_libs/altera_common_sv_packages.cds.lib                                 
  ncvlog -sv "$QSYS_SIMDIR/submodules/avalon_mm_pkg.sv"                                                        -work altera_common_sv_packages                                  -cdslib ./cds_libs/altera_common_sv_packages.cds.lib                                 
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_avalon_st_adapter_001_error_adapter_0.sv" -work error_adapter_0                                            -cdslib ./cds_libs/error_adapter_0.cds.lib                                           
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv"     -work error_adapter_0                                            -cdslib ./cds_libs/error_adapter_0.cds.lib                                           
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_mm_slave_bfm.sv"                                           -work border                                                     -cdslib ./cds_libs/border.cds.lib                                                    
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_interrupt_sink.sv"                                         -work border                                                     -cdslib ./cds_libs/border.cds.lib                                                    
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_clock_source.sv"                                           -work border                                                     -cdslib ./cds_libs/border.cds.lib                                                    
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_reset_source.sv"                                           -work border                                                     -cdslib ./cds_libs/border.cds.lib                                                    
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_ARM_A9_HPS_hps_io_border_memory.sv"                         -work border                                                     -cdslib ./cds_libs/border.cds.lib                                                    
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_ARM_A9_HPS_hps_io_border_hps_io.sv"                         -work border                                                     -cdslib ./cds_libs/border.cds.lib                                                    
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_ARM_A9_HPS_hps_io_border.sv"                                -work border                                                     -cdslib ./cds_libs/border.cds.lib                                                    
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                             -work rsp_mux                                                    -cdslib ./cds_libs/rsp_mux.cds.lib                                                   
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_1_rsp_mux.sv"                               -work rsp_mux                                                    -cdslib ./cds_libs/rsp_mux.cds.lib                                                   
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_1_rsp_demux.sv"                             -work rsp_demux                                                  -cdslib ./cds_libs/rsp_demux.cds.lib                                                 
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                             -work cmd_mux                                                    -cdslib ./cds_libs/cmd_mux.cds.lib                                                   
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_1_cmd_mux.sv"                               -work cmd_mux                                                    -cdslib ./cds_libs/cmd_mux.cds.lib                                                   
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_1_cmd_demux.sv"                             -work cmd_demux                                                  -cdslib ./cds_libs/cmd_demux.cds.lib                                                 
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_1_router_001.sv"                            -work router_001                                                 -cdslib ./cds_libs/router_001.cds.lib                                                
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_1_router.sv"                                -work router                                                     -cdslib ./cds_libs/router.cds.lib                                                    
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_axi_slave_ni.sv"                                           -work ARM_A9_HPS_f2h_axi_slave_agent                             -cdslib ./cds_libs/ARM_A9_HPS_f2h_axi_slave_agent.cds.lib                            
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                                     -work ARM_A9_HPS_f2h_axi_slave_agent                             -cdslib ./cds_libs/ARM_A9_HPS_f2h_axi_slave_agent.cds.lib                            
  ncvlog     "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                                 -work ARM_A9_HPS_f2h_axi_slave_agent                             -cdslib ./cds_libs/ARM_A9_HPS_f2h_axi_slave_agent.cds.lib                            
  ncvlog     "$QSYS_SIMDIR/submodules/credit_producer.v"                                                       -work ARM_A9_HPS_f2h_axi_slave_agent                             -cdslib ./cds_libs/ARM_A9_HPS_f2h_axi_slave_agent.cds.lib                            
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                                      -work ARM_A9_HPS_f2h_axi_slave_agent                             -cdslib ./cds_libs/ARM_A9_HPS_f2h_axi_slave_agent.cds.lib                            
  ncvlog     "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_avalon_st_adapter_001.v"                  -work avalon_st_adapter_001                                      -cdslib ./cds_libs/avalon_st_adapter_001.cds.lib                                     
  ncvlog     "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_avalon_st_adapter.v"                      -work avalon_st_adapter                                          -cdslib ./cds_libs/avalon_st_adapter.cds.lib                                         
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_width_adapter.sv"                                          -work ARM_A9_HPS_h2f_axi_master_wr_to_SDRAM_s1_cmd_width_adapter -cdslib ./cds_libs/ARM_A9_HPS_h2f_axi_master_wr_to_SDRAM_s1_cmd_width_adapter.cds.lib
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                                      -work ARM_A9_HPS_h2f_axi_master_wr_to_SDRAM_s1_cmd_width_adapter -cdslib ./cds_libs/ARM_A9_HPS_h2f_axi_master_wr_to_SDRAM_s1_cmd_width_adapter.cds.lib
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                                     -work ARM_A9_HPS_h2f_axi_master_wr_to_SDRAM_s1_cmd_width_adapter -cdslib ./cds_libs/ARM_A9_HPS_h2f_axi_master_wr_to_SDRAM_s1_cmd_width_adapter.cds.lib
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                             -work rsp_mux_002                                                -cdslib ./cds_libs/rsp_mux_002.cds.lib                                               
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_rsp_mux_002.sv"                           -work rsp_mux_002                                                -cdslib ./cds_libs/rsp_mux_002.cds.lib                                               
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                             -work rsp_mux                                                    -cdslib ./cds_libs/rsp_mux.cds.lib                                                   
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_rsp_mux.sv"                               -work rsp_mux                                                    -cdslib ./cds_libs/rsp_mux.cds.lib                                                   
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_rsp_demux_011.sv"                         -work rsp_demux_011                                              -cdslib ./cds_libs/rsp_demux_011.cds.lib                                             
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_rsp_demux_001.sv"                         -work rsp_demux_001                                              -cdslib ./cds_libs/rsp_demux_001.cds.lib                                             
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_rsp_demux.sv"                             -work rsp_demux                                                  -cdslib ./cds_libs/rsp_demux.cds.lib                                                 
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                             -work cmd_mux_011                                                -cdslib ./cds_libs/cmd_mux_011.cds.lib                                               
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_cmd_mux_011.sv"                           -work cmd_mux_011                                                -cdslib ./cds_libs/cmd_mux_011.cds.lib                                               
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                             -work cmd_mux_001                                                -cdslib ./cds_libs/cmd_mux_001.cds.lib                                               
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_cmd_mux_001.sv"                           -work cmd_mux_001                                                -cdslib ./cds_libs/cmd_mux_001.cds.lib                                               
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                             -work cmd_mux                                                    -cdslib ./cds_libs/cmd_mux.cds.lib                                                   
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_cmd_mux.sv"                               -work cmd_mux                                                    -cdslib ./cds_libs/cmd_mux.cds.lib                                                   
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_cmd_demux_002.sv"                         -work cmd_demux_002                                              -cdslib ./cds_libs/cmd_demux_002.cds.lib                                             
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_cmd_demux.sv"                             -work cmd_demux                                                  -cdslib ./cds_libs/cmd_demux.cds.lib                                                 
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter.sv"                                          -work SDRAM_s1_burst_adapter                                     -cdslib ./cds_libs/SDRAM_s1_burst_adapter.cds.lib                                    
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_uncmpr.sv"                                   -work SDRAM_s1_burst_adapter                                     -cdslib ./cds_libs/SDRAM_s1_burst_adapter.cds.lib                                    
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_13_1.sv"                                     -work SDRAM_s1_burst_adapter                                     -cdslib ./cds_libs/SDRAM_s1_burst_adapter.cds.lib                                    
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_new.sv"                                      -work SDRAM_s1_burst_adapter                                     -cdslib ./cds_libs/SDRAM_s1_burst_adapter.cds.lib                                    
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_incr_burst_converter.sv"                                          -work SDRAM_s1_burst_adapter                                     -cdslib ./cds_libs/SDRAM_s1_burst_adapter.cds.lib                                    
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_wrap_burst_converter.sv"                                          -work SDRAM_s1_burst_adapter                                     -cdslib ./cds_libs/SDRAM_s1_burst_adapter.cds.lib                                    
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_default_burst_converter.sv"                                       -work SDRAM_s1_burst_adapter                                     -cdslib ./cds_libs/SDRAM_s1_burst_adapter.cds.lib                                    
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                                      -work SDRAM_s1_burst_adapter                                     -cdslib ./cds_libs/SDRAM_s1_burst_adapter.cds.lib                                    
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_stage.sv"                                      -work SDRAM_s1_burst_adapter                                     -cdslib ./cds_libs/SDRAM_s1_burst_adapter.cds.lib                                    
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                                        -work SDRAM_s1_burst_adapter                                     -cdslib ./cds_libs/SDRAM_s1_burst_adapter.cds.lib                                    
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_traffic_limiter.sv"                                        -work ARM_A9_HPS_h2f_axi_master_wr_limiter                       -cdslib ./cds_libs/ARM_A9_HPS_h2f_axi_master_wr_limiter.cds.lib                      
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_reorder_memory.sv"                                         -work ARM_A9_HPS_h2f_axi_master_wr_limiter                       -cdslib ./cds_libs/ARM_A9_HPS_h2f_axi_master_wr_limiter.cds.lib                      
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                                 -work ARM_A9_HPS_h2f_axi_master_wr_limiter                       -cdslib ./cds_libs/ARM_A9_HPS_h2f_axi_master_wr_limiter.cds.lib                      
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                                        -work ARM_A9_HPS_h2f_axi_master_wr_limiter                       -cdslib ./cds_libs/ARM_A9_HPS_h2f_axi_master_wr_limiter.cds.lib                      
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_router_016.sv"                            -work router_016                                                 -cdslib ./cds_libs/router_016.cds.lib                                                
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_router_008.sv"                            -work router_008                                                 -cdslib ./cds_libs/router_008.cds.lib                                                
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_router_007.sv"                            -work router_007                                                 -cdslib ./cds_libs/router_007.cds.lib                                                
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_router_006.sv"                            -work router_006                                                 -cdslib ./cds_libs/router_006.cds.lib                                                
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_router_005.sv"                            -work router_005                                                 -cdslib ./cds_libs/router_005.cds.lib                                                
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_router_003.sv"                            -work router_003                                                 -cdslib ./cds_libs/router_003.cds.lib                                                
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_router_002.sv"                            -work router_002                                                 -cdslib ./cds_libs/router_002.cds.lib                                                
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_router.sv"                                -work router                                                     -cdslib ./cds_libs/router.cds.lib                                                    
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_slave_agent.sv"                                            -work SDRAM_s1_agent                                             -cdslib ./cds_libs/SDRAM_s1_agent.cds.lib                                            
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                                     -work SDRAM_s1_agent                                             -cdslib ./cds_libs/SDRAM_s1_agent.cds.lib                                            
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_master_agent.sv"                                           -work JTAG_To_FPGA_Bridge_master_agent                           -cdslib ./cds_libs/JTAG_To_FPGA_Bridge_master_agent.cds.lib                          
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_axi_master_ni.sv"                                          -work ARM_A9_HPS_h2f_axi_master_agent                            -cdslib ./cds_libs/ARM_A9_HPS_h2f_axi_master_agent.cds.lib                           
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                                      -work ARM_A9_HPS_h2f_axi_master_agent                            -cdslib ./cds_libs/ARM_A9_HPS_h2f_axi_master_agent.cds.lib                           
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_slave_translator.sv"                                       -work SDRAM_s1_translator                                        -cdslib ./cds_libs/SDRAM_s1_translator.cds.lib                                       
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_master_translator.sv"                                      -work JTAG_To_FPGA_Bridge_master_translator                      -cdslib ./cds_libs/JTAG_To_FPGA_Bridge_master_translator.cds.lib                     
  ncvlog     "$QSYS_SIMDIR/submodules/altera_up_avalon_reset_from_locked_signal.v"                             -work reset_from_locked                                          -cdslib ./cds_libs/reset_from_locked.cds.lib                                         
  ncvlog     "$QSYS_SIMDIR/submodules/TAG_Computer_System_PLL_sys_pll.vo"                                      -work sys_pll                                                    -cdslib ./cds_libs/sys_pll.cds.lib                                                   
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_JTAG_To_FPGA_Bridge_p2b_adapter.sv"                         -work p2b_adapter                                                -cdslib ./cds_libs/p2b_adapter.cds.lib                                               
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_JTAG_To_FPGA_Bridge_b2p_adapter.sv"                         -work b2p_adapter                                                -cdslib ./cds_libs/b2p_adapter.cds.lib                                               
  ncvlog     "$QSYS_SIMDIR/submodules/altera_avalon_packets_to_master.v"                                       -work transacto                                                  -cdslib ./cds_libs/transacto.cds.lib                                                 
  ncvlog     "$QSYS_SIMDIR/submodules/altera_avalon_st_packets_to_bytes.v"                                     -work p2b                                                        -cdslib ./cds_libs/p2b.cds.lib                                                       
  ncvlog     "$QSYS_SIMDIR/submodules/altera_avalon_st_bytes_to_packets.v"                                     -work b2p                                                        -cdslib ./cds_libs/b2p.cds.lib                                                       
  ncvlog     "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                                 -work fifo                                                       -cdslib ./cds_libs/fifo.cds.lib                                                      
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_JTAG_To_FPGA_Bridge_timing_adt.sv"                          -work timing_adt                                                 -cdslib ./cds_libs/timing_adt.cds.lib                                                
  ncvlog     "$QSYS_SIMDIR/submodules/altera_avalon_st_jtag_interface.v"                                       -work jtag_phy_embedded_in_jtag_master                           -cdslib ./cds_libs/jtag_phy_embedded_in_jtag_master.cds.lib                          
  ncvlog     "$QSYS_SIMDIR/submodules/altera_jtag_dc_streaming.v"                                              -work jtag_phy_embedded_in_jtag_master                           -cdslib ./cds_libs/jtag_phy_embedded_in_jtag_master.cds.lib                          
  ncvlog     "$QSYS_SIMDIR/submodules/altera_jtag_sld_node.v"                                                  -work jtag_phy_embedded_in_jtag_master                           -cdslib ./cds_libs/jtag_phy_embedded_in_jtag_master.cds.lib                          
  ncvlog     "$QSYS_SIMDIR/submodules/altera_jtag_streaming.v"                                                 -work jtag_phy_embedded_in_jtag_master                           -cdslib ./cds_libs/jtag_phy_embedded_in_jtag_master.cds.lib                          
  ncvlog     "$QSYS_SIMDIR/submodules/altera_avalon_st_clock_crosser.v"                                        -work jtag_phy_embedded_in_jtag_master                           -cdslib ./cds_libs/jtag_phy_embedded_in_jtag_master.cds.lib                          
  ncvlog     "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                                        -work jtag_phy_embedded_in_jtag_master                           -cdslib ./cds_libs/jtag_phy_embedded_in_jtag_master.cds.lib                          
  ncvlog     "$QSYS_SIMDIR/submodules/altera_avalon_st_idle_remover.v"                                         -work jtag_phy_embedded_in_jtag_master                           -cdslib ./cds_libs/jtag_phy_embedded_in_jtag_master.cds.lib                          
  ncvlog     "$QSYS_SIMDIR/submodules/altera_avalon_st_idle_inserter.v"                                        -work jtag_phy_embedded_in_jtag_master                           -cdslib ./cds_libs/jtag_phy_embedded_in_jtag_master.cds.lib                          
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_stage.sv"                                      -work jtag_phy_embedded_in_jtag_master                           -cdslib ./cds_libs/jtag_phy_embedded_in_jtag_master.cds.lib                          
  ncvlog     "$QSYS_SIMDIR/submodules/TAG_Computer_ARM_A9_HPS_hps_io.v"                                        -work hps_io                                                     -cdslib ./cds_libs/hps_io.cds.lib                                                    
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_mm_slave_bfm.sv"                                           -work fpga_interfaces                                            -cdslib ./cds_libs/fpga_interfaces.cds.lib                                           
  ncvlog -sv "$QSYS_SIMDIR/submodules/questa_mvc_svapi.svh"                                                    -work fpga_interfaces                                            -cdslib ./cds_libs/fpga_interfaces.cds.lib                                           
  ncvlog -sv "$QSYS_SIMDIR/submodules/mgc_common_axi.sv"                                                       -work fpga_interfaces                                            -cdslib ./cds_libs/fpga_interfaces.cds.lib                                           
  ncvlog -sv "$QSYS_SIMDIR/submodules/mgc_axi_master.sv"                                                       -work fpga_interfaces                                            -cdslib ./cds_libs/fpga_interfaces.cds.lib                                           
  ncvlog -sv "$QSYS_SIMDIR/submodules/mgc_axi_slave.sv"                                                        -work fpga_interfaces                                            -cdslib ./cds_libs/fpga_interfaces.cds.lib                                           
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_interrupt_sink.sv"                                         -work fpga_interfaces                                            -cdslib ./cds_libs/fpga_interfaces.cds.lib                                           
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_clock_source.sv"                                           -work fpga_interfaces                                            -cdslib ./cds_libs/fpga_interfaces.cds.lib                                           
  ncvlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_reset_source.sv"                                           -work fpga_interfaces                                            -cdslib ./cds_libs/fpga_interfaces.cds.lib                                           
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_ARM_A9_HPS_fpga_interfaces_h2f_mpu_events.sv"               -work fpga_interfaces                                            -cdslib ./cds_libs/fpga_interfaces.cds.lib                                           
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_ARM_A9_HPS_fpga_interfaces.sv"                              -work fpga_interfaces                                            -cdslib ./cds_libs/fpga_interfaces.cds.lib                                           
  ncvlog     "$QSYS_SIMDIR/submodules/altera_reset_controller.v"                                               -work rst_controller                                             -cdslib ./cds_libs/rst_controller.cds.lib                                            
  ncvlog     "$QSYS_SIMDIR/submodules/altera_reset_synchronizer.v"                                             -work rst_controller                                             -cdslib ./cds_libs/rst_controller.cds.lib                                            
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_irq_mapper_001.sv"                                          -work irq_mapper_001                                             -cdslib ./cds_libs/irq_mapper_001.cds.lib                                            
  ncvlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_irq_mapper.sv"                                              -work irq_mapper                                                 -cdslib ./cds_libs/irq_mapper.cds.lib                                                
  ncvlog     "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_1.v"                                        -work mm_interconnect_1                                          -cdslib ./cds_libs/mm_interconnect_1.cds.lib                                         
  ncvlog     "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0.v"                                        -work mm_interconnect_0                                          -cdslib ./cds_libs/mm_interconnect_0.cds.lib                                         
  ncvlog     "$QSYS_SIMDIR/submodules/TAG_Computer_System_PLL.v"                                               -work System_PLL                                                 -cdslib ./cds_libs/System_PLL.cds.lib                                                
  ncvlog     "$QSYS_SIMDIR/submodules/TAG_Computer_SysID.vo"                                                   -work SysID                                                      -cdslib ./cds_libs/SysID.cds.lib                                                     
  ncvlog     "$QSYS_SIMDIR/submodules/TAG_Computer_Slider_Switches.v"                                          -work Slider_Switches                                            -cdslib ./cds_libs/Slider_Switches.cds.lib                                           
  ncvlog     "$QSYS_SIMDIR/submodules/TAG_Computer_SDRAM.v"                                                    -work SDRAM                                                      -cdslib ./cds_libs/SDRAM.cds.lib                                                     
  ncvlog     "$QSYS_SIMDIR/submodules/TAG_Computer_SDRAM_test_component.v"                                     -work SDRAM                                                      -cdslib ./cds_libs/SDRAM.cds.lib                                                     
  ncvlog     "$QSYS_SIMDIR/submodules/TAG_Computer_PushButtons.v"                                              -work PushButtons                                                -cdslib ./cds_libs/PushButtons.cds.lib                                               
  ncvlog     "$QSYS_SIMDIR/submodules/TAG_Computer_Onchip_SRAM.v"                                              -work Onchip_SRAM                                                -cdslib ./cds_libs/Onchip_SRAM.cds.lib                                               
  ncvlog     "$QSYS_SIMDIR/submodules/TAG_Computer_LEDS.v"                                                     -work LEDS                                                       -cdslib ./cds_libs/LEDS.cds.lib                                                      
  ncvlog     "$QSYS_SIMDIR/submodules/TAG_Computer_JTAG_UART_For_ARM0.v"                                       -work JTAG_UART_For_ARM0                                         -cdslib ./cds_libs/JTAG_UART_For_ARM0.cds.lib                                        
  ncvlog     "$QSYS_SIMDIR/submodules/TAG_Computer_JTAG_To_FPGA_Bridge.v"                                      -work JTAG_To_FPGA_Bridge                                        -cdslib ./cds_libs/JTAG_To_FPGA_Bridge.cds.lib                                       
  ncvlog     "$QSYS_SIMDIR/submodules/TAG_Computer_Interval_Timer.v"                                           -work Interval_Timer                                             -cdslib ./cds_libs/Interval_Timer.cds.lib                                            
  ncvlog     "$QSYS_SIMDIR/submodules/TAG_Computer_IO_Bridge.v"                                                -work IO_Bridge                                                  -cdslib ./cds_libs/IO_Bridge.cds.lib                                                 
  ncvlog     "$QSYS_SIMDIR/submodules/TAG_Computer_HEX0_1.v"                                                   -work HEX0_1                                                     -cdslib ./cds_libs/HEX0_1.cds.lib                                                    
  ncvlog     "$QSYS_SIMDIR/submodules/TAG_Computer_ARM_A9_HPS.v"                                               -work ARM_A9_HPS                                                 -cdslib ./cds_libs/ARM_A9_HPS.cds.lib                                                
  ncvlog     "$QSYS_SIMDIR/TAG_Computer.v"                                                                                                                                                                                                                           
fi

# ----------------------------------------
# elaborate top level design
if [ $SKIP_ELAB -eq 0 ]; then
  ncelab -access +w+r+c -namemap_mixgen $ELAB_OPTIONS $USER_DEFINED_ELAB_OPTIONS $TOP_LEVEL_NAME
fi

# ----------------------------------------
# simulate
if [ $SKIP_SIM -eq 0 ]; then
  eval ncsim -licqueue $SIM_OPTIONS $USER_DEFINED_SIM_OPTIONS $TOP_LEVEL_NAME
fi
