`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/27 00:06:06
// Design Name: 
// Module Name: mem_addr_gen
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


module mem_addr_gen(
  input clk,
  input rst,
  input [2:0] state,
  input [9:0] h_cnt,
  input [9:0] v_cnt,
  input z0,
  input z1,
  input z2,
  input z3,
  input z4,
  input z5,
  input z6,
  input z7,
  input z8,
  input z9,
  input z10,
  input z11,
  input z12,
  input z13,
  input z14,
  output reg [16:0] pixel_addr
);
  parameter idle = 3'b000;
  parameter play = 3'b001;
  parameter stop = 3'b010;
  parameter score = 3'b011;
  parameter speed = 3'b100;
  parameter miss = 3'b101;
  reg [7:0] position;
  reg tag1, tag2, tag3;
  reg [9:0] v_down0, v_up0;
  reg [9:0] v_down1, v_up1;
  reg [9:0] v_down2, v_up2;
  reg [9:0] v_down3, v_up3;
  reg [9:0] v_down4, v_up4;


always @(posedge clk or posedge rst) begin
    if (rst) begin
        v_down0 <= 10'd0;
        v_up0 <= 10'd95;
        v_down1 <= 10'b1110100000;//10'd672;
        v_up1 <= 10'b1111111111;//10'd767;
        v_down2 <= 10'b1101000000;//10'd576;
        v_up2 <= 10'b1110011111;//10'd671;
        v_down3 <= 10'b1011100000;//10'd480;
        v_up3 <= 10'b1100111111;//10'd575;
        v_down4 <= 10'b1010000000;
        v_up4 <= 10'b1011011111;
    end
    else begin
        v_down0 <= (v_down0 + 1)%480;
        v_up0 <= (v_up0 + 1)%480;
        if (v_down1 < 10'b1010000000 && v_up1 < 10'b1010000000) begin
            v_down1 <= (v_down1 + 1)%480;
            v_up1 <= (v_up1 + 1)%480;
        end else begin
            v_down1 <= v_down1 + 1;
            v_up1 <= v_up1 + 1;
        end
        if (v_down2 < 10'b1010000000 && v_up2 < 10'b1010000000) begin
            v_down2 <= (v_down2 + 1)%480;
            v_up2 <= (v_up2 + 1)%480;
        end else begin
            v_down2 <= v_down2 + 1;
            v_up2 <= v_up2 + 1;
        end
        if (v_down3 < 10'b1010000000 && v_up3 < 10'b1010000000) begin
            v_down3 <= (v_down3 + 1)%480;
            v_up3 <= (v_up3 + 1)%480;
        end else begin
            v_down3 <= v_down3 + 1;
            v_up3 <= v_up3 + 1;
        end
        if (v_down4 < 10'b1010000000 && v_up4 < 10'b1010000000) begin
            v_down4 <= (v_down4 + 1)%480;
            v_up4 <= (v_up4 + 1)%480;
        end else begin
            v_down4 <= v_down4 + 1;
            v_up4 <= v_up4 + 1;
        end
    end
end


always@*
    if (state == idle) begin
        if (h_cnt > 170 && h_cnt < 470) 
            if (v_cnt >= 140 && v_cnt <= 340) pixel_addr = ((h_cnt - 170)>>1)+150*((v_cnt - 140)>>1) + 18432;
    end
    else if (state == speed) begin
        if (h_cnt > 170 && h_cnt < 470) 
            if (v_cnt >= 140 && v_cnt <= 340) pixel_addr = ((h_cnt - 170)>>1)+150*((v_cnt - 140)>>1) + 33432;
    end
    else if (state == play) begin
        if(v_cnt >= v_down0 & v_cnt <= v_up0)
            if(h_cnt < 176)
                pixel_addr = 0;
            else if(h_cnt < 272)
                pixel_addr = (v_cnt-v_down0)*96+h_cnt-176 + 9216 * z0;
            else if(h_cnt < 368)
                pixel_addr = (v_cnt-v_down0)*96+h_cnt-272 + 9216 * z1;
            else if(h_cnt < 464)
                pixel_addr = (v_cnt-v_down0)*96+h_cnt-368 + 9216 * z2;
            else pixel_addr = 0;
        else if(v_cnt >= v_down1 & v_cnt <= v_up1)
            if(h_cnt < 176)
                pixel_addr = 0;
            else if(h_cnt < 272)
                pixel_addr = (v_cnt-v_down1)*96+h_cnt-176 + 9216 * z3;
            else if(h_cnt < 368)
                pixel_addr = (v_cnt-v_down1)*96+h_cnt-272 + 9216 * z4;
            else if(h_cnt < 464)
                pixel_addr = (v_cnt-v_down1)*96+h_cnt-368 + 9216 * z5;
            else pixel_addr = 0;
        else if(v_cnt >= v_down2 & v_cnt <= v_up2)
            if(h_cnt < 176)
                pixel_addr = 0;
            else if(h_cnt < 272)
                pixel_addr = (v_cnt-v_down2)*96+h_cnt-176 + 9216 * z6;
            else if(h_cnt < 368)
                pixel_addr = (v_cnt-v_down2)*96+h_cnt-272 + 9216 * z7;
            else if(h_cnt < 464)
                pixel_addr = (v_cnt-v_down2)*96+h_cnt-368 + 9216 * z8;
            else pixel_addr = 0;
        else if(v_cnt >= v_down3  & v_cnt <= v_up3)
            if(h_cnt < 176)
                pixel_addr = 0;
            else if(h_cnt < 272)
                pixel_addr = (v_cnt-v_down3)*96+h_cnt-176 + 9216 * z9;
            else if(h_cnt < 368)
                pixel_addr = (v_cnt-v_down3)*96+h_cnt-272 + 9216 * z10;
            else if(h_cnt < 464)
                pixel_addr = (v_cnt-v_down3)*96+h_cnt-368 + 9216 * z11;
            else pixel_addr = 0;
        else if(v_cnt >= v_down4  & v_cnt <= v_up4)
            if(h_cnt < 176)
                pixel_addr = 0;
            else if(h_cnt < 272)
                pixel_addr = (v_cnt-v_down4)*96+h_cnt-176 + 9216 * z12;
            else if(h_cnt < 368)
                pixel_addr = (v_cnt-v_down4)*96+h_cnt-272 + 9216 * z13;
            else if(h_cnt < 464)
                pixel_addr = (v_cnt-v_down4)*96+h_cnt-368 + 9216 * z14;
            else pixel_addr = 0;
        else pixel_addr = 0;
    end
 
endmodule


