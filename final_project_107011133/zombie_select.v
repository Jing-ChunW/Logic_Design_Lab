`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/26 23:56:21
// Design Name: 
// Module Name: zombie_select
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


module zombie_select(
    input [2:0] LFSRnum,
    input no_zombie,
    input z0_in,
    input z1_in,
    input z2_in,
    input [2:0] state,
    output reg z0,
    output reg z1,
    output reg z2,
    output reg z3,
    output reg z4,
    output reg z5,
    output reg z6, 
    output reg z7,
    output reg z8,
    output reg z9,
    output reg z10,
    output reg z11,
    output reg z12,
    output reg z13,
    output reg z14,
    output reg [9:0] total,
    output reg [9:0] score_num,
    output reg [9:0] miss_num,
    input clk,
    input clk_22,
    input rst,
    input [9:0] h_cnt,
    input [9:0] v_cnt
    );
    parameter idle = 3'b000;
    parameter play = 3'b001;
    parameter stop = 3'b010;
    parameter score = 3'b011;
    parameter speed = 3'b100;
    parameter miss = 3'b101;
    reg [9:0] line_down, line_up;
    reg z0_next, z1_next, z2_next, z3_next, z4_next, z5_next, z6_next, z7_next, z8_next, z9_next, z10_next, z11_next, z12_next, z13_next, z14_next;
    reg z0_tag, z0_tag_next, z1_tag, z1_tag_next, z2_tag, z2_tag_next, z3_tag, z3_tag_next, z4_tag, z4_tag_next, z5_tag, z5_tag_next, z6_tag, z6_tag_next;
    reg z7_tag, z7_tag_next, z8_tag, z8_tag_next, z9_tag, z9_tag_next, z10_tag, z10_tag_next, z11_tag, z11_tag_next, z12_tag, z12_tag_next, z13_tag, z13_tag_next, z14_tag, z14_tag_next;
    reg [9:0] cnt, cnt_next, cnt1, cnt1_next;
    reg [9:0] v_down0, v_up0;
  reg [9:0] v_down1, v_up1;
  reg [9:0] v_down2, v_up2;
  reg [9:0] v_down3, v_up3;
  reg [9:0] v_down4, v_up4;

always @(posedge clk_22 or posedge rst) begin
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

reg [9:0] total_next, score_num_next, miss_next;


always @(posedge clk or posedge rst) begin
    if (rst) begin
        z0_tag <= 1'b0;
        z1_tag <= 1'b0;
        z2_tag <= 1'b0;
        z3_tag <= 1'b0;
        z4_tag <= 1'b0;
        z5_tag <= 1'b0;
        z6_tag <= 1'b0;
        z7_tag <= 1'b0;
        z8_tag <= 1'b0;
        z9_tag <= 1'b0;
        z10_tag <= 1'b0;
        z11_tag <= 1'b0;
        z12_tag <= 1'b0;
        z13_tag <= 1'b0;
        z14_tag <= 1'b0;
    end else begin
        if (state == play) begin
            z0_tag <=  z0_tag_next;
            z1_tag <=  z1_tag_next;
            z2_tag <=  z2_tag_next;
            z3_tag <=  z3_tag_next;
            z4_tag <=  z4_tag_next;
            z5_tag <=  z5_tag_next;
            z6_tag <=  z6_tag_next;
            z7_tag <=  z7_tag_next;
            z8_tag <=  z8_tag_next;
            z9_tag <=  z9_tag_next;
            z10_tag <=  z10_tag_next;
            z11_tag <=  z11_tag_next;
            z12_tag <=  z12_tag_next;
            z13_tag <=  z13_tag_next;
            z14_tag <=  z14_tag_next;
        end else begin
            z0_tag <= 1'b0;
            z1_tag <= 1'b0;
            z2_tag <= 1'b0;
            z3_tag <= 1'b0;
            z4_tag <= 1'b0;
            z5_tag <= 1'b0;
            z6_tag <= 1'b0;
            z7_tag <= 1'b0;
            z8_tag <= 1'b0;
            z9_tag <= 1'b0;
            z10_tag <= 1'b0;
            z11_tag <= 1'b0;
            z12_tag <= 1'b0;
            z13_tag <= 1'b0;
            z14_tag <= 1'b0;
        end
    end
end

  always @(posedge clk or posedge rst) begin
    if (rst) begin
        z0 <= 1'b1;
        z1 <= 1'b1;
        z2 <= 1'b1;
        z3 <= 1'b1;
        z4 <= 1'b1;
        z5 <= 1'b1;
        z6 <= 1'b1;
        z7 <= 1'b1;
        z8 <= 1'b1;
        z9 <= 1'b1;
        z10 <= 1'b1;
        z11 <= 1'b1;
        z12 <= 1'b1;
        z13 <= 1'b1;
        z14 <= 1'b1; 
    end else begin
        if (state == play) begin
            z0 <= z0_next;
            z1 <= z1_next;
            z2 <= z2_next;
            z3 <= z3_next;
            z4 <= z4_next;
            z5 <= z5_next;
            z6 <= z6_next;
            z7 <= z7_next;
            z8 <= z8_next;
            z9 <= z9_next;
            z10 <= z10_next;
            z11 <= z11_next;
            z12 <= z12_next;
            z13 <= z13_next;
            z14 <= z14_next;
        end else begin
            z0 <= 1'b1;
            z1 <= 1'b1;
            z2 <= 1'b1;
            z3 <= 1'b1;
            z4 <= 1'b1;
            z5 <= 1'b1;
            z6 <= 1'b1;
            z7 <= 1'b1;
            z8 <= 1'b1;
            z9 <= 1'b1;
            z10 <= 1'b1;
            z11 <= 1'b1;
            z12 <= 1'b1;
            z13 <= 1'b1;
            z14 <= 1'b1; 
        end
    end
  end
  
  always @(posedge clk_22 or posedge rst) begin
    if (rst) begin
        cnt <= 10'd0;
    end else begin
        cnt <= cnt_next;
    end
  end
  
  always @(*) begin
    if (cnt == 10'd479) begin
        cnt_next = 10'd0;
    end else begin
        cnt_next = cnt + 1;
    end
  end
  
  always @(posedge clk_22 or posedge rst) begin
    if (rst) begin
        cnt1 <= 10'd0;
    end else begin 
        cnt1 <= cnt1_next;
    end
  end
  
  always @(*) begin
    if (cnt == 10'd479) begin
        cnt1_next = 0;
    end else begin
        cnt1_next = cnt1 + 1;
    end
  end
  
    always @(*) begin
    line_up = 10'd479;
    line_down = 10'd384;
  end
  
  always @(posedge clk_22 or posedge rst) begin
    if (rst) total <= 10'd0;
    else total <= total_next;
  end
  
  always @(posedge clk or posedge rst) begin
    if (rst) score_num <= 10'd0;
    else begin
        if (state == idle) score_num <= 10'd0;
        else if (state == play) score_num <= score_num_next;
        else score_num <= score_num;
    end
  end
  
  always @(posedge clk or posedge rst) begin
    if (rst) miss_num <= 10'd0;
    else begin
        if (state == idle) miss_num <= 10'd0;
        else if (state == play) begin
            miss_num <= miss_next;
        end else miss_num <= miss_num;
    end
  end
  
  always @(*) begin
    if (state == idle) begin
        total_next = 10'd0;
    end
    else if (state == play) begin
        if (cnt == 10'd479 || cnt1 == 10'd95 || cnt1 == 10'd191 || cnt1 == 10'd287 || cnt1 == 10'd383) begin
            if (no_zombie) total_next = total;
            else total_next = total + {9'd0,~LFSRnum[0]} + {9'd0, ~LFSRnum[1]} + {9'd0, ~LFSRnum[2]};
        end else total_next = total;
    end else total_next = total;
  end
  
   always @(*) begin
    
    score_num_next = score_num;
    if (cnt == 10'd479) begin
        if (no_zombie) begin
            z0_next = 1'b1;
            z1_next = 1'b1;
            z2_next = 1'b1;
        end else begin
            z0_next = LFSRnum[0];
            z1_next = LFSRnum[1];
            z2_next = LFSRnum[2];
        end
    end else begin
        if ((v_down0 >= line_down && v_down0 <= line_up) || (v_up0 <= line_up && v_up0 >= line_down)) begin
            if (z0_in) begin
                if (z0 == 1'b0) score_num_next = score_num + 1'b1;
                z0_next = 1'b1;
            end else begin 
                z0_next = z0;
            end
            if (z1_in) begin
                if (z1 == 1'b0) score_num_next = score_num + 1'b1;
                z1_next = 1'b1;
            end else begin
                z1_next = z1;
            end
            if (z2_in) begin
                if (z2 == 1'b0) score_num_next = score_num + 1'b1;
                z2_next = 1'b1;
            end else begin
                z2_next = z2;
            end
        end else begin
            z0_next = z0;
            z1_next = z1;
            z2_next = z2;
        end
    end
    if (cnt1 == 10'd95) begin
        if (no_zombie) begin
            z3_next = 1'b1;
            z4_next = 1'b1;
            z5_next = 1'b1;
        end else begin
            z3_next = LFSRnum[0];
            z4_next = LFSRnum[1];
            z5_next = LFSRnum[2];
        end
    end else begin
        if ((v_down1 >= line_down && v_down1 <= line_up) || (v_up1 <= line_up && v_up1 >= line_down)) begin
            if (z0_in) begin
                if (z3 == 1'b0) score_num_next = score_num + 1'b1;
                z3_next = 1'b1;
            end else begin
                z3_next = z3;
            end
            if (z1_in) begin
                if (z4 == 1'b0) score_num_next = score_num + 1'b1;
                z4_next = 1'b1;
            end else begin
                z4_next = z4;
            end
            if (z2_in) begin
                if (z5 == 1'b0) score_num_next = score_num + 1'b1;
                z5_next = 1'b1;
            end else begin
                z5_next = z5;
            end
        end else begin
            z3_next = z3;
            z4_next = z4;
            z5_next = z5;
        end
    end
    if (cnt1 == 10'd191) begin
        if (no_zombie) begin
            z6_next = 1'b1;
            z7_next = 1'b1;
            z8_next = 1'b1;
        end else begin
            z6_next = LFSRnum[0];
            z7_next = LFSRnum[1];
            z8_next = LFSRnum[2];
        end
    end else begin
        if ((v_down2 >= line_down && v_down2 <= line_up) || (v_up2 <= line_up && v_up2 >= line_down)) begin
            if (z0_in) begin
                if (z6 == 1'b0) score_num_next = score_num + 1'b1;
                z6_next = 1'b1;
            end else begin
                z6_next = z6;
            end
            if (z1_in) begin
                if (z7 == 1'b0) score_num_next = score_num + 1'b1;
                z7_next = 1'b1;
            end else begin
                z7_next = z7;
            end
            if (z2_in) begin
                if (z8 == 1'b0) score_num_next = score_num + 1'b1;
                z8_next = 1'b1;
            end else begin
                z8_next = z8;
            end
        end else begin
            z6_next = z6;
            z7_next = z7;
            z8_next = z8;
        end
    end
    if (cnt1 == 10'd287) begin
        if (no_zombie) begin
            z9_next = 1'b1;
            z10_next = 1'b1;
            z11_next = 1'b1;
        end else begin
            z9_next = LFSRnum[0];
            z10_next = LFSRnum[1];
            z11_next = LFSRnum[2];
        end
    end else begin
        if ((v_down3 >= line_down && v_down3 <= line_up) || (v_up3 <= line_up && v_up3 >= line_down)) begin
            if (z0_in) begin
                if (z9 == 1'b0) score_num_next = score_num + 1'b1;
                z9_next = 1'b1;
            end else begin
                z9_next = z9;
            end
            if (z1_in) begin
                if (z10 == 1'b0) score_num_next = score_num + 1'b1;
                z10_next = 1'b1;
            end else begin
                z10_next = z10;
            end
            if (z2_in) begin
                if (z11 == 1'b0) score_num_next = score_num + 1'b1;
                z11_next = 1'b1;
            end else begin
                z11_next = z11;
            end
        end else begin
            z9_next = z9;
            z10_next = z10;
            z11_next = z11;
        end
    end
    if (cnt1 == 10'd383) begin
        if (no_zombie) begin
            z12_next = 1'b1;
            z13_next = 1'b1;
            z14_next = 1'b1;
        end else begin
            z12_next = LFSRnum[0];
            z13_next = LFSRnum[1];
            z14_next = LFSRnum[2];
        end
    end else begin
        if ((v_down4 >= line_down && v_down4 <= line_up) || (v_up4 <= line_up && v_up4 >= line_down)) begin
            if (z0_in) begin
                if (z12 == 1'b0) score_num_next = score_num + 1'b1;
                z12_next = 1'b1;
            end else begin
                z12_next = z12;
            end
            if (z1_in) begin
                if (z13 == 1'b0) score_num_next = score_num + 1'b1;
                z13_next = 1'b1;
            end else begin
                z13_next = z13;
            end
            if (z2_in) begin
                if (z14 == 1'b0) score_num_next = score_num + 1'b1;
                z14_next = 1'b1;
            end else begin
                z14_next = z14;
            end
        end else begin
            z12_next = z12;
            z13_next = z13;
            z14_next = z14;
        end
    end
  end
   always @(*) begin
    miss_next = miss_num;
    if (cnt == 10'd479) begin
        if (no_zombie) begin
            z0_tag_next = 1'b0;
            z1_tag_next = 1'b0;
            z2_tag_next = 1'b0;
        end else begin
            z0_tag_next = 1'b1;
            z1_tag_next = 1'b1;
            z2_tag_next = 1'b1;
        end
    end else begin
        if ((v_down0 >= line_down && v_down0 <= line_up) || (v_up0 <= line_up && v_up0 >= line_down)) begin
            if (z0_in) begin
                if (z0 == 1'b1 && z0_tag == 1'b1 && ((z12 == 1'b1 && (v_down4 >= line_down && v_down4 <= line_up)) || ( z3 == 1'b1 && (v_up1 <= line_up && v_up1 >= line_down)))) miss_next = miss_num + 1'b1;
                z0_tag_next = 1'b0;
            end else begin 
                z0_tag_next = z0_tag;
            end
            if (z1_in) begin
                if (z1 == 1'b1 && z1_tag == 1'b1 && ((z13 == 1'b1 && (v_down4 >= line_down && v_down4 <= line_up)) || ( z4 == 1'b1 && (v_up1 <= line_up && v_up1 >= line_down)))) miss_next = miss_num + 1'b1;
                z1_tag_next = 1'b0;
            end else begin
                z1_tag_next = z1_tag;
            end
            if (z2_in) begin
                if (z2 == 1'b1 && z2_tag == 1'b1 && ((z14 == 1'b1 && (v_down4 >= line_down && v_down4 <= line_up)) || ( z5 == 1'b1 && (v_up1 <= line_up && v_up1 >= line_down)))) miss_next = miss_num + 1'b1;
                z2_tag_next = 1'b0;
            end else begin
                z2_tag_next = z2_tag;
            end
        end else begin
            z0_tag_next = z0_tag;
            z1_tag_next = z1_tag;
            z2_tag_next = z2_tag;
        end
    end
    if (cnt1 == 10'd95) begin
        if (no_zombie) begin
            z3_tag_next = 1'b0;
            z4_tag_next = 1'b0;
            z5_tag_next = 1'b0;
        end else begin
            z3_tag_next = 1'b1;
            z4_tag_next = 1'b1;
            z5_tag_next = 1'b1;
        end
    end else begin
        if ((v_down1 >= line_down && v_down1 <= line_up) || (v_up1 <= line_up && v_up1 >= line_down)) begin
            if (z0_in) begin
                if (z3 == 1'b1 && z3_tag == 1'b1 && ((z0 == 1'b1 && (v_down0 >= line_down && v_down0 <= line_up)) || ( z6 == 1'b1 && (v_up2 <= line_up && v_up2 >= line_down)))) miss_next = miss_num + 1'b1;
                z3_tag_next = 1'b0;
            end else begin
                z3_tag_next = z3_tag;
            end
            if (z1_in) begin
                if (z4 == 1'b1 && z4_tag == 1'b1 && ((z1 == 1'b1 && (v_down0 >= line_down && v_down0 <= line_up)) || ( z7 == 1'b1 && (v_up2 <= line_up && v_up2 >= line_down)))) miss_next = miss_num + 1'b1;
                z4_tag_next = 1'b0;
            end else begin
                z4_tag_next = z4_tag;
            end
            if (z2_in) begin
                if (z5 == 1'b1 && z5_tag == 1'b1 && ((z2 == 1'b1 && (v_down0 >= line_down && v_down0 <= line_up)) || ( z8 == 1'b1 && (v_up2 <= line_up && v_up2 >= line_down)))) miss_next = miss_num + 1'b1;
                z5_tag_next = 1'b0;
            end else begin
                z5_tag_next = z5_tag;
            end
        end else begin
            z3_tag_next = z3_tag;
            z4_tag_next = z4_tag;
            z5_tag_next = z5_tag;
        end
    end
    if (cnt1 == 10'd191) begin
        if (no_zombie) begin
            z6_tag_next = 1'b0;
            z7_tag_next = 1'b0;
            z8_tag_next = 1'b0;
        end else begin
            z6_tag_next = 1'b1;
            z7_tag_next = 1'b1;
            z8_tag_next = 1'b1;
        end
    end else begin
        if ((v_down2 >= line_down && v_down2 <= line_up) || (v_up2 <= line_up && v_up2 >= line_down)) begin
            if (z0_in) begin
                if (z6 == 1'b1 && z6_tag == 1'b1 && ((z3 == 1'b1 && (v_down1 >= line_down && v_down1 <= line_up)) || ( z9 == 1'b1 && (v_up3 <= line_up && v_up3 >= line_down)))) miss_next = miss_num + 1'b1;
                z6_tag_next = 1'b0;
            end else begin
                z6_tag_next = z6_tag;
            end
            if (z1_in) begin
                if (z7 == 1'b1 && z7_tag == 1'b1 && ((z4 == 1'b1 && (v_down1 >= line_down && v_down1 <= line_up)) || ( z10 == 1'b1 && (v_up3 <= line_up && v_up3 >= line_down)))) miss_next = miss_num + 1'b1;
                z7_tag_next = 1'b0;
            end else begin
                z7_tag_next = z7_tag;
            end
            if (z2_in) begin
                if (z8 == 1'b1 && z8_tag == 1'b1 && ((z5 == 1'b1 && (v_down1 >= line_down && v_down1 <= line_up)) || ( z11 == 1'b1 && (v_up3 <= line_up && v_up3 >= line_down)))) miss_next = miss_num + 1'b1;
                z8_tag_next = 1'b0;
            end else begin
                z8_tag_next = z8_tag;
            end
        end else begin
            z6_tag_next = z6_tag;
            z7_tag_next = z7_tag;
            z8_tag_next = z8_tag;
        end
    end
    if (cnt1 == 10'd287) begin
        if (no_zombie) begin
            z9_tag_next = 1'b0;
            z10_tag_next = 1'b0;
            z11_tag_next = 1'b0;
        end else begin
            z9_tag_next = 1'b1;
            z10_tag_next = 1'b1;
            z11_tag_next = 1'b1;
        end
    end else begin
        if ((v_down3 >= line_down && v_down3 <= line_up) || (v_up3 <= line_up && v_up3 >= line_down)) begin
            if (z0_in) begin
                if (z9 == 1'b1 && z9_tag == 1'b1 && ((z6 == 1'b1 && (v_down2 >= line_down && v_down2 <= line_up)) || ( z12 == 1'b1 && (v_up4 <= line_up && v_up4 >= line_down)))) miss_next = miss_num + 1'b1;
                z9_tag_next = 1'b0;
            end else begin
                z9_tag_next = z9_tag;
            end
            if (z1_in) begin
                if (z10 == 1'b1 && z10_tag == 1'b1 && ((z7 == 1'b1 && (v_down2 >= line_down && v_down2 <= line_up)) || ( z13 == 1'b1 && (v_up4 <= line_up && v_up4 >= line_down)))) miss_next = miss_num + 1'b1;
                z10_tag_next = 1'b0;
            end else begin
                z10_tag_next = z10_tag;
            end
            if (z2_in) begin
                if (z11 == 1'b1 && z11_tag == 1'b1 && ((z8 == 1'b1 && (v_down2 >= line_down && v_down2 <= line_up)) || ( z14 == 1'b1 && (v_up4 <= line_up && v_up4 >= line_down)))) miss_next = miss_num + 1'b1;
                z11_tag_next = 1'b0;
            end else begin
                z11_tag_next = z11_tag;
            end
        end else begin
            z9_tag_next = z9_tag;
            z10_tag_next = z10_tag;
            z11_tag_next = z11_tag;
        end
    end
    if (cnt1 == 10'd383) begin
        if (no_zombie) begin
            z12_tag_next = 1'b0;
            z13_tag_next = 1'b0;
            z14_tag_next = 1'b0;
        end else begin
            z12_tag_next = 1'b1;
            z13_tag_next = 1'b1;
            z14_tag_next = 1'b1;
        end
    end else begin
        if ((v_down4 >= line_down && v_down4 <= line_up) || (v_up4 <= line_up && v_up4 >= line_down)) begin
            if (z0_in) begin
                if (z12 == 1'b1 && z12_tag == 1'b1 && ((z9 == 1'b1 && (v_down3 >= line_down && v_down3 <= line_up)) || ( z0 == 1'b1 && (v_up0 <= line_up && v_up0 >= line_down)))) miss_next = miss_num + 1'b1;
                z12_tag_next = 1'b0;
            end else begin
                z12_tag_next = z12_tag;
            end
            if (z1_in) begin
                if (z13 == 1'b1 && z13_tag == 1'b1 && ((z10 == 1'b1 && (v_down3 >= line_down && v_down3 <= line_up)) || ( z1 == 1'b1 && (v_up0 <= line_up && v_up0 >= line_down)))) miss_next = miss_num + 1'b1;
                z13_tag_next = 1'b0;
            end else begin
                z13_tag_next = z13_tag;
            end
            if (z2_in) begin
                if (z14 == 1'b1 && z14_tag == 1'b1 && ((z11 == 1'b1 && (v_down3 >= line_down && v_down3 <= line_up)) || ( z2 == 1'b1 && (v_up0 <= line_up && v_up0 >= line_down)))) miss_next = miss_num + 1'b1;
                z14_tag_next = 1'b0;
            end else begin
                z14_tag_next = z14_tag;
            end
        end else begin
            z12_tag_next = z12_tag;
            z13_tag_next = z13_tag;
            z14_tag_next = z14_tag;
        end
    end
  end
endmodule

