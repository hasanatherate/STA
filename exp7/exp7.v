module register_file (
    input wire clk,              // Clock
    input wire rst,              // Reset (Active High)
    input wire we,               // Write Enable
    input wire [2:0] read_addr,  // Read Address (3-bit for 8 registers)
    input wire [2:0] write_addr, // Write Address
    input wire [7:0] write_data, // 8-bit Write Data
    output reg [7:0] read_data   // 8-bit Read Data
);

    reg [7:0] reg_file [7:0];  // 8 registers, 8-bit each

    // Asynchronous Read
    always @(*) begin
        read_data = reg_file[read_addr];
    end

    // Synchronous Write
    always @(posedge clk or posedge rst) begin
        if (rst)
            reg_file[0] <= 8'b00000000;  // Reset only register 0
        else if (we)
            reg_file[write_addr] <= write_data; // Write data on clock edge
    end

endmodule
