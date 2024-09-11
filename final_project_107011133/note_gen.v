`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/27 00:19:52
// Design Name: 
// Module Name: note_gen
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


module note_gen(
    input clk,
    input rst,
    input [21:0]note_div,
    output [15:0]audio_left, audio_right
    );
    
    reg [21:0]cnt, cnt_next;
    reg b_clk, b_next;
    
    always@(*)
        if (cnt == note_div) begin
            cnt_next = 22'b0;
            b_next = ~b_clk;
        end
        else begin
            cnt_next = cnt + 1'b1;
            b_next = b_clk;
        end
        
    assign audio_left = (b_clk == 1'b0)? 16'h7000  : 16'h5FFF;
    assign audio_right = (b_clk == 1'b0)? 16'h7000 : 16'h5FFF;            
    
    always@(posedge clk or posedge rst)
        if (rst) begin
            cnt <= 22'b0;
            b_clk <= 1'b0;
       end
       else begin
            cnt <= cnt_next;
            b_clk <= b_next;
       end       
endmodule
