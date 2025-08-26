//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   missile_top
 Author:        kszdom
 Description:  module with all non-hardware submodules used by the design
 */
//////////////////////////////////////////////////////////////////////////////
module missile_top#(
    parameter int OUT_WIDTH = 8,
    parameter  CEASE_CYCLES = 4_000_000
    )(
        input logic clk_fast,
        input logic rst,

        input logic [OUT_WIDTH-1:0] xcursor,
        input logic [OUT_WIDTH-1:0] ycursor,
        input logic fired,

        // enemy signals
        input logic [OUT_WIDTH-1:0] xenemy1,
        input logic [OUT_WIDTH-1:0] yenemy1,
        input logic spawn_enemy1,

        input logic [OUT_WIDTH-1:0] xenemy2,
        input logic [OUT_WIDTH-1:0] yenemy2,
        input logic spawn_enemy2,

        input logic [OUT_WIDTH-1:0] xenemy3,
        input logic [OUT_WIDTH-1:0] yenemy3,
        input logic spawn_enemy3,

        output logic hit1,
        output logic hit2,
        output logic hit3,


        
        output wire [OUT_WIDTH-1:0] x_missile,
        output wire [OUT_WIDTH-1:0] y_missile
        
    );

    timeunit 1ns;
    timeprecision 1ps;

    import vector_pkg::*;
    import img_pkg::*;

    logic bren_go, bren_done, valid_drawing;

    wire [OUT_WIDTH-1:0] xflying_end, yflying_end;
    wire [OUT_WIDTH:0] xbren, ybren;




    missile_main #() u_missile_main (
        .clk(clk_fast),
        .rst(rst),

        .fired(fired),
        .valid_drawing(valid_drawing),
        .bren_done(bren_done),
        .bren_go(bren_go),

        .xcursor(xcursor),
        .ycursor(ycursor),

        .yflying(y_missile),
        .xflying(x_missile),

//      FROM ENEMY MODULES
        .xenemy1(xenemy1),
        .yenemy1(yenemy1),
        .spawn_enemy1(spawn_enemy1),

        .xenemy2(xenemy2),
        .yenemy2(yenemy2),
        .spawn_enemy2(spawn_enemy2),
        
        .xenemy3(xenemy3),
        .yenemy3(yenemy3),
        .spawn_enemy3(spawn_enemy3),

//      TO ENEMY MODULES
        .hit1(hit1),
        .hit2(hit2),
        .hit3(hit3),

//      TO AND FROM BREN MODULE
        .xflying_end(xflying_end),
        .yflying_end(yflying_end)


    );


    bresenham #(
        .BRES_WIDTH(OUT_WIDTH+1),
        .CEASE_CYCLES(CEASE_CYCLES)   // half a sec
    ) u_bresenham (
        .clk(clk_fast),
        .rst(rst),
        .go(bren_go), 
        .enable(bren_go),

        .done(bren_done),
        .busy(draw_busy),

        .stax( {1'b0, X_MISSILE_START} ),
        .stay({1'b0, Y_MISSILE_START}),

        .endx( {1'b0, xflying_end} ),
        .endy( {1'b0, yflying_end} ),

        .x(xbren),
        .y(ybren),
        .drawing(valid_drawing)
    );

    valid_buf #(
        .BRES_WIDTH(OUT_WIDTH+1),
        .OUTWIDTH(OUT_WIDTH)
    ) u_valid_buf (
        .clk(clk_fast),
        .rst(rst),
        .enable(1'b1),

        .valid(valid_drawing),

        .inx(xbren),
        .iny(ybren),
        .outx(x_missile),
        .outy(y_missile)
    );



endmodule