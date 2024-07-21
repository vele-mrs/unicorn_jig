onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib vio_user_encoder_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {vio_user_encoder.udo}

run -all

quit -force
