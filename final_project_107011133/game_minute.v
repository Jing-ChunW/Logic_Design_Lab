`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/26 23:58:44
// Design Name: 
// Module Name: game_minute
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


module game_minute(
    input clk,
    input clk_LFSR,
    input rst,
    input switch,
    input [2:0] state,
    output reg no_zombie,
    output reg stop_tag_onepulse
    );
    reg [6:0] zombie_minute;
    parameter idle = 3'b000;
    parameter play = 3'b001;
    parameter stop = 3'b010;
    parameter score = 3'b011;
    parameter speed = 3'b100;
    parameter miss = 3'b101;
    reg no_zombie_next;
    reg stop_tag_onepulse_next;
    reg [6:0] cnt_stop, cnt_stop_next;
    //assign zombie_minute = 7'd10;
    always @(*) begin
        if (switch) zombie_minute = 7'd40;
        else zombie_minute = 7'd15;
    end
    always @(posedge clk or posedge rst) begin
        if (rst) no_zombie <= 1'b0;
        else no_zombie <= no_zombie_next;
    end
    
    always @(*) begin
        if (state == idle) begin
            no_zombie_next = 1'b0;
        end
        else if (state == play) begin
            if (cnt_stop == zombie_minute) begin
                no_zombie_next = 1'b1;
            end else begin
                no_zombie_next = no_zombie;
            end
        end else begin
            no_zombie_next = no_zombie;
        end
    end
    
    always @(posedge clk or posedge rst) begin
        if (rst) stop_tag_onepulse <= 1'b0;
        else stop_tag_onepulse <= stop_tag_onepulse_next;
    end
    
    always @(*) begin
        if (state == play) begin
            if (cnt_stop == zombie_minute + 7'd5) stop_tag_onepulse_next = 1'b1;
            else stop_tag_onepulse_next = 1'b0; 
        end 
        else stop_tag_onepulse_next = 1'b0; 
    end
    
    always @(posedge clk_LFSR or posedge rst) begin
        if (rst) cnt_stop <= 7'd0;
        else cnt_stop <= cnt_stop_next;
    end
    
    always @(*) begin
        if (state == play) begin
            if (cnt_stop == zombie_minute + 7'd5) begin
                cnt_stop_next = 7'd0;
            end else begin
                cnt_stop_next = cnt_stop + 7'd1;
            end
        end else cnt_stop_next = 7'd0;
    end
endmodule
