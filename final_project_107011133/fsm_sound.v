`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/26 23:58:16
// Design Name: 
// Module Name: fsm_sound
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


`define DO 22'd191571
`define RE 22'd170648
`define MI 22'd151515
`define FA 22'd143266
`define SO 22'd127551
`define LA 22'd113636
`define SILENCE 22'd0

module fsm_sound(
    input f,
    input rst,
    input en,
    output reg[21:0] note_div
);

reg [5:0] state, state_next;

always@(*)
    case(state)
        6'd0: note_div = `SO;
        6'd1: note_div = `SO;
        6'd2: note_div = `LA;
        6'd3: note_div = `LA;
        6'd4: note_div = `SO;
        6'd5: note_div = `SO;
		6'd6: note_div = `FA;
        6'd7: note_div = `FA;	//
        6'd8: note_div = `MI;
        6'd9: note_div = `MI;	
        6'd10: note_div = `FA;
        6'd11: note_div = `FA;
        6'd12: note_div = `FA;	
        6'd13: note_div = `SO;
        6'd14: note_div = `SO;
        6'd15: note_div = `SO;  //
        6'd16: note_div = `RE;
        6'd17: note_div = `RE;
        6'd18: note_div = `MI;
        6'd19: note_div = `MI;
        6'd20: note_div = `FA;
        6'd21: note_div = `FA;
        6'd22: note_div = `FA;	//
        6'd23: note_div = `MI;
        6'd24: note_div = `MI;
        6'd25: note_div = `FA;
        6'd26: note_div = `FA;
        6'd27: note_div = `SO;
        6'd28: note_div = `SO;
        6'd29: note_div = `SO;
        6'd30: note_div = `SILENCE;
        6'd31: note_div = `SO;
        6'd32: note_div = `SO;
        6'd33: note_div = `LA;
        6'd34: note_div = `LA;
        6'd35: note_div = `SO;
        6'd36: note_div = `SO;
        6'd37: note_div = `FA;
        6'd38: note_div = `FA;	
        6'd39: note_div = `FA;	//
        6'd40: note_div = `MI;
        6'd41: note_div = `MI;	
        6'd42: note_div = `FA;
        6'd43: note_div = `FA;
        6'd44: note_div = `SO;
        6'd45: note_div = `SO;
        6'd46: note_div = `SO;	//		
        6'd47: note_div = `RE;
        6'd48: note_div = `RE;
        6'd49: note_div = `SO;
        6'd50: note_div = `SO;
        6'd51: note_div = `SO;
        6'd52: note_div = `MI;
        6'd53: note_div = `MI;
        6'd54: note_div = `DO;
        6'd55: note_div = `DO;
        6'd56: note_div = `DO;
        6'd57: note_div = `DO;
        6'd58: note_div = `SILENCE;
       default: note_div = `SILENCE;
    endcase  	
                
    always@(*)
        if (state == 6'd58) 
            state_next = 6'd0;
        else
            state_next = state + 1'd1;
                
    always @(posedge f or posedge rst)
    if (rst)
        state = 6'd58;
    else if (en)
        state = state_next;
    else
        state =  6'd58;
    
endmodule

