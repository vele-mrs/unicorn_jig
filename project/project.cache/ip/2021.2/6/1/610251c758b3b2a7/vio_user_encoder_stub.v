// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.2 (win64) Build 3367213 Tue Oct 19 02:48:09 MDT 2021
// Date        : Sun Jul 14 00:55:19 2024
// Host        : ve running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ vio_user_encoder_stub.v
// Design      : vio_user_encoder
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35ticsg324-1L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "vio,Vivado 2021.2" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(clk, probe_in0, probe_in1, probe_in2)
/* synthesis syn_black_box black_box_pad_pin="clk,probe_in0[2:0],probe_in1[31:0],probe_in2[0:0]" */;
  input clk;
  input [2:0]probe_in0;
  input [31:0]probe_in1;
  input [0:0]probe_in2;
endmodule
