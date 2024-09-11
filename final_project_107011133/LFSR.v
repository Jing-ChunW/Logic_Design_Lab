`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/26 23:59:28
// Design Name: 
// Module Name: LFSR
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

module LFSR(
    input clk,
    input rst,
    output [2:0] LFSRnum
    );
    
reg [4:0] num, num_next;
assign LFSRnum = num[2:0];
always @(posedge clk or posedge rst) begin
    if (rst) begin
        num <= 5'd1;
    end else begin
        num <= num_next;
    end
end

always @(*) begin
    num_next[0] = num[4] ^ num[3];
    num_next[1] = num[0];
    num_next[2] = num[1];
    num_next[3] = num[2];
    num_next[4] = num[3];
end
endmodule
