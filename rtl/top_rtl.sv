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

        input logic [OUT_WIDTH-1:0] xcursor,
        input logic [OUT_WIDTH-1:0] ycursor,


        output logic go_flag,
        output logic halt_flag,

        input logic rst,
        
        output wire [OUT_WIDTH-1:0] xch,
        output wire [OUT_WIDTH-1:0] ych
        
    );
    timeunit 1ns;
    timeprecision 1ps;

    import vector_pkg::*;
    import img_pkg::*;


    // INTERNAL WIRES
    logic [ADDRESSWIDTH-1:0] ROM_addr;
    logic [ADDRESSWIDTH-1:0] RAM_addr;
    logic [ADDRESSWIDTH-1:0] RAM_write_adr;
    logic [DATAWIDTH-1:0] ROM_data;
    logic [DATAWIDTH-1:0] RAM_data;
    logic [DATAWIDTH-1:0] RAM_write_data;

    //logic enable_vector;

   // wire [11:0] Xmouse;
    //wire [11:0] Ymouse;
    //wire Rmouse;
    //wire Lmouse;


    logic go;
    logic halt;

    assign go_flag      = go;   //debug
    assign halt_flag    = halt;   //debug


    //MODULE DECLARATIONS

    top_vector_display #(
        .OUT_WIDTH(OUT_WIDTH),
        .ADDRESSWIDTH(ADDRESSWIDTH),
        .DATAWIDTH(DATAWIDTH)
    ) u_vector_display (
        .clk(clk4MHz),
        .rst(rst),
        .go_master(go),

        .data_in(RAM_data),
        .addr(RAM_addr),
        .halt(halt),

        .x_ch(xch),
        .y_ch(ych)
    );

    logic [OUT_WIDTH-1:0] xenemy1;
    logic [OUT_WIDTH-1:0] yenemy1;
    logic spawn_enemy1;

    logic [OUT_WIDTH-1:0] xenemy2;
    logic [OUT_WIDTH-1:0] yenemy2;
    logic spawn_enemy2;

    logic [OUT_WIDTH-1:0] xenemy3;
    logic [OUT_WIDTH-1:0] yenemy3;
    logic spawn_enemy3;


    wire base1_nuked, base2_nuked, base3_nuked;



    game_logic_top #(
        .ADDRESSWIDTH(ADDRESSWIDTH),
        .OUT_WIDTH(OUT_WIDTH)
    ) u_game_logic_top (
        .clk100MHz(clk100MHz),
        .clk40MHz(clk40MHz),
        .clk4MHz(clk4MHz),
        .rst(rst),

        .spawn_enemy1(spawn_enemy1),
        .xenemy1(xenemy1),
        .yenemy1(yenemy1),

        .spawn_enemy2(spawn_enemy2),
        .xenemy2(xenemy2),
        .yenemy2(yenemy2),

        .spawn_enemy3(spawn_enemy3),
        .xenemy3(xenemy3),
        .yenemy3(yenemy3),



        .base1_nuked(base1_nuked),
        .base2_nuked(base2_nuked),
        .base3_nuked(base3_nuked)
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
        
        .go(go),  // to jest rozkaz ze mozna zaczac rysowac klatkę - RAM jest zapełniony danymi
        .halt(halt),  // to sygnał że narysoano klatke na oscyloskopie - prosze zrobic kolejna i dac nowe dane do RAMU

        //  from mouse input signals
        .xcursor(xcursor),
        .ycursor(ycursor),


        .spawn_enemy1(spawn_enemy1),
        .xenemy1(xenemy1),
        .yenemy1(yenemy1),
        .adr_enemy1(ADR_ICBM_START),

        .spawn_enemy2(spawn_enemy2),
        .xenemy2(xenemy2),
        .yenemy2(yenemy2),
        .adr_enemy2(ADR_FIGHTER_START),

        .spawn_enemy3(spawn_enemy3),
        .xenemy3(xenemy3),
        .yenemy3(yenemy3),
        .adr_enemy3(ADR_SPYPLANE_START),

        .base1_nuked(base1_nuked),
        .base2_nuked(base2_nuked),
        .base3_nuked(base3_nuked)

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


    img_rom #(
        .ADDRESSWIDTH(ADDRESSWIDTH),
        .DATAWIDTH(DATAWIDTH)
    ) u_img_rom (
        .addr(ROM_addr),
        .data_out(ROM_data)
    );

endmodule