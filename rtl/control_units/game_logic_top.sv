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

    parameter int DESTOY_ANIMATION_TIME = 100_000_000,


    parameter int TIME_SPEED_ENEMY1 = 30_000_000,
    parameter int TIME_SPEED_ENEMY2 = 80_000_000,
    parameter int TIME_SPEED_ENEMY3 = 40_000_000,

    parameter int TIME_SPAWN_ENEMY1 = 10_000_000,
    parameter int TIME_SPAWN_ENEMY2 = 12_000_000,
    parameter int TIME_SPAWN_ENEMY3 = 22_000_000
    )(

        input logic clk_fast,
        input logic clk_slow,
        input logic rst,

        input wire [OUT_WIDTH-1:0] ycursor,
        input wire [OUT_WIDTH-1:0] xcursor,
        input wire click,


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
        output wire base3_nuked,
        
        output wire [OUT_WIDTH-1:0] killcount
    );
    timeunit 1ns;
    timeprecision 1ps;

    import vector_pkg::*;
    import img_pkg::*;
    //import uwu_pkg::*;


    // INTERNAL WIRES
    wire spawn_pulse1, spawn_pulse2, spawn_pulse3;
    wire speed_pulse1, speed_pulse2, speed_pulse3;

    wire enemy1_kill, enemy2_kill, enemy3_kill;

    //MODULE DECLARATIONS

    timer_cluster #(
        .TIME1(TIME_SPEED_ENEMY1),
        .TIME2(TIME_SPEED_ENEMY2),
        .TIME3(TIME_SPEED_ENEMY3),

        .TIME_SLOW1(TIME_SPAWN_ENEMY1),
        .TIME_SLOW2(TIME_SPAWN_ENEMY2),
        .TIME_SLOW3(TIME_SPAWN_ENEMY3)
    ) u_timer_cluster (
        .clk_fast(clk_fast),
        .clk_slow(clk_slow),
        .rst(rst),
        .dec( { 23'd0, killcount} ),        //make it harder

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
        .DESTOY_ANIMATION_TIME(DESTOY_ANIMATION_TIME),

    //  enemy range 
        .X_ENEMY_START(X_ENEMY_START),
        .X_ENEMY_END(X_ENEMY_END),

    //  base data
        .X_BASE(X_BASE1),
        .Y_ENEMY_BASE(Y_ENEMY1_BASE1)
    ) u_enemy1_control (
        .clk(clk_fast),
        .rst(rst),
        
        .spawn_pulse(spawn_pulse1),
        .speed_pulse(speed_pulse1),

        .rockethit(enemy1_kill),
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
        .DESTOY_ANIMATION_TIME(DESTOY_ANIMATION_TIME),

    //  enemy range 
        .X_ENEMY_START(X_ENEMY_START),
        .X_ENEMY_END(X_ENEMY_END),

    //  base data
        .X_BASE(X_BASE2),
        .Y_ENEMY_BASE(Y_ENEMY2_BASE2)
    ) u_enemy2_control (
        .clk(clk_fast),
        .rst(rst),
        
        .spawn_pulse(spawn_pulse2),
        .speed_pulse(speed_pulse2),

        .rockethit(enemy2_kill),
        .adr_enemy_start(ADR_BOMBER_START),

        .spawn(spawn_enemy2),
        .xenemy(xenemy2),
        .yenemy(yenemy2),
        .adr_enemy(adr_enemy2)
    );





    enemy_control #(
        .OUT_WIDTH(OUT_WIDTH),
        .ADDRESSWIDTH(ADDRESSWIDTH),

    //  cosmetics
        .DESTOY_ANIMATION_TIME(DESTOY_ANIMATION_TIME),

    //  enemy range 
        .X_ENEMY_START(X_ENEMY_START),
        .X_ENEMY_END(X_ENEMY_END),

    //  base data
        .X_BASE(X_BASE3),
        .Y_ENEMY_BASE(Y_ENEMY3_BASE3)
    ) u_enemy3_control (
        .clk(clk_fast),
        .rst(rst),
        
        .spawn_pulse(spawn_pulse3),
        .speed_pulse(speed_pulse3),

        .rockethit(enemy3_kill),
        .adr_enemy_start(ADR_BOMBER_START),

        .spawn(spawn_enemy3),
        .xenemy(xenemy3),
        .yenemy(yenemy3),
        .adr_enemy(adr_enemy3)
    );




    base_control #(
        .DESTOY_ANIMATION_TIME(3),
        .OUT_WIDTH(OUT_WIDTH),
        .X_BASE(X_BASE1),
        .Y_ENEMY_BASE(Y_ENEMY1_BASE1)
    ) u_base1_NEWYORK (
        .clk(clk_fast),
        .rst(rst),
        .base_nuked(base1_nuked),
        .xenemy(xenemy1)
    );

    base_control #(
        .DESTOY_ANIMATION_TIME(3),
        .OUT_WIDTH(OUT_WIDTH),
        .X_BASE(X_BASE2),
        .Y_ENEMY_BASE(Y_ENEMY2_BASE2)
    ) u_base2_NEWYORK (
        .clk(clk_fast),
        .rst(rst),
        .base_nuked(base2_nuked),
        .xenemy(xenemy2)
    );

    base_control #(
        .DESTOY_ANIMATION_TIME(3),
        .OUT_WIDTH(OUT_WIDTH),
        .X_BASE(X_BASE3),
        .Y_ENEMY_BASE(Y_ENEMY3_BASE3)
    ) u_base3_NEWYORK (
        .clk(clk_fast),
        .rst(rst),
        .base_nuked(base3_nuked),
        .xenemy(xenemy3)
    );




    fire_control #(
        .ADDRESSWIDTH(ADDRESSWIDTH),
        .OUT_WIDTH(OUT_WIDTH),
        .XY_PRECISION(10)
    ) u_fire_control_unit (
        .clk(clk_fast),
        .rst(rst),

        .xenemy1(xenemy1),
        .yenemy1(yenemy1),
        .spawn_enemy1(spawn_enemy1),

        .xenemy2(xenemy2),
        .yenemy2(yenemy2),
        .spawn_enemy2(spawn_enemy2),

        .xenemy3(xenemy3),
        .yenemy3(yenemy3),
        .spawn_enemy3(spawn_enemy3),

        .xcursor(xcursor),
        .ycursor(ycursor),
        .rocketfire(click),
        .killcount(killcount),

        .enemy1_kill(enemy1_kill),
        .enemy2_kill(enemy2_kill),
        .enemy3_kill(enemy3_kill)
    );




endmodule