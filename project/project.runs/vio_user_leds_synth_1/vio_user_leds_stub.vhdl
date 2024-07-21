-- Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2021.2 (win64) Build 3367213 Tue Oct 19 02:48:09 MDT 2021
-- Date        : Sat Jul 13 16:43:44 2024
-- Host        : ve running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/Users/vele/Desktop/Workspace/Project_FPGA/unicorn_jig/project/project.runs/vio_user_leds_synth_1/vio_user_leds_stub.vhdl
-- Design      : vio_user_leds
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35ticsg324-1L
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vio_user_leds is
  Port ( 
    clk : in STD_LOGIC;
    probe_out0 : out STD_LOGIC_VECTOR ( 9 downto 0 );
    probe_out1 : out STD_LOGIC_VECTOR ( 6 downto 0 );
    probe_out2 : out STD_LOGIC_VECTOR ( 0 to 0 );
    probe_out3 : out STD_LOGIC_VECTOR ( 0 to 0 );
    probe_out4 : out STD_LOGIC_VECTOR ( 6 downto 0 );
    probe_out5 : out STD_LOGIC_VECTOR ( 6 downto 0 );
    probe_out6 : out STD_LOGIC_VECTOR ( 6 downto 0 )
  );

end vio_user_leds;

architecture stub of vio_user_leds is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,probe_out0[9:0],probe_out1[6:0],probe_out2[0:0],probe_out3[0:0],probe_out4[6:0],probe_out5[6:0],probe_out6[6:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "vio,Vivado 2021.2";
begin
end;
