# Create 100 MHz clock
create_clock -name clk -period 10 [get_ports clk]

# Define input delay (optional if no data inputs)
set_input_delay 2 -clock clk [get_ports rst_n]

# Define output delay
set_output_delay 2 -clock clk [get_ports q]

# Mark clk as ideal to isolate net delay effects
set_ideal_network [get_clocks clk]
