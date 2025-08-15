//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   top_rtl
 Author:        kszdom
 Description:  module with all non-hardware submodules used by the design
 */
//////////////////////////////////////////////////////////////////////////////
module top_rtl#(
    parameter int ADDRESSWIDTH = 16, 
    parameter int DATAWIDTH = 18,
    parameter int OUT_WIDTH = 8
    )(

        input logic clk100MHz,
        input logic clk40MHz,
        input logic clk4MHz,

        input logic rst,

        inout logic ps2_clk,
        inout logic ps2_data,
        
        output wire [OUT_WIDTH-1:0] xch,
        output wire [OUT_WIDTH-1:0] ych,

        output logic [11:0] Xmouse_debug
        
    );
    timeunit 1ns;
    timeprecision 1ps;

    import vector_pkg::*;
    import ROM_pkg::*;
    //import uwu_pkg::*;


    // INTERNAL WIRES
    logic [ADDRESSWIDTH-1:0] ROM_addr;
    logic [ADDRESSWIDTH-1:0] RAM_addr;
    logic [ADDRESSWIDTH-1:0] RAM_write_adr;
    logic [DATAWIDTH-1:0] ROM_data;
    logic [DATAWIDTH-1:0] RAM_data;
    logic [DATAWIDTH-1:0] RAM_write_data;

    logic frame_done;
    logic enable_vector;

    wire [11:0] Xmouse;
    wire [11:0] Ymouse;
    wire Rmouse;
    wire Lmouse;

    assign Xmouse_debug = Xmouse;


    //MODULE DECLARATIONS

    top_vector_display #(
        .OUT_WIDTH(OUT_WIDTH),
        .ADDRESSWIDTH(ADDRESSWIDTH),
        .DATAWIDTH(DATAWIDTH)
    ) u_vector_display (
        .clk(clk4MHz),
        .rst(rst),
        .enable(enable_vector),

        .data_in(RAM_data),
        .addr(RAM_addr),
        .frame_drawn(frame_done),

        .x_ch(xch),
        .y_ch(ych)
    );

    //      MOUSE CONTROL MODULE
    MouseCtl u_MouseCtl (
        .clk(clk100MHz),
        .rst,
        
        .ps2_clk(ps2_clk),
        .ps2_data(ps2_data),

        .xpos(Xmouse),
        .ypos(Ymouse),
        .right(Rmouse),
        .left(Lmouse),

        .setmax_x(8'd255),
        .setmax_y(8'd255)
    );

    // enemy stuff
    wire enemy1_speed_pulse;
    wire spawn_pulse;

    timer_cluster #(
        .TIME1(50_000_000),
        .TIME_SLOW(10_000_000)
    ) u_timer_cluster (
        .clk100MHz(clk100MHz),
        .clk4MHz(clk4MHz),
        .rst(rst),

        .speed1_pulse(enemy1_speed_pulse),
        .slow1_pulse(spawn_pulse)
    );

    logic [OUT_WIDTH-1:0] xenemy1;
    logic [OUT_WIDTH-1:0] yenemy1;
    wire spawn_enemy1;

    enemy_control #(
        .OUT_WIDTH(OUT_WIDTH),
        .TARGET_BASE(1)
    ) u_enemy1_control (
        .clk(clk100MHz),
        .rst(rst),
        .spawn_pulse(spawn_pulse),
        .speed_pulse(enemy1_speed_pulse),

        .xenemy(xenemy1),
        .yenemy(yenemy1),
        .spawn(spawn_enemy1)
    );

    memory_manage #(
        .ADR_WIDTH(ADDRESSWIDTH),
        .DATAWIDTH(DATAWIDTH),
        .OUT_WIDTH(OUT_WIDTH)
    ) u_memory_manage (
        //  control signals
        .clk(clk100MHz),
        .rst(rst),
        //  image ROM
        .adrROM(ROM_addr),
        .dataROM(ROM_data),

        //  RAM 
        .adrWRITE(RAM_write_adr),
        .dataWRITE(RAM_write_data),
        
        .draw_frame(enable_vector),  // to jest rozkaz ze mozna zaczac rysowac klatkę - RAM jest zapełniony danymi
        .frame_done(frame_done),  // to sygnał że narysoano klatke na oscyloskopie - prosze zrobic kolejna i dac nowe dane do RAMU

        //  from mouse input signals
        .x_cursor(Xmouse),
        .y_cursor(Ymouse),


        .sprawn_enemy1(spawn_enemy1),
        .xenemy1(xenemy1),
        .yenemy1(yenemy1)
    );

    template_ram #(
        .ADDRESSWIDTH(ADDRESSWIDTH),
        .BITWIDTH(DATAWIDTH),
        .DEPTH(1000) //1000 punktow moge zapisac
    ) u_RAM_module (
        .clk(clk100MHz),

        //  READ ONLY
        .adr_r(RAM_addr),
        .data_out_r(RAM_data),

        //  READ N WRITE 
        .data_out_rw(), // not connected
        .adr_rw(RAM_write_adr),
        .din(RAM_write_data),
        .we(1)
    );


    uwu_rom #(
        .ADDRESSWIDTH(ADDRESSWIDTH),
        .DATAWIDTH(DATAWIDTH)
    ) u_uwu_rom (
        .addr(ROM_addr),
        .data_out(ROM_data)
    );

endmodule