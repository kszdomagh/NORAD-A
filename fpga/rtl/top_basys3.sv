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

        inout wire PS2Clk,
        inout wire PS2Data,

        // x channel 8bit
        output wire [7:0] JB,
        // y channel 8bit
        output wire [7:0] JC,

        //reset
        input logic sw0,

        //cursor
        input logic btnU,
        input logic btnC,
        input logic btnD,
        input logic btnL,
        input logic btnR,


        //  7SEG
        output wire [6:0] seg,
        output wire [3:0] an



    );

    timeunit 1ns;
    timeprecision 1ps;


    import vector_pkg::*;
    import img_pkg::*;

    logic clk4MHz;
    logic clk100MHz;
    logic clk40MHz;

    //  mouse signals
    wire [7:0] Xmouse;
    wire [7:0] Ymouse;
    wire Lmouse;
    wire Rmouse;
    logic [7:0] X_debug;


    //  debug signals




    //  debounce for reset
    debounce u_debounce_reset (
        .clk(clk100MHz),
        .sw(sw0),
        .db_level(rst),
        .db_tick()
    );


    // signals fro cursor control
    logic [DAC_WIDTH-1:0] ycursor;
    logic [DAC_WIDTH-1:0] xcursor;


    //  clk manager
    clk_wiz_0 u_clk_manager (
        .clk_in(clk_in),

        .clk100MHz(clk100MHz),
        .clk40MHz(clk40MHz),
        .clk4MHz(clk4MHz),

        .reset(rst)

    );

    logic btnU_db, btnC_db, btnD_db, btnL_db, btnR_db; //debounced buttons


    //  debounce for cursor buttons
    debounce u_debounce_UP (
        .clk(clk100MHz),
        .reset(rst),
        .sw(btnU),
        .db_level(),
        .db_tick(btnU_db)
    );

    debounce u_debounce_DOWN (
        .clk(clk100MHz),
        .reset(rst),
        .sw(btnD),
        .db_level(),
        .db_tick(btnD_db)
    );

    debounce u_debounce_LEFT (
        .clk(clk100MHz),
        .reset(rst),
        .sw(btnL),
        .db_level(),
        .db_tick(btnL_db)
    );


    debounce u_debounce_RIGHT (
        .clk(clk100MHz),
        .reset(rst),
        .sw(btnR),
        .db_level(),
        .db_tick(btnR_db)
    );

    debounce u_debounce_CENTER (
        .clk(clk100MHz),
        .reset(rst),
        .sw(btnC),
        .db_level(),
        .db_tick(btnC_db)
    );





    //      cursor control module
    cursor #(
        .MAXVAL(VECTOR_MAX),
        .MINVAL(VECTOR_MIN),
        .OUTWIDTH(DAC_WIDTH),
        .STEP(10)
    ) u_cursor_buttons (
        .clk(clk100MHz),
        .rst(rst),

        //cursor control
        .btnU(btnU_db),
        .btnC(btnC_db),
        .btnD(btnD_db),
        .btnL(btnL_db),
        .btnR(btnR_db),

        //outputs
        .xcursor(xcursor),
        .ycursor(ycursor)

    );





    //  top rtl
    top_rtl u_top_rtl(
        .clk100MHz(clk100MHz),
        .clk40MHz(clk40MHz),
        .clk4MHz(clk4MHz),
        .rst(rst),

        .xcursor(xcursor),
        .ycursor(ycursor),

        .go_flag(),     //not connected
        .halt_flag(),   //not connected


        .xch( {JB[4], JB[5], JB[6], JB[7], JB[0], JB[1], JB[2], JB[3]} ),
        //      y_ch is flipped lsb x_ch = msb dac_x
        .ych( {JC[0], JC[1], JC[2], JC[3], JC[4], JC[5], JC[6], JC[7]} )

    );





    logic [3:0] hex0;
    logic [3:0] hex1;
    logic [3:0] hex2;
    logic [3:0] hex3;

    num_to_hex #(
        .NUMBER_BIT(8)
    ) u_num_to_bcd(
        .number(X_debug),

        .bcd_thousands(hex3),
        .bcd_hundreds(hex2),
        .bcd_tens(hex1),
        .bcd_ones(hex0)

    );

    disp_hex_mux u_bcd_display (
        .clk(clk100MHz),
        .reset(rst),
        .sseg(seg),
        .an(an),

        .hex0(hex0), // prawo
        .hex1(hex1),

        .hex2(hex2),
        .hex3(hex3)  // lewo
    );





    // NOT IN USE


/*    //      MOUSE CONTROL MODULE
    MouseCtl u_MouseCtl (
        .clk(clk100MHz),
        .rst(rst),
        
        .ps2_clk(PS2Clk),
        .ps2_data(PS2Data),

        .xpos(Xmouse),
        .ypos(Ymouse),
        .right(Rmouse),
        .left(Lmouse),

        .setmax_x(8'd255),
        .setmax_y(8'd255),



        .setx(8'd128),
        .sety(8'd128),
        .value(1)
    );
*/


endmodule
