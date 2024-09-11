`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/27 00:00:34
// Design Name: 
// Module Name: onepulse1
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


module onepulse1(
    input clk,
    input rst,
    input push_debounce,
    output reg push_onepulse
    );
    reg push_onepulse_next;
    reg push_debounce_delay;
    always @(*) begin
        push_onepulse_next = push_debounce & ~push_debounce_delay;
    end
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            push_onepulse <= 1'b0;
            push_debounce_delay <= 1'b0;
        end else begin
            push_onepulse <= push_onepulse_next;
            push_debounce_delay <= push_debounce;
        end
    end
endmodule
