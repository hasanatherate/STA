module dual_clock_counter (  
    input wire clk1,  
    input wire clk2,  
    input wire rst,  
    output reg [3:0] count1,  
    output reg [3:0] count2  
);  
always @(posedge clk1 or posedge rst) begin  
    if (rst)  
        count1 <= 4'b0000;  
    else  
        count1 <= count1 + 1;  
end  
always @(posedge clk2 or posedge rst) begin  
    if (rst)  
        count2 <= 4'b0000;  
    else  
        count2 <= count2 + 1;  
end  
endmodule  
