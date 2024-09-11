`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/26 23:57:15
// Design Name: 
// Module Name: sound_top
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


module sound_top(
    input en,
    input clk,
    input rst,
    input switch,
    output audio_mclk, audio_lrck, audio_sck, audio_sdin
    );
    wire f;
    wire [21:0]note_div;
    wire [15:0]audio_left, audio_right;

freq_div_sound U0( .clk(clk), .rst(rst), .f(f), .switch(switch));
fsm_sound U1( .f(f), .rst(rst), .en(en), .note_div(note_div) );
note_gen U2( .clk(clk), .rst(rst),  .note_div(note_div), .audio_left(audio_left), .audio_right(audio_right) );
speaker_ctl U3( .clk(clk), .rst(rst), .audio_right(audio_right), .audio_left(audio_left), 
                .audio_mclk(audio_mclk), .audio_lrck(audio_lrck), .audio_sck(audio_sck), .audio_sdin(audio_sdin) );      
    
endmodule
