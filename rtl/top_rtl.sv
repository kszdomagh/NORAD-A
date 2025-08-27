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

        input logic clk_slow,
        input logic clk_fast,
        input logic rst,

        input logic [OUT_WIDTH-1:0] xcursor,
        input logic [OUT_WIDTH-1:0] ycursor,
        input logic button_click,
        output wire [OUT_WIDTH-1:0] killcount,
        input logic startgame,
        input logic mtm_show,

        output logic go_flag,
        output logic halt_flag,
        
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



    logic [ADDRESSWIDTH-1:0] startscreen_addr;
    logic [DATAWIDTH-1:0] startscreen_data;

    logic [ADDRESSWIDTH-1:0] endscreen_addr;
    logic [DATAWIDTH-1:0] endscreen_data;

    logic [ADDRESSWIDTH-1:0] vectordisplay_addr;
    logic [DATAWIDTH-1:0] vectordisplay_data;

    logic [ADDRESSWIDTH-1:0] mtm_addr;
    logic [DATAWIDTH-1:0] mtm_data;



    logic go, halt;

    assign go_flag      = go;   //debug
    assign halt_flag    = halt;   //debug


    //MODULE DECLARATIONS

    top_vector_display #(
        .OUT_WIDTH(OUT_WIDTH),
        .ADDRESSWIDTH(ADDRESSWIDTH),
        .DATAWIDTH(DATAWIDTH),
        .CEASE_CYCLES(CEASE_CYCLES)
    ) u_vector_display (
        .clk(clk_slow),
        .rst(rst),
        .go_master(go),

        .data_in(vectordisplay_data),
        .addr(vectordisplay_addr),
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

    logic [ADDRESSWIDTH-1:0] adr_enemy1, adr_enemy2, adr_enemy3;

    logic [OUT_WIDTH-1:0] x_missile, y_missile;


    game_logic_top #(
        .ADDRESSWIDTH(ADDRESSWIDTH),
        .OUT_WIDTH(OUT_WIDTH),

        //DESTROY PLANE ANIMATIONS TIME
        .DESTOY_ANIMATION_TIME(40_000_000), //  half a second

        // SPAWN TIMES FOR ENEMIES
        .TIME_SPAWN_ENEMY1(10_000_000),
        .TIME_SPAWN_ENEMY2(12_000_000),
        .TIME_SPAWN_ENEMY3(15_000_000),

        //SPEEDS FOR ENEMIES
        .TIME_SPEED_ENEMY1(50_000_000),
        .TIME_SPEED_ENEMY2(40_000_000),
        .TIME_SPEED_ENEMY3(30_000_000)
    ) u_game_logic_top (
        .clk_fast(clk_fast),
        .clk_slow(clk_slow),
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

        .click(button_click),
        .xcursor(xcursor),
        .ycursor(ycursor),
        .killcount(killcount),



        .base1_nuked(base1_nuked),
        .base2_nuked(base2_nuked),
        .base3_nuked(base3_nuked),

        .adr_enemy1(adr_enemy1),
        .adr_enemy2(adr_enemy2),
        .adr_enemy3(adr_enemy3),

        .x_missile(x_missile),
        .y_missile(y_missile),
        .spawn_missile(spawn_missile)

    );


    memory_manage #(
        .ADR_WIDTH(ADDRESSWIDTH),
        .DATAWIDTH(DATAWIDTH),
        .OUT_WIDTH(OUT_WIDTH)
    ) u_memory_manage (
        //  control signals
        .clk(clk_fast),
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
        .adr_enemy1(adr_enemy1),

        .spawn_enemy2(spawn_enemy2),
        .xenemy2(xenemy2),
        .yenemy2(yenemy2),
        .adr_enemy2(adr_enemy2),

        .spawn_enemy3(spawn_enemy3),
        .xenemy3(xenemy3),
        .yenemy3(yenemy3),
        .adr_enemy3(adr_enemy3),

        .base1_nuked(base1_nuked),
        .base2_nuked(base2_nuked),
        .base3_nuked(base3_nuked),

        .x_missile(x_missile),
        .y_missile(y_missile),
        .spawn_missile(spawn_missile)

    );

    template_ram #(
        .ADDRESSWIDTH(ADDRESSWIDTH),
        .BITWIDTH(DATAWIDTH),
        .DEPTH(1000) //1000 punktow moge zapisac
    ) u_RAM_module (
        .clk(clk_fast),

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


    screen_manage #(
        .ADRESSWIDTH(ADDRESSWIDTH),
        .DATAWIDTH(DATAWIDTH)
    ) u_screen_manage (
        .adr_endscreen(endscreen_addr),
        .data_endscreen(endscreen_data),

        .adr_ram(RAM_addr),
        .data_ram(RAM_data),

        .adr_startscreen(startscreen_addr),
        .data_startscreen(startscreen_data),

        .adr_mtm(mtm_addr),
        .data_mtm(mtm_data),

        .base1_nuked(base1_nuked),
        .base2_nuked(base2_nuked),
        .base3_nuked(base3_nuked),
        .start_game(startgame),
        .mtm_show(mtm_show),
        

        .adr_in(vectordisplay_addr),
        .data_out(vectordisplay_data)
    );



    mtm_rom #(
        .ADDRESSWIDTH(ADDRESSWIDTH),
        .DATAWIDTH(DATAWIDTH)
    ) u_mtm_rom (
        .addr(mtm_addr),
        .data_out(mtm_data)
    );



    start_screen_rom #(
        .ADDRESSWIDTH(ADDRESSWIDTH),
        .DATAWIDTH(DATAWIDTH)
    ) u_start_rom (
        .addr(startscreen_addr),
        .data_out(startscreen_data)
    );


    end_screen_rom #(
        .ADDRESSWIDTH(ADDRESSWIDTH),
        .DATAWIDTH(DATAWIDTH)
    ) u_end_rom (
        .addr(endscreen_addr),
        .data_out(endscreen_data)
    );

endmodule