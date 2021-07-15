create_clock -period 20.000 -name clk -waveform {0.000 10.000} [get_ports clk]
set_input_delay -clock [get_clocks clk] -min -add_delay 0.000 [get_ports reset]
set_input_delay -clock [get_clocks clk] -max -add_delay 0.000 [get_ports reset]
