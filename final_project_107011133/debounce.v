`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/26 23:59:59
// Design Name: 
// Module Name: debounce
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


module debounce(
    input clk,
    input rst,
    output reg push_debounce,
    input push
    );
    reg [3:0] push_window;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            push_window <= 4'd0;
            push_debounce <= 1'd0;
        end else begin
            push_window <= {push, push_window[3:1]};
        
            if (push_window[3:0] == 4'b1111) begin
                push_debounce <= 1'b1;
            end else begin
                push_debounce <= 1'b0;
            end
        end
    end
endmodule

