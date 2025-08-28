//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   top_fpga_tb
 Author:        kszdom
 Description:   testbench module for top_basys3
 */
//////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ps

module top_fpga_tb;

  // clock + reset
  logic clk_in1;
  logic sw0;     // reset switch
  logic sw14;    // mtm_show switch
  logic sw15;    // startgame switch

  // buttons
  logic btnU, btnD, btnL, btnR, btnC;

  // outputs
  wire [7:0] JB;
  wire [7:0] JC;
  wire JA1;
  wire led15, led14, led0;
  wire [6:0] seg;
  wire [3:0] an;

  // clock gen 100 MHz
  localparam CLK_PERIOD = 10;
  initial begin
    clk_in1 = 0;
    forever #(CLK_PERIOD/2) clk_in1 = ~clk_in1;
  end

  // DUT instance
  top_basys3 dut (
    .clk_in1(clk_in1),
    .JB(JB),
    .JC(JC),
    .JA1(JA1),
    .btnU(btnU),
    .btnC(btnC),
    .btnD(btnD),
    .btnL(btnL),
    .btnR(btnR),
    .sw0(sw0),
    .sw15(sw15),
    .sw14(sw14),
    .led15(led15),
    .led14(led14),
    .led0(led0),
    .seg(seg),
    .an(an)
  );

  // stimulus
  initial begin
    // init
    sw0 = 0;
    sw14 = 0;
    sw15 = 0;
    btnU = 0; btnD = 0; btnL = 0; btnR = 0; btnC = 0;

    // reset pulse
    #100;
    sw0 = 1;
    #200;
    sw0 = 0;

    // wait a bit
    #1000;

    // press startgame
    sw15 = 1;
    #200;
    sw15 = 0;

    // move cursor around
    repeat (3) begin
      #500 btnU = 1; #200 btnU = 0;
      #500 btnR = 1; #200 btnR = 0;
      #500 btnD = 1; #200 btnD = 0;
      #500 btnL = 1; #200 btnL = 0;
    end

    // center button click
    #1000 btnC = 1;
    #200 btnC = 0;

    // enable MTM show
    #2000 sw14 = 1;
    #500 sw14 = 0;
  end

  // stop simulation when JA1 is asserted
  always @(posedge JA1) begin
    $display("JA1 received at time %t, stopping simulation.", $time);
    $finish;
  end

  // timeout just in case JA1 never comes
  initial begin
    #5_000_000;
    $display("Timeout: JA1 was never asserted.");
    $finish;
  end

endmodule
