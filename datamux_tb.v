`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/23/2023 11:50:44 AM
// Design Name: 
// Module Name: datamux_tb
// Project Name: 
// Target Devices: zebdboard
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_data_mux_module;

reg clk = 1, symbol_clk = 1;
reg [2:0] switch_clk_cycles;
reg [7:0] DS1;
reg [7:0] DS2;
reg [7:0] DS3;
reg [1:0] mode;
wire [7:0] output_data;

// Instantiate the multiplexing module
data_mux_module uut (
    .clk(clk),
    .symbol_clk(symbol_clk),
    .switch_clk_cycles(switch_clk_cycles),
    .DS1(DS1),
    .DS2(DS2),
    .DS3(DS3),
    .mode(mode),
    .output_data(output_data)
);

// Clock generation
always begin
    #1 clk = ~clk;
end

always begin
    #6 symbol_clk = ~symbol_clk; // Set symbol clock frequency here
end

initial begin
    // Initialize testbench inputs
    switch_clk_cycles = 5; // Set the number of clock cycles to switch
    DS1 = 8'b00001111;
    DS2 = 8'b11001100;
    DS3 = 8'b01010101;
    
    // Test mode 1
    mode = 2'b01;
    #36; // Simulate for a while
    
    // Test mode 2
    mode = 2'b10;
    #36; // Simulate for a while
    
    // Test mode 3
    mode = 2'b11;
    #36; // Simulate for a while
    
    $finish;
end

endmodule
