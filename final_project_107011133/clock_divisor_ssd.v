`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/27 00:04:45
// Design Name: 
// Module Name: clock_divisor_ssd
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


module clock_divisor_ssd(

    input clk,
    input rst,
    output [1:0] f_out
    );
    reg [27-1:0] cnt, cnt_next;
    reg f_next;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            cnt <= 27'd0;
        end else begin
            cnt <= cnt_next;
        end
    end 
    always @(*) begin
        cnt_next = cnt + 1'd1;
    end
    assign f_out = cnt[15:14];

endmodule
