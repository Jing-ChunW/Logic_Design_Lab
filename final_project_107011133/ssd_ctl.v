`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/27 00:03:45
// Design Name: 
// Module Name: ssd_ctl
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
module ssd_ctl(
    input [2-1:0] ctl_en,
    input [`SSD_BIT_WIDTH*4-1:0] in_ssd,
    output reg [4-1:0] an,
    output reg [`SSD_BIT_WIDTH-1:0] ssd
    );
    
    always @(*) begin
        case (ctl_en) 
            2'b00: an = 4'b1110;
            2'b01: an = 4'b1101;
            2'b10: an = 4'b1011;
            2'b11: an = 4'b0111;
            default: an = 4'b1111;
        endcase
    end
    always @(*) begin
        case(ctl_en)
            2'b00: ssd = in_ssd[7:0];
            2'b01: ssd = in_ssd[15:8];
            2'b10: ssd = in_ssd[23:16];
            2'b11: ssd = in_ssd[31:24];
            default: ssd = `SSD_DEFAULT;
        endcase
    end

endmodule

