`timescale 1ns/1ps

module tb_counter_4bit;

    reg clk;
    reg reset;
    wire [3:0] count;

    // Instantiate the counter module
    counter_4bit uut (
        .clk(clk),
        .reset(reset),
        .count(count)
    );

    // Clock generation (10ns period = 100MHz)
    always #5 clk = ~clk;  

    initial begin
        $dumpfile("counter.vcd");
        $dumpvars(0, tb_counter_4bit);

        // Initialize signals
        clk = 0;
        reset = 1;

        // Apply reset
        #10 reset = 0;
        
        // Run simulation for 100ns
        #100 $finish;
    end
endmodule
