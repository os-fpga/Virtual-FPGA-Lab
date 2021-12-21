set_property PACKAGE_PIN Y9 [get_ports {clk}];  # "GCLK"

set_property PACKAGE_PIN T22 [get_ports {led[0]}];  # "led0"
set_property PACKAGE_PIN T21 [get_ports {led[1]}];  # "led1"
set_property PACKAGE_PIN U22 [get_ports {led[2]}];  # "led2"
set_property PACKAGE_PIN U21 [get_ports {led[3]}];  # "led3"
set_property PACKAGE_PIN V22 [get_ports {led[4]}];  # "led4"
set_property PACKAGE_PIN W22 [get_ports {led[5]}];  # "led5"
set_property PACKAGE_PIN U19 [get_ports {led[6]}];  # "led6"
set_property PACKAGE_PIN U14 [get_ports {led[7]}];  # "led7"

set_property PACKAGE_PIN L16 [get_ports {OTG_VBUSOC}];  # "OTG-VBUSOC"

set_property PACKAGE_PIN H15 [get_ports {XADC_GIO0}];  # "XADC-GIO0"
set_property PACKAGE_PIN R15 [get_ports {XADC_GIO1}];  # "XADC-GIO1"
set_property PACKAGE_PIN K15 [get_ports {XADC_GIO2}];  # "XADC-GIO2"
set_property PACKAGE_PIN J15 [get_ports {XADC_GIO3}];  # "XADC-GIO3"

set_property PACKAGE_PIN F22 [get_ports {reset}];  # "SW0"

set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 33]];
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 35]];
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 13]];
