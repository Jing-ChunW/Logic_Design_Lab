`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/27 00:02:41
// Design Name: 
// Module Name: clock_divisor_LFSR
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


module clock_divisor_LFSR(
    input clk,
    input rst,
    output reg clk_LFSR
    );
    reg clk_LFSR_next;
    reg [6:0] cnt_LFSR, cnt_LFSR_next;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            cnt_LFSR <= 7'd0;
        end else begin
            cnt_LFSR <= cnt_LFSR_next;
        end
    end
    
    always @(*) begin
        if (cnt_LFSR == 7'd47) begin
            cnt_LFSR_next = 7'd0;
        end else begin
            cnt_LFSR_next = cnt_LFSR + 1;
        end
    end
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            clk_LFSR <= 1'd0;
        end else begin
            clk_LFSR <= clk_LFSR_next;
        end
    end
    
    always @(*) begin
        if (cnt_LFSR == 7'd47) begin
            clk_LFSR_next = ~clk_LFSR;
        end else begin
            clk_LFSR_next = clk_LFSR;
        end
    end
endmodule
