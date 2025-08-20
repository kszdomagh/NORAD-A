//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   game_logic_top
 Author:        kszdom
 Description:  
 */
//////////////////////////////////////////////////////////////////////////////
module game_logic_top#(
    parameter int ADDRESSWIDTH = 16, 
    parameter int OUT_WIDTH = 8,


    parameter int TIME_SPEED_ENEMY1 = 100_000_000,
    parameter int TIME_SPEED_ENEMY2 = 80_000_000,
    parameter int TIME_SPEED_ENEMY3 = 140_000_000,

    parameter int TIME_SPAWN_ENEMY1 = 10_000_000,
    parameter int TIME_SPAWN_ENEMY2 = 12_000_000,
    parameter int TIME_SPAWN_ENEMY3 = 4_000_000
    )(

        input logic clk100MHz,
        input logic clk40MHz,
        input logic clk4MHz,
        input logic rst,


        //  ENTITIES 
        output wire [OUT_WIDTH-1:0] yenemy1,
        output wire [OUT_WIDTH-1:0] xenemy1,
        output wire spawn_enemy1,
        output wire [ADDRESSWIDTH-1:0] adr_enemy1,


        output wire [OUT_WIDTH-1:0] yenemy2,
        output wire [OUT_WIDTH-1:0] xenemy2,
        output wire spawn_enemy2,
        output wire [ADDRESSWIDTH-1:0] adr_enemy2,


        output wire [OUT_WIDTH-1:0] yenemy3,
        output wire [OUT_WIDTH-1:0] xenemy3,
        output wire spawn_enemy3,
        output wire [ADDRESSWIDTH-1:0] adr_enemy3,



        output wire base1_nuked,
        output wire base2_nuked,
        output wire base3_nuked
        
    );
    timeunit 1ns;
    timeprecision 1ps;

    import vector_pkg::*;
    import img_pkg::*;
    //import uwu_pkg::*;


    // INTERNAL WIRES
    wire spawn_pulse1, spawn_pulse2, spawn_pulse3;
    wire speed_pulse1, speed_pulse2, speed_pulse3;

    //MODULE DECLARATIONS

    timer_cluster #(
        .TIME1(TIME_SPEED_ENEMY1),
        .TIME2(TIME_SPEED_ENEMY2),
        .TIME3(TIME_SPEED_ENEMY3),

        .TIME_SLOW1(TIME_SPAWN_ENEMY1),
        .TIME_SLOW2(TIME_SPAWN_ENEMY2),
        .TIME_SLOW3(TIME_SPAWN_ENEMY3)
    ) u_timer_cluster (
        .clk100MHz(clk100MHz),
        .clk4MHz(clk4MHz),
        .rst(rst),

        .speed1_pulse(speed_pulse1),
        .speed2_pulse(speed_pulse2),
        .speed3_pulse(speed_pulse3),


        .slow1_pulse(spawn_pulse1),
        .slow2_pulse(spawn_pulse2),
        .slow3_pulse(spawn_pulse3)
    );


    enemy_control #(
        .OUT_WIDTH(OUT_WIDTH),
        .ADDRESSWIDTH(ADDRESSWIDTH),

    //  cosmetics
        .DESTOY_ANIMATION_TIME(5),

    //  enemy range 
        .X_ENEMY_START(X_ENEMY_START),
        .X_ENEMY_END(X_ENEMY_END),

    //  base data
        .X_BASE(X_BASE1),
        .Y_ENEMY_BASE(Y_ENEMY1_BASE1)
    ) u_enemy1_control (
        .clk(clk100MHz),
        .rst(rst),
        
        .spawn_pulse(spawn_pulse1),
        .speed_pulse(speed_pulse1),

        .rockethit(0),
        .adr_enemy_start(ADR_BOMBER_START),

        .spawn(spawn_enemy1),
        .xenemy(xenemy1),
        .yenemy(yenemy1),
        .adr_enemy(adr_enemy1)
    );




    enemy_control #(
        .OUT_WIDTH(OUT_WIDTH),
        .ADDRESSWIDTH(ADDRESSWIDTH),

    //  cosmetics
        .DESTOY_ANIMATION_TIME(5),

    //  enemy range 
        .X_ENEMY_START(X_ENEMY_START),
        .X_ENEMY_END(X_ENEMY_END),

    //  base data
        .X_BASE(X_BASE2),
        .Y_ENEMY_BASE(Y_ENEMY2_BASE2)
    ) u_enemy2_control (
        .clk(clk100MHz),
        .rst(rst),
        
        .spawn_pulse(spawn_pulse2),
        .speed_pulse(speed_pulse2),

        .rockethit(0),
        .adr_enemy_start(ADR_FIGHTER_START),

        .spawn(spawn_enemy2),
        .xenemy(xenemy2),
        .yenemy(yenemy2),
        .adr_enemy(adr_enemy2)
    );





    enemy_control #(
        .OUT_WIDTH(OUT_WIDTH),
        .ADDRESSWIDTH(ADDRESSWIDTH),

    //  cosmetics
        .DESTOY_ANIMATION_TIME(5),

    //  enemy range 
        .X_ENEMY_START(X_ENEMY_START),
        .X_ENEMY_END(X_ENEMY_END),

    //  base data
        .X_BASE(X_BASE3),
        .Y_ENEMY_BASE(Y_ENEMY3_BASE3)
    ) u_enemy3_control (
        .clk(clk100MHz),
        .rst(rst),
        
        .spawn_pulse(spawn_pulse3),
        .speed_pulse(speed_pulse3),

        .rockethit(0),
        .adr_enemy_start(ADR_SPYPLANE_START),

        .spawn(spawn_enemy3),
        .xenemy(xenemy3),
        .yenemy(yenemy3),
        .adr_enemy(adr_enemy3)
    );




    base_control #(
        .ADDRESSWIDTH(ADDRESSWIDTH),
        .DESTOY_ANIMATION_TIME(3),
        .OUT_WIDTH(OUT_WIDTH),
        .X_BASE(X_BASE1),
        .Y_ENEMY_BASE(Y_ENEMY1_BASE1)
    ) u_base1_NEWYORK (
        .clk(clk100MHz),
        .rst(rst),
        .base_nuked(base1_nuked),
        .xenemy(xenemy1)
    );

    base_control #(
        .ADDRESSWIDTH(ADDRESSWIDTH),
        .DESTOY_ANIMATION_TIME(3),
        .OUT_WIDTH(OUT_WIDTH),
        .X_BASE(X_BASE2),
        .Y_ENEMY_BASE(Y_ENEMY2_BASE2)
    ) u_base2_NEWYORK (
        .clk(clk100MHz),
        .rst(rst),
        .base_nuked(base2_nuked),
        .xenemy(xenemy2)
    );

    base_control #(
        .ADDRESSWIDTH(ADDRESSWIDTH),
        .DESTOY_ANIMATION_TIME(3),
        .OUT_WIDTH(OUT_WIDTH),
        .X_BASE(X_BASE3),
        .Y_ENEMY_BASE(Y_ENEMY3_BASE3)
    ) u_base3_NEWYORK (
        .clk(clk100MHz),
        .rst(rst),
        .base_nuked(base3_nuked),
        .xenemy(xenemy3)
    );




endmodule