## FPGA Configuration I/O Options
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

## Board Clock: 100 MHz
set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports {clk}];
create_clock -name clk -period 10.00 [get_ports {clk}];

set_property -dict {PACKAGE_PIN E1 IOSTANDARD LVCMOS33} [get_ports {reset}];
set_property -dict {PACKAGE_PIN E2 IOSTANDARD LVCMOS33} [get_ports {enable}];
set_property -dict {PACKAGE_PIN F6 IOSTANDARD LVCMOS33} [get_ports {load_seed}];
set_property -dict {PACKAGE_PIN G6 IOSTANDARD LVCMOS33} [get_ports {seed}];
set_property -dict {PACKAGE_PIN G4 IOSTANDARD LVCMOS33} [get_ports {rnd}];
