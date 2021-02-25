// (C) 2001-2015 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// $Id: //acds/main/ip/sopc/components/verification/altera_tristate_conduit_bfm/altera_tristate_conduit_bfm.sv.terp#7 $
// $Revision: #7 $
// $Date: 2010/08/05 $
// $Author: klong $
//-----------------------------------------------------------------------------
// =head1 NAME
// altera_conduit_bfm
// =head1 SYNOPSIS
// Bus Functional Model (BFM) for a Standard Conduit BFM
//-----------------------------------------------------------------------------
// =head1 DESCRIPTION
// This is a Bus Functional Model (BFM) for a Standard Conduit Master.
// This BFM sampled the input/bidirection port value or driving user's value to 
// output ports when user call the API.  
// This BFM's HDL is been generated through terp file in Qsys/SOPC Builder.
// Generation parameters:
// output_name:                                       TAG_Computer_ARM_A9_HPS_fpga_interfaces_h2f_mpu_events
// role:width:direction:                              h2f_mpu_eventi:1:Input,h2f_mpu_evento:1:Output,h2f_mpu_standbywfe:2:Output,h2f_mpu_standbywfi:2:Output
// 0
//-----------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module TAG_Computer_ARM_A9_HPS_fpga_interfaces_h2f_mpu_events
(
   sig_h2f_mpu_eventi,
   sig_h2f_mpu_evento,
   sig_h2f_mpu_standbywfe,
   sig_h2f_mpu_standbywfi
);

   //--------------------------------------------------------------------------
   // =head1 PINS 
   // =head2 User defined interface
   //--------------------------------------------------------------------------
   input sig_h2f_mpu_eventi;
   output sig_h2f_mpu_evento;
   output [1 : 0] sig_h2f_mpu_standbywfe;
   output [1 : 0] sig_h2f_mpu_standbywfi;

   // synthesis translate_off
   import verbosity_pkg::*;
   
   typedef logic ROLE_h2f_mpu_eventi_t;
   typedef logic ROLE_h2f_mpu_evento_t;
   typedef logic [1 : 0] ROLE_h2f_mpu_standbywfe_t;
   typedef logic [1 : 0] ROLE_h2f_mpu_standbywfi_t;

   logic [0 : 0] sig_h2f_mpu_eventi_in;
   logic [0 : 0] sig_h2f_mpu_eventi_local;
   reg sig_h2f_mpu_evento_temp;
   reg sig_h2f_mpu_evento_out;
   reg [1 : 0] sig_h2f_mpu_standbywfe_temp;
   reg [1 : 0] sig_h2f_mpu_standbywfe_out;
   reg [1 : 0] sig_h2f_mpu_standbywfi_temp;
   reg [1 : 0] sig_h2f_mpu_standbywfi_out;

   //--------------------------------------------------------------------------
   // =head1 Public Methods API
   // =pod
   // This section describes the public methods in the application programming
   // interface (API). The application program interface provides methods for 
   // a testbench which instantiates, controls and queries state in this BFM 
   // component. Test programs must only use these public access methods and 
   // events to communicate with this BFM component. The API and module pins
   // are the only interfaces of this component that are guaranteed to be
   // stable. The API will be maintained for the life of the product. 
   // While we cannot prevent a test program from directly accessing internal
   // tasks, functions, or data private to the BFM, there is no guarantee that
   // these will be present in the future. In fact, it is best for the user
   // to assume that the underlying implementation of this component can 
   // and will change.
   // =cut
   //--------------------------------------------------------------------------
   
   event signal_input_h2f_mpu_eventi_change;
   
   function automatic string get_version();  // public
      // Return BFM version string. For example, version 9.1 sp1 is "9.1sp1" 
      string ret_version = "15.0";
      return ret_version;
   endfunction

   // -------------------------------------------------------
   // h2f_mpu_eventi
   // -------------------------------------------------------
   function automatic ROLE_h2f_mpu_eventi_t get_h2f_mpu_eventi();
   
      // Gets the h2f_mpu_eventi input value.
      $sformat(message, "%m: called get_h2f_mpu_eventi");
      print(VERBOSITY_DEBUG, message);
      return sig_h2f_mpu_eventi_in;
      
   endfunction

   // -------------------------------------------------------
   // h2f_mpu_evento
   // -------------------------------------------------------

   function automatic void set_h2f_mpu_evento (
      ROLE_h2f_mpu_evento_t new_value
   );
      // Drive the new value to h2f_mpu_evento.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      sig_h2f_mpu_evento_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // h2f_mpu_standbywfe
   // -------------------------------------------------------

   function automatic void set_h2f_mpu_standbywfe (
      ROLE_h2f_mpu_standbywfe_t new_value
   );
      // Drive the new value to h2f_mpu_standbywfe.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      sig_h2f_mpu_standbywfe_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // h2f_mpu_standbywfi
   // -------------------------------------------------------

   function automatic void set_h2f_mpu_standbywfi (
      ROLE_h2f_mpu_standbywfi_t new_value
   );
      // Drive the new value to h2f_mpu_standbywfi.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      sig_h2f_mpu_standbywfi_temp = new_value;
   endfunction

   assign sig_h2f_mpu_eventi_in = sig_h2f_mpu_eventi;
   assign sig_h2f_mpu_evento = sig_h2f_mpu_evento_temp;
   assign sig_h2f_mpu_standbywfe = sig_h2f_mpu_standbywfe_temp;
   assign sig_h2f_mpu_standbywfi = sig_h2f_mpu_standbywfi_temp;


   always @(sig_h2f_mpu_eventi_in) begin
      if (sig_h2f_mpu_eventi_local != sig_h2f_mpu_eventi_in)
         -> signal_input_h2f_mpu_eventi_change;
      sig_h2f_mpu_eventi_local = sig_h2f_mpu_eventi_in;
   end
   


// synthesis translate_on

endmodule

