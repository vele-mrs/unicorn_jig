vlib work
vlib riviera

vlib riviera/xpm
vlib riviera/xil_defaultlib

vmap xpm riviera/xpm
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xpm  -sv2k12 "+incdir+../../../ip/vio_user_leds/hdl/verilog" "+incdir+../../../ip/vio_user_leds/hdl" \
"C:/Xilinx/Vivado/2021.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/Vivado/2021.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"C:/Xilinx/Vivado/2021.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../ip/vio_user_leds/hdl/verilog" "+incdir+../../../ip/vio_user_leds/hdl" \
"../../../ip/vio_user_leds/sim/vio_user_leds.v" \

vlog -work xil_defaultlib \
"glbl.v"

