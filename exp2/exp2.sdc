//Constraint file for 10MHz
//define the primary clocks
create_clock -name clk_10MHz -period 100.0 [get_ports clk1]
# Set input delay constraints (example, adjust based on design)
set_input_delay -max 4.0 -clock clk_10MHz [get_ports rst]
set_input_delay -min 2.0 -clock clk_10MHz [get_ports rst]
set_input_delay -clock clk_10MHz -max 4.0 [get_ports rst]
set_input_delay -clock clk_10MHz -min 2.0 [get_ports rst]
# Set output delay constraints (example, adjust based on design)
set_output_delay -max 1.0 -clock clk_10MHz [get_ports count1]
set_output_delay -min 0.0 -clock clk_10MHz [get_ports count1]
# Setup and hold constraints (if needed)
set_multicycle_path 1 -from [get_ports count1] -to [get_ports count2] -setup
set_multicycle_path 1 -from [get_ports count2] -to [get_ports count1] -hold
//Constraint file for 50MHz
//define the primary clocks
create_clock -name clk_50MHz -period 20.0 [get_ports clk2]
# Set input delay constraints (example, adjust based on design)
set_input_delay -max 2.0 -clock clk_50MHz [get_ports rst]
set_input_delay -min 1.0 -clock clk_50MHz [get_ports rst]
# Set output delay constraints (example, adjust based on design)
set_output_delay -max 1.0 -clock clk_50MHz [get_ports count2]

set_output_delay -min 0.0 -clock clk_50MHz [get_ports count2]
# Setup and hold constraints (if needed)
set_multicycle_path 1 -from [get_ports count1] -to [get_ports count2] -setup
set_multicycle_path 1 -from [get_ports count2] -to [get_ports count1] -hold
//Synthesize command
read_lib /home/installs/cad/slow.lib
read_hdl prg1.v
elaborate
read_sdc prg110Mhz.sdc
synthesize -to_mapped
report timing
read_sdc prg150Mhz.sdc
synthesize -to_mapped
report timing
report power