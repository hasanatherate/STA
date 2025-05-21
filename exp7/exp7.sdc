`timescale 1ns/1ps

module register_file_tb;

    reg clk, rst, we;
    reg [2:0] read_addr, write_addr;
    reg [7:0] write_data;
    wire [7:0] read_data;

    // Instantiate Register File
    register_file uut (
        .clk(clk),
        .rst(rst),
        .we(we),
        .read_addr(read_addr),
        .write_addr(write_addr),
        .write_data(write_data),
        .read_data(read_data)
    );

    // Clock generation (10ns period -> 100MHz)
    always #5 clk = ~clk;

    initial begin
        $dumpfile("register_file.vcd");
        $dumpvars(0, register_file_tb);

        clk = 0;
        rst = 1; we = 0; write_addr = 0; write_data = 8'b0; read_addr = 0;
        #10 rst = 0;  // Release reset after 10ns
        
        // Write values to registers
        #10 we = 1; write_addr = 3'b001; write_data = 8'hA5; // Write 0xA5 to reg[1]
        #10 we = 1; write_addr = 3'b010; write_data = 8'h5A; // Write 0x5A to reg[2]
        #10 we = 0; // Disable write

        // Read from registers
        #10 read_addr = 3'b001;
        #10 read_addr = 3'b010;

        #50 $finish;
    end

endmodule
constraints.sdc
# Define clock with 10ns period (100MHz)
create_clock -name clk -period 10 [get_ports clk]

# Set input delay for write signals
set_input_delay -max 3.0 -clock clk [get_ports write_data]
set_input_delay -min 1.0 -clock clk [get_ports write_data]

# Set output delay for read data
set_output_delay -max 2.0 -clock clk [get_ports read_data]
set_output_delay -min 0.8 -clock clk [get_ports read_data]

# Setup and Hold Constraints
set_max_delay 5.0 -from [get_ports clk] -to [get_ports write_data]
set_min_delay 1.0 -from [get_ports clk] -to [get_ports write_data]

# Define clock uncertainty (jitter)
set_clock_uncertainty 0.2 [get_clocks clk]
