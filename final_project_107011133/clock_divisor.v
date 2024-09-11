`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/27 00:03:10
// Design Name: 
// Module Name: clock_divisor
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


module clock_divisor(clk1, clk, clk22, state, switch);
input clk;
input [2:0] state;
input switch;
output clk1;
output reg clk22;
reg [21:0] num;
wire [21:0] next_num;
parameter idle = 3'b000;
parameter play = 3'b001;
parameter stop = 3'b010;
parameter score = 3'b011;
parameter speed = 3'b100;
always @(posedge clk) begin
  num <= next_num;
end

assign next_num = num + 1'b1;
assign clk1 = num[1];
//assign clk22 = num[21];
always @(*) begin
    if (switch) clk22 = num[19];
    else clk22 = num[21];
end
endmodule
