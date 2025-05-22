`timescale 1ns / 1ps
module tb_dual_clock_counter;
// Inputs
reg clk1;
reg clk2;
reg rst;
// Outputs
wire [3:0] count1;
wire [3:0] count2;
// Instantiate the Counters Module
dual_clock_counter uut (
.clk1(clk1),
.clk2(clk2),
.rst(rst),
.count1(count1),
.count2(count2)
);
// Clock generation
initial begin
clk1 = 0;
clk2 = 0;
forever #5 clk1 = ~clk1; // Toggle clk1 every 5 time units
end
initial begin
forever #7 clk2 = ~clk2; // Toggle clk2 every 7 time units
end
// Test sequence
initial begin
Department of VLSI Design and Technology, B.I.T 49
Static Timing Analysis - BVLL657A
// Initial conditions
rst = 1; // Start with reset active
#10;
rst = 0; // Deactivate reset
// Wait for some clock cycles
#100;
// Apply reset again
rst = 1; // Activate reset
#10;
rst = 0; // Deactivate reset
// Wait for some clock cycles
#100;
// End simulation
$finish;
end
// Monitor outputs
initial begin
$monitor("Time: %0t | RST: %b | Count1: %b | Count2: %b", $time, rst, count1,
count2);
end
endmodule