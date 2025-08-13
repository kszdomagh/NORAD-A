/**
 * San Jose State University
 * EE178 Lab #4
 * Author: prof. Eric Crabilla
 *
 * Modified by:
 * 2025  AGH University of Science and Technology
 * MTM UEC2
 * Piotr Kaczmarczyk
 *
 * Description:
 * Top level synthesizable module including the project top and all the FPGA-referred modules.
 */

module top_basys3 (
        input  wire clk_in,
        input  wire btnC,

        output wire JA1,

        inout logic ps2data,
        input logic ps2clk,

        // x channel 8bit
        output wire [7:0] JB,
        // y channel 8bit
        output wire [7:0] JC,

        output wire LD0

    );

    timeunit 1ns;
    timeprecision 1ps;


    import vector_pkg::*;

    logic clk4MHz;
    logic clk100MHz;
    logic clk40MHz;

    assign JA1=clk4MHz; // debug clk

    // mouse control input
    MouseCtl u_mouse_controller (
        .clk(),
        .rst(0),
        .xpos(xmouse),
        .ypos(ymouse),
        .right(r_button),
        .left(l_button),
        .middle(m_button)
    );


    //  clk manager
    clk_wiz_0 u_clk_manager (
        .clk_in(clk_in),

        .clk100MHz(clk100MHz),
        .clk40MHz(clk40MHz),
        .clk4MHz(clk4MHz),

        .reset(btnC)

    );


    //  top rtl
    top_rtl u_top_rtl(
        .clk100MHz(clk100MHz),
        .clk40MHz(clk40MHz),
        .clk4MHz(clk4MHz),
        .rst(btnC),

        .xch( {JB[4], JB[5], JB[6], JB[7], JB[0], JB[1], JB[2], JB[3]} ),

        //      y_ch is flipped lsb x_ch = msb dac_x
        .ych( {JC[0], JC[1], JC[2], JC[3], JC[4], JC[5], JC[6], JC[7]} ),
        .frame_drawn(LD0)
    );




endmodule
