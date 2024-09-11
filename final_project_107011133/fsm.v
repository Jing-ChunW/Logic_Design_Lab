`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/27 00:01:42
// Design Name: 
// Module Name: fsm
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


module fsm(
    input clk,
    input btn,
    input rst,
    input stop_tag,
    input btn_score,
    input btn_miss,
    output reg [2:0] state
    );
    reg [2:0] state_next;
    parameter idle = 3'b000;
    parameter play = 3'b001;
    parameter stop = 3'b010;
    parameter score = 3'b011;
    parameter speed = 3'b100;
    parameter miss = 3'b101;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= idle;
        end else begin
            state <= state_next;
        end
    end
    
    always @(*) begin
        case(state) 
            idle: begin
                if (btn == 1) state_next = speed;
                else state_next = state;
            end
            speed: begin
                if (btn == 1) state_next = play;
                else state_next = state;
            end
            play: begin
                if (stop_tag == 1) state_next = stop;
                else state_next = state;
            end
            stop: begin
                if (btn == 1) state_next = idle;
                else begin
                    if (btn_score == 1) state_next = score;
                    else if (btn_miss == 1) state_next = miss;
                    else state_next = state;
                end
            end
            score: begin
                if (btn_score == 1) state_next = stop;
                else state_next = state;
            end
            miss: begin
                if (btn_miss == 1) state_next = stop;
                else state_next = state;
            end
            default: begin
                state_next = idle;
            end
        endcase
    end
endmodule
