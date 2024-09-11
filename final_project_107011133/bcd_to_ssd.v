`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/27 00:04:12
// Design Name: 
// Module Name: bcd_to_ssd
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


`define BCD_BIT_WIDTH 4
`define ENABLE 1'b1
`define DISABLE 1'b0
`define INCREMENT 1'b1
// for binary to ssd table
`define SSD_BIT_WIDTH 8
`define SSD0 8'b00000011
`define SSD1 8'b10011111
`define SSD2 8'b00100101
`define SSD3 8'b00001101
`define SSD4 8'b10011001
`define SSD5 8'b01001001
`define SSD6 8'b01000001
`define SSD7 8'b00011111
`define SSD8 8'b00000001
`define SSD9 8'b00001001
`define SSD_DEFAULT 8'b11111111

module bcd_to_ssd(

    input [`BCD_BIT_WIDTH-1:0] bcd,
    output reg [`SSD_BIT_WIDTH-1:0] ssd
    );
    always @(*) begin
        case(bcd)
            4'd0: ssd = `SSD0;//O
            4'd1: ssd = `SSD1;//I
            4'd2: ssd = `SSD2;
            4'd3: ssd = `SSD3;
            4'd4: ssd = `SSD4;
            4'd5: ssd = `SSD5;//S
            4'd6: ssd = `SSD6;
            4'd7: ssd = `SSD7;
            4'd8: ssd = `SSD8;
            4'd9: ssd = `SSD9;
            4'd10: ssd = 8'b11100011;//L
            4'd11: ssd = 8'b01100001;//E
            4'd12: ssd = 8'b10000011;//V
            4'd13: ssd = 8'b00010011;//N
            default: ssd = `SSD_DEFAULT;
        endcase
    end

endmodule
