`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/27 00:02:12
// Design Name: 
// Module Name: led_ctl
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


module led_ctl(
    input [2:0] state,
    output reg [5:0] led
    );
    parameter idle = 3'b000;
    parameter play = 3'b001;
    parameter stop = 3'b010;
    parameter score = 3'b011;
    parameter speed = 3'b100;
    parameter miss = 3'b101;
     always @(*) begin
        case (state)
            idle: led = 6'b000001;
            speed: led = 6'b000010;
            play: led = 6'b000100;
            stop: led = 6'b001000;
            score: led = 6'b010000;
            miss: led = 6'b100000;
            default: led = 6'b000000;    
        endcase
    end
endmodule
