`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/27 00:20:23
// Design Name: 
// Module Name: speaker_ctl
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


module speaker_ctl(
    input clk,
    input rst,
    input [15:0]audio_right, audio_left,
    output audio_mclk,      //  25M
    output audio_lrck,      // 25/128   M
    output audio_sck,       //  25/128 * 32
    output reg audio_sdin
    );
    reg [8:0]cnt1, cnt1_next;
    reg [4:0]cnt2, cnt2_next;
    reg [15:0]audio_right_tmp, audio_left_tmp;
    
    assign audio_mclk = cnt1[1];
    assign audio_lrck = cnt1[8];
    assign audio_sck = cnt1[3];
    
    always@(*) begin
        cnt1_next = cnt1 + 1'b1;
        cnt2_next = cnt2 + 1'b1;
    end
    
    always@(posedge clk or posedge rst)
        if (rst)
            cnt1 <= 9'b0;
        else
            cnt1 <= cnt1_next;
    
    always@(negedge audio_lrck or posedge rst) 
        if (rst) begin
            audio_left_tmp <= 16'b0;
            audio_right_tmp  <= 16'b0;
        end    
        else begin        
            audio_left_tmp <= audio_left;
            audio_right_tmp  <= audio_right;
        end    
    
    always@(posedge audio_sck or posedge rst) 
        if (rst)
            cnt2 <= 5'b0;
        else 
            cnt2 <= cnt2_next;  
            
        always@(*)              
            case(cnt2)
            5'd0: audio_sdin = audio_left_tmp[15];
            5'd1: audio_sdin = audio_left_tmp[14];
            5'd2: audio_sdin = audio_left_tmp[13];
            5'd3: audio_sdin = audio_left_tmp[12]; 
            5'd4: audio_sdin = audio_left_tmp[11]; 
            5'd5: audio_sdin = audio_left_tmp[10]; 
            5'd6: audio_sdin = audio_left_tmp[9]; 
            5'd7: audio_sdin = audio_left_tmp[8]; 
            5'd8: audio_sdin = audio_left_tmp[7];
            5'd9: audio_sdin = audio_left_tmp[6];            
            5'd10: audio_sdin = audio_left_tmp[5];
            5'd11: audio_sdin = audio_left_tmp[4];
            5'd12: audio_sdin = audio_left_tmp[3];
            5'd13: audio_sdin = audio_left_tmp[2];
            5'd14: audio_sdin = audio_left_tmp[1];
            5'd15: audio_sdin = audio_left_tmp[0];
            5'd16: audio_sdin = audio_right_tmp[15];
            5'd17: audio_sdin = audio_right_tmp[14];
            5'd18: audio_sdin = audio_right_tmp[13];
            5'd19: audio_sdin = audio_right_tmp[12];
            5'd20: audio_sdin = audio_right_tmp[11];
            5'd21: audio_sdin = audio_right_tmp[10];
            5'd22: audio_sdin = audio_right_tmp[9];
            5'd23: audio_sdin = audio_right_tmp[8];
            5'd24: audio_sdin = audio_right_tmp[7];
            5'd25: audio_sdin = audio_right_tmp[6];
            5'd26: audio_sdin = audio_right_tmp[5];
            5'd27: audio_sdin = audio_right_tmp[4];
            5'd28: audio_sdin = audio_right_tmp[3];
            5'd29: audio_sdin = audio_right_tmp[2];
            5'd30: audio_sdin = audio_right_tmp[1];
            5'd31: audio_sdin = audio_right_tmp[0];
    endcase             
                
endmodule
