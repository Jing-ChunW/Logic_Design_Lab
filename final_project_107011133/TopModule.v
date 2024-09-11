`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/26 23:55:13
// Design Name: 
// Module Name: TopModule
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


module TopModule(
    input clk,
    input rst,
    //output [11:0] zombie_pos,
    output reg [3:0] vgaRed,
    output reg [3:0] vgaGreen,
    output reg [3:0] vgaBlue,
    output hsync,
    output vsync,
    //input z0_in,
    //input z1_in,
    //input z2_in,
    output switch_led,
    input btn,
    input btn_score,
    input btn_miss,
    output [5:0] led,
    inout PS2_CLK, 
    inout PS2_DATA,
    input switch,
    output [3:0] an,
    output [7:0] ssd,
    output audio_mclk, audio_lrck, audio_sck, audio_sdin
    );
    reg z0_in, z1_in, z2_in;
    assign switch_led = switch;
    //wire z0_in_onepulse, z1_in_onepulse, z2_in_onepulse, z0_in_db, z1_in_db, z2_in_db;
    reg [9:0] line_up, line_down;
    wire [9:0] total;
    wire [9:0] score_num, miss_num;
    wire [511:0] key_down;
    wire [8:0] last_change;
    wire z0, z1, z2, z3, z4, z5, z6, z7, z8, z9, z10, z11, z12, z13, z14;
    wire [2:0] LFSRnum;
    wire [11:0] data;
    wire clk_25MHz;
    wire clk_22;
    wire [16:0] pixel_addr;
    wire [11:0] pixel0;
    wire valid;
    wire [9:0] h_cnt;
    wire [9:0] v_cnt;
    wire key_valid;
    wire clk_LFSR;
    wire btn_onepulse, btn_score_onepulse, btn_db, btn_score_db, btn_miss_db, btn_miss_onepulse;
    wire stop_tag_onepulse;
//assign led_stop = stop_tag_onepulse;
    wire [2:0] state;
    parameter idle = 3'b000;
    parameter play = 3'b001;
    parameter stop = 3'b010;
    parameter score = 3'b011;
    parameter speed = 3'b100;
    parameter miss = 3'b101;
    LFSR Ulfsr(.clk(clk_LFSR), .rst(rst), .LFSRnum(LFSRnum));
    debounce Udbbtn(.clk(clk), .rst(rst), .push_debounce(btn_db), .push(btn));
    onepulse1 Uonepulsebtn(.clk(clk), .rst(rst), .push_debounce(btn_db), .push_onepulse(btn_onepulse));
    debounce Udbbtnscore(.clk(clk), .rst(rst), .push_debounce(btn_score_db), .push(btn_score));
    onepulse1 Uonepulsebtnscore(.clk(clk), .rst(rst), .push_debounce(btn_score_db), .push_onepulse(btn_score_onepulse));
    debounce Udbbtnmiss(.clk(clk), .rst(rst), .push_debounce(btn_miss_db), .push(btn_miss));
    onepulse1 Uonepulsebtnmiss(.clk(clk), .rst(rst), .push_debounce(btn_miss_db), .push_onepulse(btn_miss_onepulse));
    fsm Ufsm(.clk(clk), .btn(btn_onepulse), .btn_miss(btn_miss_onepulse), .rst(rst), .stop_tag(stop_tag_onepulse), .btn_score(btn_score_onepulse), .state(state));
    /////////////////////////////////////////////led ctl  need state
    led_ctl Uled(.state(state), .led(led));
    wire no_zombie;
    ///////////////////////////////////////////game minute      stop_tag_onepulse
    game_minute Ugm(.clk(clk), .clk_LFSR(clk_LFSR), .switch(switch), .rst(rst), .state(state), .no_zombie(no_zombie), .stop_tag_onepulse(stop_tag_onepulse));
    //////////////////////////////////////////game minute
    // Frequency Divider
    /////////////////////////////////////////////////////////////////LFSR clk    need clk_22, rst
    clock_divisor_LFSR Ucdlfsr(.clk(clk_22), .rst(rst), .clk_LFSR(clk_LFSR));
    /////////////////////////////////////////////////////////////////LFSR clk
    wire z0_in_db, z1_in_db, z2_in_db, z0_in_onepulse, z1_in_onepulse, z2_in_onepulse;
  clock_divisor clk_wiz_0_inst(
    .clk(clk),
    .clk1(clk_25MHz),
    .clk22(clk_22),
    .state(state),
    .switch(switch)
  );
  ////////////////////////////////////////// zombie ctl   need clk, clk_22, last_change(keyboard)
  zombie_select Uzs(.LFSRnum(LFSRnum), .no_zombie(no_zombie), .z0_in(z0_in_onepulse), .z1_in(z1_in_onepulse), .z2_in(z2_in_onepulse), .state(state),
                  .z0(z0), .z1(z1), .z2(z2), .z3(z3), .z4(z4), .z5(z5), .z6(z6), .z7(z7), .z8(z8), .z9(z9), .z10(z10), .z11(z11), .z12(z12), .z13(z13), .z14(z14),
                  .clk(clk), .clk_22(clk_22), .rst(rst), .total(total), .score_num(score_num), .miss_num(miss_num), .v_cnt(v_cnt), .h_cnt(h_cnt));
  ////////////////////////////////////////// zombie ctl
always @(*) begin
    if (last_change == 9'h6B && key_down[last_change]) z0_in = 1'b1;
    else z0_in = 1'b0;
    if (last_change == 9'h72 && key_down[last_change]) z1_in = 1'b1;
    else z1_in = 1'b0;
    if (last_change == 9'h74 && key_down[last_change]) z2_in = 1'b1;
    else z2_in = 1'b0;
end

debounce Udbz0(.clk(clk), .rst(rst), .push_debounce(z0_in_db), .push(z0_in));
debounce Udbz1(.clk(clk), .rst(rst), .push_debounce(z1_in_db), .push(z1_in));
debounce Udbz2(.clk(clk), .rst(rst), .push_debounce(z2_in_db), .push(z2_in));
onepulse1 Uonepulsez0(.clk(clk), .rst(rst), .push_debounce(z0_in_db), .push_onepulse(z0_in_onepulse));
onepulse1 Uonepulsez1(.clk(clk), .rst(rst), .push_debounce(z1_in_db), .push_onepulse(z1_in_onepulse));
onepulse1 Uonepulsez2(.clk(clk), .rst(rst), .push_debounce(z2_in_db), .push_onepulse(z2_in_onepulse));

reg [3:0] value_0, value_1, value_2, value_3;
wire [7:0] in_ssd_0, in_ssd_1, in_ssd_2, in_ssd_3;
wire [31:0] in_ssd;
assign in_ssd = {in_ssd_0, in_ssd_1, in_ssd_2, in_ssd_3};
always @(*) begin
    if (state == stop) begin
        if (score_num == total && miss_num == 0) begin
            value_0 = 4'd12;
            value_1 = 4'd12;
            value_2 = 4'd1;
            value_3 = 4'd13;
        end else begin
            value_0 = 4'd10;
            value_1 = 4'd0;
            value_2 = 4'd5;
            value_3 = 4'd11;
        end
    end else if (state == miss) begin
        value_0 = 4'd15;
        value_1 = 4'd15;
        if (miss_num > 9) begin
            value_2 = miss_num / 10;
            value_3 = miss_num %10;
        end else begin
            value_2 = 4'd0;
            value_3 = miss_num;
        end
    end else if (state == score) begin
        if (score_num > 9) begin
            value_0 = score_num /10;
            value_1 = score_num %10;
        end else begin
            value_0 = 4'd0;
            value_1 = score_num;
        end
        if (total > 9) begin
            value_2 = total / 10;
            value_3 = total % 10;
        end else begin
            value_2 = 4'd0;
            value_3 = total;
        end
    end else begin
        value_0 = 4'd15;
        value_1 = 4'd15;
        value_2 = 4'd15;
        value_3 = 4'd15;
    end
end
wire[1:0] clk_ssd;
ssd_ctl Usc(.ctl_en(clk_ssd), .in_ssd(in_ssd), .an(an), .ssd(ssd));
bcd_to_ssd Ubcd0(.bcd(value_0), .ssd(in_ssd_0));
bcd_to_ssd Ubcd1(.bcd(value_1), .ssd(in_ssd_1));
bcd_to_ssd Ubcd2(.bcd(value_2), .ssd(in_ssd_2));
bcd_to_ssd Ubcd3(.bcd(value_3), .ssd(in_ssd_3));
clock_divisor_ssd Ucdssd(.clk(clk), .rst(rst), .f_out(clk_ssd));


  /////////////////////////////////////////keyboeard
  
  KeyboardDecoder Ukd(.last_change(last_change), .key_down(key_down), .key_valid(key_valid), .PS2_CLK(PS2_CLK), .PS2_DATA(PS2_DATA), .clk(clk), .rst(rst));
  
  // Reduce frame address from 640x480 to 320x240
  mem_addr_gen mem_addr_gen_inst(
    .clk(clk_22),
    .rst(rst),
    .state(state),
    .h_cnt(h_cnt),
    .v_cnt(v_cnt),
    .z0(z0),
    .z1(z1),
    .z2(z2),
    .z3(z3),
    .z4(z4),
    .z5(z5),
    .z6(z6),
    .z7(z7),
    .z8(z8),
    .z9(z9),
    .z10(z10),
    .z11(z11),
    .z12(z12),
    .z13(z13),
    .z14(z14),
    .pixel_addr(pixel_addr)
  );
       
  // Use reduced 320x240 address to output the saved picture from RAM 
  blk_mem_gen_0 blk_mem_gen_0_inst(
    .clka(clk_25MHz),
    .wea(0),
    .addra(pixel_addr),
    .dina(data[11:0]),
    .douta(pixel0)
  ); 

  // Render the picture by VGA controller
  vga_controller   vga_inst(
    .pclk(clk_25MHz),
    .reset(rst),
    .hsync(hsync),
    .vsync(vsync),
    .valid(valid),
    .h_cnt(h_cnt),
    .v_cnt(v_cnt)
  );
  always @(*) begin
    line_up = 10'd479;
    line_down = 10'd384;
  end
  always @(*) begin
      if (h_cnt < 176) begin
        {vgaRed,vgaGreen,vgaBlue} = 12'h0;
      end else if (h_cnt < 272) begin
        {vgaRed,vgaGreen,vgaBlue} = (valid == 1'b1) ? pixel0 : 12'h0;
        if (state == play) begin
            if (v_cnt == line_up) {vgaRed,vgaGreen,vgaBlue} = (valid == 1'b1) ? 12'hf00 : 12'h0;
            if (v_cnt == line_down) {vgaRed,vgaGreen,vgaBlue} = (valid == 1'b1) ? 12'hf00 : 12'h0;
        end
      end else if (h_cnt < 368) begin
        {vgaRed,vgaGreen,vgaBlue} = (valid == 1'b1) ? pixel0 : 12'h0;
        if (state == play) begin
            if (v_cnt == line_up) {vgaRed,vgaGreen,vgaBlue} = (valid == 1'b1) ? 12'hf00 : 12'h0;
            if (v_cnt == line_down) {vgaRed,vgaGreen,vgaBlue} = (valid == 1'b1) ? 12'hf00 : 12'h0;
        end
      end else if (h_cnt < 464) begin
        {vgaRed,vgaGreen,vgaBlue} = (valid == 1'b1) ? pixel0 : 12'h0;
        if (state == play) begin
            if (v_cnt == line_up) {vgaRed,vgaGreen,vgaBlue} = (valid == 1'b1) ? 12'hf00 : 12'h0;
            if (v_cnt == line_down) {vgaRed,vgaGreen,vgaBlue} = (valid == 1'b1) ? 12'hf00 : 12'h0;
        end
      end else begin
        {vgaRed,vgaGreen,vgaBlue} = 12'h0;
      end
  end
  reg sound_en;
  always @(*) begin
    if (state == play) sound_en = 1'b1;
    else sound_en = 1'b0;
  end
  sound_top Ust(.en(sound_en), .clk(clk), .switch(switch), .rst(rst), .audio_mclk(audio_mclk), .audio_lrck(audio_lrck), .audio_sck(audio_sck), .audio_sdin(audio_sdin));
endmodule

