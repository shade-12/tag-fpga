
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
# Auto-generated simulation script

# ----------------------------------------
# Initialize variables
if ![info exists SYSTEM_INSTANCE_NAME] { 
  set SYSTEM_INSTANCE_NAME ""
} elseif { ![ string match "" $SYSTEM_INSTANCE_NAME ] } { 
  set SYSTEM_INSTANCE_NAME "/$SYSTEM_INSTANCE_NAME"
}

if ![info exists TOP_LEVEL_NAME] { 
  set TOP_LEVEL_NAME "TAG_Computer"
}

if ![info exists QSYS_SIMDIR] { 
  set QSYS_SIMDIR "./../"
}

if ![info exists QUARTUS_INSTALL_DIR] { 
  set QUARTUS_INSTALL_DIR "C:/altera/15.0/quartus/"
}

# ----------------------------------------
# Initialize simulation properties - DO NOT MODIFY!
set ELAB_OPTIONS ""
set SIM_OPTIONS ""
if ![ string match "*-64 vsim*" [ vsim -version ] ] {
} else {
}

# ----------------------------------------
# Copy ROM/RAM files to simulation directory
alias file_copy {
  echo "\[exec\] file_copy"
  file copy -force $QSYS_SIMDIR/submodules/TAG_Computer_Onchip_SRAM.hex ./
}

# ----------------------------------------
# Create compilation libraries
proc ensure_lib { lib } { if ![file isdirectory $lib] { vlib $lib } }
ensure_lib          ./libraries/     
ensure_lib          ./libraries/work/
vmap       work     ./libraries/work/
vmap       work_lib ./libraries/work/
if ![ string match "*ModelSim ALTERA*" [ vsim -version ] ] {
  ensure_lib                       ./libraries/altera_ver/           
  vmap       altera_ver            ./libraries/altera_ver/           
  ensure_lib                       ./libraries/lpm_ver/              
  vmap       lpm_ver               ./libraries/lpm_ver/              
  ensure_lib                       ./libraries/sgate_ver/            
  vmap       sgate_ver             ./libraries/sgate_ver/            
  ensure_lib                       ./libraries/altera_mf_ver/        
  vmap       altera_mf_ver         ./libraries/altera_mf_ver/        
  ensure_lib                       ./libraries/altera_lnsim_ver/     
  vmap       altera_lnsim_ver      ./libraries/altera_lnsim_ver/     
  ensure_lib                       ./libraries/cyclonev_ver/         
  vmap       cyclonev_ver          ./libraries/cyclonev_ver/         
  ensure_lib                       ./libraries/cyclonev_hssi_ver/    
  vmap       cyclonev_hssi_ver     ./libraries/cyclonev_hssi_ver/    
  ensure_lib                       ./libraries/cyclonev_pcie_hip_ver/
  vmap       cyclonev_pcie_hip_ver ./libraries/cyclonev_pcie_hip_ver/
}
ensure_lib                                                            ./libraries/altera_common_sv_packages/                                 
vmap       altera_common_sv_packages                                  ./libraries/altera_common_sv_packages/                                 
ensure_lib                                                            ./libraries/error_adapter_0/                                           
vmap       error_adapter_0                                            ./libraries/error_adapter_0/                                           
ensure_lib                                                            ./libraries/border/                                                    
vmap       border                                                     ./libraries/border/                                                    
ensure_lib                                                            ./libraries/rsp_mux/                                                   
vmap       rsp_mux                                                    ./libraries/rsp_mux/                                                   
ensure_lib                                                            ./libraries/rsp_demux/                                                 
vmap       rsp_demux                                                  ./libraries/rsp_demux/                                                 
ensure_lib                                                            ./libraries/cmd_mux/                                                   
vmap       cmd_mux                                                    ./libraries/cmd_mux/                                                   
ensure_lib                                                            ./libraries/cmd_demux/                                                 
vmap       cmd_demux                                                  ./libraries/cmd_demux/                                                 
ensure_lib                                                            ./libraries/router_001/                                                
vmap       router_001                                                 ./libraries/router_001/                                                
ensure_lib                                                            ./libraries/router/                                                    
vmap       router                                                     ./libraries/router/                                                    
ensure_lib                                                            ./libraries/ARM_A9_HPS_f2h_axi_slave_agent/                            
vmap       ARM_A9_HPS_f2h_axi_slave_agent                             ./libraries/ARM_A9_HPS_f2h_axi_slave_agent/                            
ensure_lib                                                            ./libraries/avalon_st_adapter_001/                                     
vmap       avalon_st_adapter_001                                      ./libraries/avalon_st_adapter_001/                                     
ensure_lib                                                            ./libraries/avalon_st_adapter/                                         
vmap       avalon_st_adapter                                          ./libraries/avalon_st_adapter/                                         
ensure_lib                                                            ./libraries/ARM_A9_HPS_h2f_axi_master_wr_to_SDRAM_s1_cmd_width_adapter/
vmap       ARM_A9_HPS_h2f_axi_master_wr_to_SDRAM_s1_cmd_width_adapter ./libraries/ARM_A9_HPS_h2f_axi_master_wr_to_SDRAM_s1_cmd_width_adapter/
ensure_lib                                                            ./libraries/rsp_mux_002/                                               
vmap       rsp_mux_002                                                ./libraries/rsp_mux_002/                                               
ensure_lib                                                            ./libraries/rsp_demux_011/                                             
vmap       rsp_demux_011                                              ./libraries/rsp_demux_011/                                             
ensure_lib                                                            ./libraries/rsp_demux_001/                                             
vmap       rsp_demux_001                                              ./libraries/rsp_demux_001/                                             
ensure_lib                                                            ./libraries/cmd_mux_011/                                               
vmap       cmd_mux_011                                                ./libraries/cmd_mux_011/                                               
ensure_lib                                                            ./libraries/cmd_mux_001/                                               
vmap       cmd_mux_001                                                ./libraries/cmd_mux_001/                                               
ensure_lib                                                            ./libraries/cmd_demux_002/                                             
vmap       cmd_demux_002                                              ./libraries/cmd_demux_002/                                             
ensure_lib                                                            ./libraries/SDRAM_s1_burst_adapter/                                    
vmap       SDRAM_s1_burst_adapter                                     ./libraries/SDRAM_s1_burst_adapter/                                    
ensure_lib                                                            ./libraries/ARM_A9_HPS_h2f_axi_master_wr_limiter/                      
vmap       ARM_A9_HPS_h2f_axi_master_wr_limiter                       ./libraries/ARM_A9_HPS_h2f_axi_master_wr_limiter/                      
ensure_lib                                                            ./libraries/router_016/                                                
vmap       router_016                                                 ./libraries/router_016/                                                
ensure_lib                                                            ./libraries/router_008/                                                
vmap       router_008                                                 ./libraries/router_008/                                                
ensure_lib                                                            ./libraries/router_007/                                                
vmap       router_007                                                 ./libraries/router_007/                                                
ensure_lib                                                            ./libraries/router_006/                                                
vmap       router_006                                                 ./libraries/router_006/                                                
ensure_lib                                                            ./libraries/router_005/                                                
vmap       router_005                                                 ./libraries/router_005/                                                
ensure_lib                                                            ./libraries/router_003/                                                
vmap       router_003                                                 ./libraries/router_003/                                                
ensure_lib                                                            ./libraries/router_002/                                                
vmap       router_002                                                 ./libraries/router_002/                                                
ensure_lib                                                            ./libraries/SDRAM_s1_agent/                                            
vmap       SDRAM_s1_agent                                             ./libraries/SDRAM_s1_agent/                                            
ensure_lib                                                            ./libraries/JTAG_To_FPGA_Bridge_master_agent/                          
vmap       JTAG_To_FPGA_Bridge_master_agent                           ./libraries/JTAG_To_FPGA_Bridge_master_agent/                          
ensure_lib                                                            ./libraries/ARM_A9_HPS_h2f_axi_master_agent/                           
vmap       ARM_A9_HPS_h2f_axi_master_agent                            ./libraries/ARM_A9_HPS_h2f_axi_master_agent/                           
ensure_lib                                                            ./libraries/SDRAM_s1_translator/                                       
vmap       SDRAM_s1_translator                                        ./libraries/SDRAM_s1_translator/                                       
ensure_lib                                                            ./libraries/JTAG_To_FPGA_Bridge_master_translator/                     
vmap       JTAG_To_FPGA_Bridge_master_translator                      ./libraries/JTAG_To_FPGA_Bridge_master_translator/                     
ensure_lib                                                            ./libraries/reset_from_locked/                                         
vmap       reset_from_locked                                          ./libraries/reset_from_locked/                                         
ensure_lib                                                            ./libraries/sys_pll/                                                   
vmap       sys_pll                                                    ./libraries/sys_pll/                                                   
ensure_lib                                                            ./libraries/p2b_adapter/                                               
vmap       p2b_adapter                                                ./libraries/p2b_adapter/                                               
ensure_lib                                                            ./libraries/b2p_adapter/                                               
vmap       b2p_adapter                                                ./libraries/b2p_adapter/                                               
ensure_lib                                                            ./libraries/transacto/                                                 
vmap       transacto                                                  ./libraries/transacto/                                                 
ensure_lib                                                            ./libraries/p2b/                                                       
vmap       p2b                                                        ./libraries/p2b/                                                       
ensure_lib                                                            ./libraries/b2p/                                                       
vmap       b2p                                                        ./libraries/b2p/                                                       
ensure_lib                                                            ./libraries/fifo/                                                      
vmap       fifo                                                       ./libraries/fifo/                                                      
ensure_lib                                                            ./libraries/timing_adt/                                                
vmap       timing_adt                                                 ./libraries/timing_adt/                                                
ensure_lib                                                            ./libraries/jtag_phy_embedded_in_jtag_master/                          
vmap       jtag_phy_embedded_in_jtag_master                           ./libraries/jtag_phy_embedded_in_jtag_master/                          
ensure_lib                                                            ./libraries/hps_io/                                                    
vmap       hps_io                                                     ./libraries/hps_io/                                                    
ensure_lib                                                            ./libraries/fpga_interfaces/                                           
vmap       fpga_interfaces                                            ./libraries/fpga_interfaces/                                           
ensure_lib                                                            ./libraries/rst_controller/                                            
vmap       rst_controller                                             ./libraries/rst_controller/                                            
ensure_lib                                                            ./libraries/irq_mapper_001/                                            
vmap       irq_mapper_001                                             ./libraries/irq_mapper_001/                                            
ensure_lib                                                            ./libraries/irq_mapper/                                                
vmap       irq_mapper                                                 ./libraries/irq_mapper/                                                
ensure_lib                                                            ./libraries/mm_interconnect_1/                                         
vmap       mm_interconnect_1                                          ./libraries/mm_interconnect_1/                                         
ensure_lib                                                            ./libraries/mm_interconnect_0/                                         
vmap       mm_interconnect_0                                          ./libraries/mm_interconnect_0/                                         
ensure_lib                                                            ./libraries/System_PLL/                                                
vmap       System_PLL                                                 ./libraries/System_PLL/                                                
ensure_lib                                                            ./libraries/SysID/                                                     
vmap       SysID                                                      ./libraries/SysID/                                                     
ensure_lib                                                            ./libraries/Slider_Switches/                                           
vmap       Slider_Switches                                            ./libraries/Slider_Switches/                                           
ensure_lib                                                            ./libraries/SDRAM/                                                     
vmap       SDRAM                                                      ./libraries/SDRAM/                                                     
ensure_lib                                                            ./libraries/PushButtons/                                               
vmap       PushButtons                                                ./libraries/PushButtons/                                               
ensure_lib                                                            ./libraries/Onchip_SRAM/                                               
vmap       Onchip_SRAM                                                ./libraries/Onchip_SRAM/                                               
ensure_lib                                                            ./libraries/LEDS/                                                      
vmap       LEDS                                                       ./libraries/LEDS/                                                      
ensure_lib                                                            ./libraries/JTAG_UART_For_ARM0/                                        
vmap       JTAG_UART_For_ARM0                                         ./libraries/JTAG_UART_For_ARM0/                                        
ensure_lib                                                            ./libraries/JTAG_To_FPGA_Bridge/                                       
vmap       JTAG_To_FPGA_Bridge                                        ./libraries/JTAG_To_FPGA_Bridge/                                       
ensure_lib                                                            ./libraries/Interval_Timer/                                            
vmap       Interval_Timer                                             ./libraries/Interval_Timer/                                            
ensure_lib                                                            ./libraries/IO_Bridge/                                                 
vmap       IO_Bridge                                                  ./libraries/IO_Bridge/                                                 
ensure_lib                                                            ./libraries/HEX0_1/                                                    
vmap       HEX0_1                                                     ./libraries/HEX0_1/                                                    
ensure_lib                                                            ./libraries/ARM_A9_HPS/                                                
vmap       ARM_A9_HPS                                                 ./libraries/ARM_A9_HPS/                                                

# ----------------------------------------
# Compile device library files
alias dev_com {
  echo "\[exec\] dev_com"
  if ![ string match "*ModelSim ALTERA*" [ vsim -version ] ] {
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v"                     -work altera_ver           
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"                              -work lpm_ver              
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"                                 -work sgate_ver            
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"                             -work altera_mf_ver        
    vlog -sv "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"                         -work altera_lnsim_ver     
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/cyclonev_atoms_ncrypt.v"          -work cyclonev_ver         
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/cyclonev_hmi_atoms_ncrypt.v"      -work cyclonev_ver         
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_atoms.v"                        -work cyclonev_ver         
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/cyclonev_hssi_atoms_ncrypt.v"     -work cyclonev_hssi_ver    
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_hssi_atoms.v"                   -work cyclonev_hssi_ver    
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/cyclonev_pcie_hip_atoms_ncrypt.v" -work cyclonev_pcie_hip_ver
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_pcie_hip_atoms.v"               -work cyclonev_pcie_hip_ver
  }
}

# ----------------------------------------
# Compile the design files in correct order
alias com {
  echo "\[exec\] com"
  vlog -sv "$QSYS_SIMDIR/submodules/verbosity_pkg.sv"                                                                                     -work altera_common_sv_packages                                 
  vlog -sv "$QSYS_SIMDIR/submodules/avalon_utilities_pkg.sv"                                                                              -work altera_common_sv_packages                                 
  vlog -sv "$QSYS_SIMDIR/submodules/avalon_mm_pkg.sv"                                                                                     -work altera_common_sv_packages                                 
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_avalon_st_adapter_001_error_adapter_0.sv" -L altera_common_sv_packages -work error_adapter_0                                           
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv"     -L altera_common_sv_packages -work error_adapter_0                                           
  vlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_mm_slave_bfm.sv"                                           -L altera_common_sv_packages -work border                                                    
  vlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_interrupt_sink.sv"                                         -L altera_common_sv_packages -work border                                                    
  vlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_clock_source.sv"                                           -L altera_common_sv_packages -work border                                                    
  vlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_reset_source.sv"                                           -L altera_common_sv_packages -work border                                                    
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_ARM_A9_HPS_hps_io_border_memory.sv"                         -L altera_common_sv_packages -work border                                                    
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_ARM_A9_HPS_hps_io_border_hps_io.sv"                         -L altera_common_sv_packages -work border                                                    
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_ARM_A9_HPS_hps_io_border.sv"                                -L altera_common_sv_packages -work border                                                    
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                             -L altera_common_sv_packages -work rsp_mux                                                   
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_1_rsp_mux.sv"                               -L altera_common_sv_packages -work rsp_mux                                                   
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_1_rsp_demux.sv"                             -L altera_common_sv_packages -work rsp_demux                                                 
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                             -L altera_common_sv_packages -work cmd_mux                                                   
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_1_cmd_mux.sv"                               -L altera_common_sv_packages -work cmd_mux                                                   
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_1_cmd_demux.sv"                             -L altera_common_sv_packages -work cmd_demux                                                 
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_1_router_001.sv"                            -L altera_common_sv_packages -work router_001                                                
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_1_router.sv"                                -L altera_common_sv_packages -work router                                                    
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_axi_slave_ni.sv"                                           -L altera_common_sv_packages -work ARM_A9_HPS_f2h_axi_slave_agent                            
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                                     -L altera_common_sv_packages -work ARM_A9_HPS_f2h_axi_slave_agent                            
  vlog     "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                                                              -work ARM_A9_HPS_f2h_axi_slave_agent                            
  vlog     "$QSYS_SIMDIR/submodules/credit_producer.v"                                                                                    -work ARM_A9_HPS_f2h_axi_slave_agent                            
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                                      -L altera_common_sv_packages -work ARM_A9_HPS_f2h_axi_slave_agent                            
  vlog     "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_avalon_st_adapter_001.v"                                               -work avalon_st_adapter_001                                     
  vlog     "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_avalon_st_adapter.v"                                                   -work avalon_st_adapter                                         
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_width_adapter.sv"                                          -L altera_common_sv_packages -work ARM_A9_HPS_h2f_axi_master_wr_to_SDRAM_s1_cmd_width_adapter
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                                      -L altera_common_sv_packages -work ARM_A9_HPS_h2f_axi_master_wr_to_SDRAM_s1_cmd_width_adapter
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                                     -L altera_common_sv_packages -work ARM_A9_HPS_h2f_axi_master_wr_to_SDRAM_s1_cmd_width_adapter
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                             -L altera_common_sv_packages -work rsp_mux_002                                               
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_rsp_mux_002.sv"                           -L altera_common_sv_packages -work rsp_mux_002                                               
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                             -L altera_common_sv_packages -work rsp_mux                                                   
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_rsp_mux.sv"                               -L altera_common_sv_packages -work rsp_mux                                                   
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_rsp_demux_011.sv"                         -L altera_common_sv_packages -work rsp_demux_011                                             
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_rsp_demux_001.sv"                         -L altera_common_sv_packages -work rsp_demux_001                                             
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_rsp_demux.sv"                             -L altera_common_sv_packages -work rsp_demux                                                 
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                             -L altera_common_sv_packages -work cmd_mux_011                                               
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_cmd_mux_011.sv"                           -L altera_common_sv_packages -work cmd_mux_011                                               
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                             -L altera_common_sv_packages -work cmd_mux_001                                               
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_cmd_mux_001.sv"                           -L altera_common_sv_packages -work cmd_mux_001                                               
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                             -L altera_common_sv_packages -work cmd_mux                                                   
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_cmd_mux.sv"                               -L altera_common_sv_packages -work cmd_mux                                                   
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_cmd_demux_002.sv"                         -L altera_common_sv_packages -work cmd_demux_002                                             
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_cmd_demux.sv"                             -L altera_common_sv_packages -work cmd_demux                                                 
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter.sv"                                          -L altera_common_sv_packages -work SDRAM_s1_burst_adapter                                    
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_uncmpr.sv"                                   -L altera_common_sv_packages -work SDRAM_s1_burst_adapter                                    
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_13_1.sv"                                     -L altera_common_sv_packages -work SDRAM_s1_burst_adapter                                    
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_new.sv"                                      -L altera_common_sv_packages -work SDRAM_s1_burst_adapter                                    
  vlog -sv "$QSYS_SIMDIR/submodules/altera_incr_burst_converter.sv"                                          -L altera_common_sv_packages -work SDRAM_s1_burst_adapter                                    
  vlog -sv "$QSYS_SIMDIR/submodules/altera_wrap_burst_converter.sv"                                          -L altera_common_sv_packages -work SDRAM_s1_burst_adapter                                    
  vlog -sv "$QSYS_SIMDIR/submodules/altera_default_burst_converter.sv"                                       -L altera_common_sv_packages -work SDRAM_s1_burst_adapter                                    
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                                      -L altera_common_sv_packages -work SDRAM_s1_burst_adapter                                    
  vlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_stage.sv"                                      -L altera_common_sv_packages -work SDRAM_s1_burst_adapter                                    
  vlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                                        -L altera_common_sv_packages -work SDRAM_s1_burst_adapter                                    
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_traffic_limiter.sv"                                        -L altera_common_sv_packages -work ARM_A9_HPS_h2f_axi_master_wr_limiter                      
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_reorder_memory.sv"                                         -L altera_common_sv_packages -work ARM_A9_HPS_h2f_axi_master_wr_limiter                      
  vlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                                 -L altera_common_sv_packages -work ARM_A9_HPS_h2f_axi_master_wr_limiter                      
  vlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                                        -L altera_common_sv_packages -work ARM_A9_HPS_h2f_axi_master_wr_limiter                      
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_router_016.sv"                            -L altera_common_sv_packages -work router_016                                                
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_router_008.sv"                            -L altera_common_sv_packages -work router_008                                                
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_router_007.sv"                            -L altera_common_sv_packages -work router_007                                                
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_router_006.sv"                            -L altera_common_sv_packages -work router_006                                                
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_router_005.sv"                            -L altera_common_sv_packages -work router_005                                                
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_router_003.sv"                            -L altera_common_sv_packages -work router_003                                                
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_router_002.sv"                            -L altera_common_sv_packages -work router_002                                                
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0_router.sv"                                -L altera_common_sv_packages -work router                                                    
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_slave_agent.sv"                                            -L altera_common_sv_packages -work SDRAM_s1_agent                                            
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                                     -L altera_common_sv_packages -work SDRAM_s1_agent                                            
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_master_agent.sv"                                           -L altera_common_sv_packages -work JTAG_To_FPGA_Bridge_master_agent                          
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_axi_master_ni.sv"                                          -L altera_common_sv_packages -work ARM_A9_HPS_h2f_axi_master_agent                           
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                                      -L altera_common_sv_packages -work ARM_A9_HPS_h2f_axi_master_agent                           
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_slave_translator.sv"                                       -L altera_common_sv_packages -work SDRAM_s1_translator                                       
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_master_translator.sv"                                      -L altera_common_sv_packages -work JTAG_To_FPGA_Bridge_master_translator                     
  vlog     "$QSYS_SIMDIR/submodules/altera_up_avalon_reset_from_locked_signal.v"                                                          -work reset_from_locked                                         
  vlog     "$QSYS_SIMDIR/submodules/TAG_Computer_System_PLL_sys_pll.vo"                                                                   -work sys_pll                                                   
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_JTAG_To_FPGA_Bridge_p2b_adapter.sv"                         -L altera_common_sv_packages -work p2b_adapter                                               
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_JTAG_To_FPGA_Bridge_b2p_adapter.sv"                         -L altera_common_sv_packages -work b2p_adapter                                               
  vlog     "$QSYS_SIMDIR/submodules/altera_avalon_packets_to_master.v"                                                                    -work transacto                                                 
  vlog     "$QSYS_SIMDIR/submodules/altera_avalon_st_packets_to_bytes.v"                                                                  -work p2b                                                       
  vlog     "$QSYS_SIMDIR/submodules/altera_avalon_st_bytes_to_packets.v"                                                                  -work b2p                                                       
  vlog     "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                                                              -work fifo                                                      
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_JTAG_To_FPGA_Bridge_timing_adt.sv"                          -L altera_common_sv_packages -work timing_adt                                                
  vlog     "$QSYS_SIMDIR/submodules/altera_avalon_st_jtag_interface.v"                                                                    -work jtag_phy_embedded_in_jtag_master                          
  vlog     "$QSYS_SIMDIR/submodules/altera_jtag_dc_streaming.v"                                                                           -work jtag_phy_embedded_in_jtag_master                          
  vlog     "$QSYS_SIMDIR/submodules/altera_jtag_sld_node.v"                                                                               -work jtag_phy_embedded_in_jtag_master                          
  vlog     "$QSYS_SIMDIR/submodules/altera_jtag_streaming.v"                                                                              -work jtag_phy_embedded_in_jtag_master                          
  vlog     "$QSYS_SIMDIR/submodules/altera_avalon_st_clock_crosser.v"                                                                     -work jtag_phy_embedded_in_jtag_master                          
  vlog     "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                                                                     -work jtag_phy_embedded_in_jtag_master                          
  vlog     "$QSYS_SIMDIR/submodules/altera_avalon_st_idle_remover.v"                                                                      -work jtag_phy_embedded_in_jtag_master                          
  vlog     "$QSYS_SIMDIR/submodules/altera_avalon_st_idle_inserter.v"                                                                     -work jtag_phy_embedded_in_jtag_master                          
  vlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_stage.sv"                                      -L altera_common_sv_packages -work jtag_phy_embedded_in_jtag_master                          
  vlog     "$QSYS_SIMDIR/submodules/TAG_Computer_ARM_A9_HPS_hps_io.v"                                                                     -work hps_io                                                    
  vlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_mm_slave_bfm.sv"                                           -L altera_common_sv_packages -work fpga_interfaces                                           
  vlog -sv "$QSYS_SIMDIR/submodules/questa_mvc_svapi.svh"                                                    -L altera_common_sv_packages -work fpga_interfaces                                           
  vlog -sv "$QSYS_SIMDIR/submodules/mgc_common_axi.sv"                                                       -L altera_common_sv_packages -work fpga_interfaces                                           
  vlog -sv "$QSYS_SIMDIR/submodules/mgc_axi_master.sv"                                                       -L altera_common_sv_packages -work fpga_interfaces                                           
  vlog -sv "$QSYS_SIMDIR/submodules/mgc_axi_slave.sv"                                                        -L altera_common_sv_packages -work fpga_interfaces                                           
  vlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_interrupt_sink.sv"                                         -L altera_common_sv_packages -work fpga_interfaces                                           
  vlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_clock_source.sv"                                           -L altera_common_sv_packages -work fpga_interfaces                                           
  vlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_reset_source.sv"                                           -L altera_common_sv_packages -work fpga_interfaces                                           
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_ARM_A9_HPS_fpga_interfaces_h2f_mpu_events.sv"               -L altera_common_sv_packages -work fpga_interfaces                                           
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_ARM_A9_HPS_fpga_interfaces.sv"                              -L altera_common_sv_packages -work fpga_interfaces                                           
  vlog     "$QSYS_SIMDIR/submodules/altera_reset_controller.v"                                                                            -work rst_controller                                            
  vlog     "$QSYS_SIMDIR/submodules/altera_reset_synchronizer.v"                                                                          -work rst_controller                                            
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_irq_mapper_001.sv"                                          -L altera_common_sv_packages -work irq_mapper_001                                            
  vlog -sv "$QSYS_SIMDIR/submodules/TAG_Computer_irq_mapper.sv"                                              -L altera_common_sv_packages -work irq_mapper                                                
  vlog     "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_1.v"                                                                     -work mm_interconnect_1                                         
  vlog     "$QSYS_SIMDIR/submodules/TAG_Computer_mm_interconnect_0.v"                                                                     -work mm_interconnect_0                                         
  vlog     "$QSYS_SIMDIR/submodules/TAG_Computer_System_PLL.v"                                                                            -work System_PLL                                                
  vlog     "$QSYS_SIMDIR/submodules/TAG_Computer_SysID.vo"                                                                                -work SysID                                                     
  vlog     "$QSYS_SIMDIR/submodules/TAG_Computer_Slider_Switches.v"                                                                       -work Slider_Switches                                           
  vlog     "$QSYS_SIMDIR/submodules/TAG_Computer_SDRAM.v"                                                                                 -work SDRAM                                                     
  vlog     "$QSYS_SIMDIR/submodules/TAG_Computer_SDRAM_test_component.v"                                                                  -work SDRAM                                                     
  vlog     "$QSYS_SIMDIR/submodules/TAG_Computer_PushButtons.v"                                                                           -work PushButtons                                               
  vlog     "$QSYS_SIMDIR/submodules/TAG_Computer_Onchip_SRAM.v"                                                                           -work Onchip_SRAM                                               
  vlog     "$QSYS_SIMDIR/submodules/TAG_Computer_LEDS.v"                                                                                  -work LEDS                                                      
  vlog     "$QSYS_SIMDIR/submodules/TAG_Computer_JTAG_UART_For_ARM0.v"                                                                    -work JTAG_UART_For_ARM0                                        
  vlog     "$QSYS_SIMDIR/submodules/TAG_Computer_JTAG_To_FPGA_Bridge.v"                                                                   -work JTAG_To_FPGA_Bridge                                       
  vlog     "$QSYS_SIMDIR/submodules/TAG_Computer_Interval_Timer.v"                                                                        -work Interval_Timer                                            
  vlog     "$QSYS_SIMDIR/submodules/TAG_Computer_IO_Bridge.v"                                                                             -work IO_Bridge                                                 
  vlog     "$QSYS_SIMDIR/submodules/TAG_Computer_HEX0_1.v"                                                                                -work HEX0_1                                                    
  vlog     "$QSYS_SIMDIR/submodules/TAG_Computer_ARM_A9_HPS.v"                                                                            -work ARM_A9_HPS                                                
  vlog     "$QSYS_SIMDIR/TAG_Computer.v"                                                                                                                                                                  
}

# ----------------------------------------
# Elaborate top level design
alias elab {
  echo "\[exec\] elab"
  eval vsim -t ps $ELAB_OPTIONS -L work -L work_lib -L altera_common_sv_packages -L error_adapter_0 -L border -L rsp_mux -L rsp_demux -L cmd_mux -L cmd_demux -L router_001 -L router -L ARM_A9_HPS_f2h_axi_slave_agent -L avalon_st_adapter_001 -L avalon_st_adapter -L ARM_A9_HPS_h2f_axi_master_wr_to_SDRAM_s1_cmd_width_adapter -L rsp_mux_002 -L rsp_demux_011 -L rsp_demux_001 -L cmd_mux_011 -L cmd_mux_001 -L cmd_demux_002 -L SDRAM_s1_burst_adapter -L ARM_A9_HPS_h2f_axi_master_wr_limiter -L router_016 -L router_008 -L router_007 -L router_006 -L router_005 -L router_003 -L router_002 -L SDRAM_s1_agent -L JTAG_To_FPGA_Bridge_master_agent -L ARM_A9_HPS_h2f_axi_master_agent -L SDRAM_s1_translator -L JTAG_To_FPGA_Bridge_master_translator -L reset_from_locked -L sys_pll -L p2b_adapter -L b2p_adapter -L transacto -L p2b -L b2p -L fifo -L timing_adt -L jtag_phy_embedded_in_jtag_master -L hps_io -L fpga_interfaces -L rst_controller -L irq_mapper_001 -L irq_mapper -L mm_interconnect_1 -L mm_interconnect_0 -L System_PLL -L SysID -L Slider_Switches -L SDRAM -L PushButtons -L Onchip_SRAM -L LEDS -L JTAG_UART_For_ARM0 -L JTAG_To_FPGA_Bridge -L Interval_Timer -L IO_Bridge -L HEX0_1 -L ARM_A9_HPS -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver $TOP_LEVEL_NAME
}

# ----------------------------------------
# Elaborate the top level design with novopt option
alias elab_debug {
  echo "\[exec\] elab_debug"
  eval vsim -novopt -t ps $ELAB_OPTIONS -L work -L work_lib -L altera_common_sv_packages -L error_adapter_0 -L border -L rsp_mux -L rsp_demux -L cmd_mux -L cmd_demux -L router_001 -L router -L ARM_A9_HPS_f2h_axi_slave_agent -L avalon_st_adapter_001 -L avalon_st_adapter -L ARM_A9_HPS_h2f_axi_master_wr_to_SDRAM_s1_cmd_width_adapter -L rsp_mux_002 -L rsp_demux_011 -L rsp_demux_001 -L cmd_mux_011 -L cmd_mux_001 -L cmd_demux_002 -L SDRAM_s1_burst_adapter -L ARM_A9_HPS_h2f_axi_master_wr_limiter -L router_016 -L router_008 -L router_007 -L router_006 -L router_005 -L router_003 -L router_002 -L SDRAM_s1_agent -L JTAG_To_FPGA_Bridge_master_agent -L ARM_A9_HPS_h2f_axi_master_agent -L SDRAM_s1_translator -L JTAG_To_FPGA_Bridge_master_translator -L reset_from_locked -L sys_pll -L p2b_adapter -L b2p_adapter -L transacto -L p2b -L b2p -L fifo -L timing_adt -L jtag_phy_embedded_in_jtag_master -L hps_io -L fpga_interfaces -L rst_controller -L irq_mapper_001 -L irq_mapper -L mm_interconnect_1 -L mm_interconnect_0 -L System_PLL -L SysID -L Slider_Switches -L SDRAM -L PushButtons -L Onchip_SRAM -L LEDS -L JTAG_UART_For_ARM0 -L JTAG_To_FPGA_Bridge -L Interval_Timer -L IO_Bridge -L HEX0_1 -L ARM_A9_HPS -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver $TOP_LEVEL_NAME
}

# ----------------------------------------
# Compile all the design files and elaborate the top level design
alias ld "
  dev_com
  com
  elab
"

# ----------------------------------------
# Compile all the design files and elaborate the top level design with -novopt
alias ld_debug "
  dev_com
  com
  elab_debug
"

# ----------------------------------------
# Print out user commmand line aliases
alias h {
  echo "List Of Command Line Aliases"
  echo
  echo "file_copy                     -- Copy ROM/RAM files to simulation directory"
  echo
  echo "dev_com                       -- Compile device library files"
  echo
  echo "com                           -- Compile the design files in correct order"
  echo
  echo "elab                          -- Elaborate top level design"
  echo
  echo "elab_debug                    -- Elaborate the top level design with novopt option"
  echo
  echo "ld                            -- Compile all the design files and elaborate the top level design"
  echo
  echo "ld_debug                      -- Compile all the design files and elaborate the top level design with -novopt"
  echo
  echo 
  echo
  echo "List Of Variables"
  echo
  echo "TOP_LEVEL_NAME                -- Top level module name."
  echo
  echo "SYSTEM_INSTANCE_NAME          -- Instantiated system module name inside top level module."
  echo
  echo "QSYS_SIMDIR                   -- Qsys base simulation directory."
  echo
  echo "QUARTUS_INSTALL_DIR           -- Quartus installation directory."
}
file_copy
h
