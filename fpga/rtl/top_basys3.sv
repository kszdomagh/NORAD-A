//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   top_basys3
 Author:        kszdom
 Description:  top level synthesizable module including the project top and all the hardware-related modules.
 */
//////////////////////////////////////////////////////////////////////////////

module top_basys3 (
        input  wire clk_in1,

//        mouse not used
//        inout wire PS2Clk,
//        inout wire PS2Data,

        // x channel 8bit
        output wire [7:0] JB,
        // y channel 8bit
        output wire [7:0] JC,
        //  oscilo trig
        output wire JA1,

        //reset
        input logic sw0,
        output logic led0,

        //cursor
        input logic btnU,
        input logic btnC,
        input logic btnD,
        input logic btnL,
        input logic btnR,

        //buttons leds
        input logic sw15,
        input logic sw14,

        output logic led15,
        output logic led14,


        //  7SEG
        output wire [6:0] seg,
        output wire [3:0] an



    );

    timeunit 1ns;
    timeprecision 1ps;


    import vector_pkg::*;
    import img_pkg::*;

    logic clk_fast;
    logic clk_slow;

    logic [OUT_WIDTH-1:0] killcount;
    logic sw15_db;
    logic sw14_db;
    logic rst;


    //  debug signals
    assign led0 = rst;
    assign led15 = sw15_db;
    assign led14 = sw14_db;




    //  debounce for reset
    debounce u_debounce_reset (
        .clk(clk_fast),
        .sw(sw0),
        .db_level(rst),
        .db_tick(),
        .reset(1'b0)
    );


    // signals fro cursor control
    logic [DAC_WIDTH-1:0] ycursor;
    logic [DAC_WIDTH-1:0] xcursor;


    //  clk manager
    clk_wiz_0 u_clk_manager (
        .clk_in1(clk_in1),

        .clk100MHz(),       //not connectewd timimg req not met
        .clk80MHz(clk_fast),
        .clk5MHz(clk_slow),

        .reset(1'b0)    //not connected

    );

    logic btnU_db, btnC_db, btnD_db, btnL_db, btnR_db; //debounced buttons


    //  debounce for cursor buttons
    debounce u_debounce_UP (
        .clk(clk_fast),
        .reset(rst),
        .sw(btnU),
        .db_level(),
        .db_tick(btnU_db)
    );

    debounce u_debounce_DOWN (
        .clk(clk_fast),
        .reset(rst),
        .sw(btnD),
        .db_level(),
        .db_tick(btnD_db)
    );

    debounce u_debounce_LEFT (
        .clk(clk_fast),
        .reset(rst),
        .sw(btnL),
        .db_level(),
        .db_tick(btnL_db)
    );


    debounce u_debounce_RIGHT (
        .clk(clk_fast),
        .reset(rst),
        .sw(btnR),
        .db_level(),
        .db_tick(btnR_db)
    );

    debounce u_debounce_CENTER (
        .clk(clk_fast),
        .reset(rst),
        .sw(btnC),
        .db_level(),
        .db_tick(btnC_db)
    );


    debounce u_debounce_START (
        .clk(clk_fast),
        .reset(rst),
        .sw(sw15),
        .db_level(sw15_db),
        .db_tick()
    );


    debounce u_debounce_MTM (
        .clk(clk_fast),
        .reset(rst),
        .sw(sw14),
        .db_level(sw14_db),
        .db_tick()
    );



    //      cursor control module
    cursor #(
        .MAXVAL(CURSORMAX),
        .MINVAL(CURSORMIN),
        .OUTWIDTH(DAC_WIDTH),
        .STEP(5)
    ) u_cursor_manage (
        .clk(clk_fast),
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
        .clk_fast(clk_fast),
        .clk_slow(clk_slow),
        .rst(rst),

        .xcursor(xcursor),
        .ycursor(ycursor),
        .button_click(btnC_db),
        .killcount(killcount),

        .go_flag(JA1),     //not connected
        .halt_flag(halt_flag),   //not connected



        //      old tht with pins DAC
        //.xch( {JB[4], JB[5], JB[6], JB[7], JB[0], JB[1], JB[2], JB[3]} ),
        //      y_ch is flipped lsb x_ch = msb dac_x
        //.ych( {JC[0], JC[1], JC[2], JC[3], JC[4], JC[5], JC[6], JC[7]} )

        .startgame(sw15_db),
        .mtm_show(sw14_db),


        //      new smd with sma connectors DAC
        .xch( {JB[3], JB[7], JB[2], JB[6], JB[1], JB[5], JB[0], JB[4]} ),
        .ych( {JC[3], JC[7], JC[2], JC[6], JC[1], JC[5], JC[0], JC[4]} )

    );





    logic [3:0] hex0;
    logic [3:0] hex1;
    logic [3:0] hex2;
    logic [3:0] hex3;

    num_to_hex #(
        .BIN_WIDTH(14)
    ) u_num_to_bcd(
        .bin_in({6'd0, killcount}),

        .bcd_thousands(hex3),
        .bcd_hundreds(hex2),
        .bcd_tens(hex1),
        .bcd_ones(hex0)

    );

    disp_hex_mux u_bcd_display (
        .clk(clk_fast),
        .reset(rst),
        .sseg( {1'b0, seg} ),
        .dp_in(4'b0000),
        .an(an),

        .hex0(hex0), // prawo
        .hex1(hex1),

        .hex2(hex2),
        .hex3(hex3)  // lewo
    );





    // NOT IN USE


/*    //      MOUSE CONTROL MODULE
    MouseCtl u_MouseCtl (
        .clk(clk_fast),
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
