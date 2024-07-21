onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+vio_user_leds -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.vio_user_leds xil_defaultlib.glbl

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure

do {vio_user_leds.udo}

run -all

endsim

quit -force
