// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.2 (win64) Build 3367213 Tue Oct 19 02:48:09 MDT 2021
// Date        : Sat Jul 13 16:43:44 2024
// Host        : ve running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/vele/Desktop/Workspace/Project_FPGA/unicorn_jig/project/project.runs/vio_user_leds_synth_1/vio_user_leds_stub.v
// Design      : vio_user_leds
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35ticsg324-1L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "vio,Vivado 2021.2" *)
module vio_user_leds(clk, probe_out0, probe_out1, probe_out2, 
  probe_out3, probe_out4, probe_out5, probe_out6)
/* synthesis syn_black_box black_box_pad_pin="clk,probe_out0[9:0],probe_out1[6:0],probe_out2[0:0],probe_out3[0:0],probe_out4[6:0],probe_out5[6:0],probe_out6[6:0]" */;
  input clk;
  output [9:0]probe_out0;
  output [6:0]probe_out1;
  output [0:0]probe_out2;
  output [0:0]probe_out3;
  output [6:0]probe_out4;
  output [6:0]probe_out5;
  output [6:0]probe_out6;
endmodule
