// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.2 (win64) Build 3367213 Tue Oct 19 02:48:09 MDT 2021
// Date        : Sun Jul 14 01:31:52 2024
// Host        : ve running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/vele/Desktop/Workspace/Project_FPGA/unicorn_jig/project/project.gen/sources_1/ip/vio_user_encoder/vio_user_encoder_stub.v
// Design      : vio_user_encoder
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35ticsg324-1L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "vio,Vivado 2021.2" *)
module vio_user_encoder(clk, probe_in0, probe_in1, probe_in2, probe_in3, 
  probe_in4, probe_in5, probe_in6, probe_in7, probe_in8)
/* synthesis syn_black_box black_box_pad_pin="clk,probe_in0[2:0],probe_in1[31:0],probe_in2[0:0],probe_in3[15:0],probe_in4[15:0],probe_in5[15:0],probe_in6[15:0],probe_in7[3:0],probe_in8[3:0]" */;
  input clk;
  input [2:0]probe_in0;
  input [31:0]probe_in1;
  input [0:0]probe_in2;
  input [15:0]probe_in3;
  input [15:0]probe_in4;
  input [15:0]probe_in5;
  input [15:0]probe_in6;
  input [3:0]probe_in7;
  input [3:0]probe_in8;
endmodule
