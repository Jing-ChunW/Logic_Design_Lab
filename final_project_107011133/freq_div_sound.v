`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/26 23:57:41
// Design Name: 
// Module Name: freq_div_sound
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

module freq_div_sound(
    input clk,
    input rst,
    input switch,
    output reg f
    );

    reg [26:0]cnt;
    reg [26:0]cnt_tmp;
    reg [26:0] cnt_num;
    always @(*) begin
        if (switch) cnt_num = 27'd10000000;
        else cnt_num = 27'd20000000;
    end
    always@(*)
        cnt_tmp = cnt + 1'b1;       
    
    always@(posedge clk or posedge rst) begin
        if (rst) begin
            cnt <= 27'b0;
            f <= 1'b0;
            end
        else if (cnt == cnt_num) begin
            cnt <= 27'b0;
            f <= ~f;
            end
        else cnt <= cnt_tmp;
    end        
       
endmodule
