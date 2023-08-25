`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/23/2023 11:49:58 AM
// Design Name: 
// Module Name: datamux
// Project Name: 
// Target Devices: 
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


module data_mux_module (
    input wire clk,                 // Internal clock signal (100MHz)
    input wire symbol_clk,          // External symbol clock
    input wire  [2:0] switch_clk_cycles,//  Number of clk cycles to switch data streams
    input wire [7:0] DS1,           // Data stream 1
    input wire [7:0] DS2,           // Data stream 2
    input wire [7:0] DS3,           // Data stream 3
    input wire [1:0] mode,          // Mode of operation (2 bits for 3 modes)
    output reg [7:0] output_data    // Output data stream
);

reg [1:0] counter = 2'b00;          // Counter to keep track of switching cycles
always @(posedge symbol_clk ) begin 
    if (counter ==  switch_clk_cycles-1) // When counter reaches switch_clk_cycles
        counter <= 0;
    else
        counter <= counter + 1'b1;
end
always @(posedge symbol_clk  ) begin
    case (mode)
        2'b01: output_data <= DS1;   // Mode 1: Only DS1
        2'b10: output_data <= (counter <switch_clk_cycles/2)? DS1:DS2; // Mode 2: DS1 and DS2
        2'b11: output_data <= (counter < switch_clk_cycles/3) ? DS1 :((counter < 2*switch_clk_cycles/3) ? DS2 : DS3); // Mode 3: DS1, DS2, DS3
        
    endcase
end

endmodule
