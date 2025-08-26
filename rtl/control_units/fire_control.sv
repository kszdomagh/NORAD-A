//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   fire_control
 Author:        kszdom
 Description:   control module for cursor and rocket fire
 */
//////////////////////////////////////////////////////////////////////////////
module fire_control #(
    parameter int OUT_WIDTH = 8,
    parameter int ADDRESSWIDTH = 0,
    parameter int XY_PRECISION = 5     //"how much cursor has to be off target to hit the target"
    
)(
	input logic clk,
	input logic rst,

	//  cursor x y 
	input logic [OUT_WIDTH-1:0] xcursor,
	input logic [OUT_WIDTH-1:0] ycursor,
    input logic rocketfire,

    // enemy x y 
    input logic [OUT_WIDTH-1:0] xenemy1,
    input logic [OUT_WIDTH-1:0] yenemy1,
    input logic spawn_enemy1,

    input logic [OUT_WIDTH-1:0] xenemy2,
    input logic [OUT_WIDTH-1:0] yenemy2,
    input logic spawn_enemy2,

    input logic [OUT_WIDTH-1:0] xenemy3,
    input logic [OUT_WIDTH-1:0] yenemy3,
    input logic spawn_enemy3,

    output logic [OUT_WIDTH-1:0] killcount,

    //  kill signals
    output logic enemy1_kill,
    output logic enemy2_kill,
    output logic enemy3_kill

);

    import vector_pkg::*;
    import img_pkg::*;


    typedef enum logic [1:0] {
        RESET             = 2'd0,
        IDLE              = 2'd1
    } state_t;

    state_t state, state_nxt;


    logic enemy1_kill_nxt, enemy2_kill_nxt, enemy3_kill_nxt;
    logic [OUT_WIDTH-1:0] killcount_nxt;



    //  func to check the difference
    function automatic [11:0] abs_diff(input [11:0] a, input [11:0] b);
        abs_diff = (a >= b) ? (a - b) : (b - a);
    endfunction


    always_ff@(posedge clk) begin
        if(rst) begin
            state <= RESET;

        end else begin
            state <= state_nxt;

            enemy1_kill <= enemy1_kill_nxt;
            enemy2_kill <= enemy2_kill_nxt;
            enemy3_kill <= enemy3_kill_nxt;
            killcount <= killcount_nxt;

        end
    end

    // next state always comb
    always_comb begin
        state_nxt = RESET; //default
        case(state)
            RESET: state_nxt = IDLE;

            IDLE: state_nxt = IDLE;

            default: state_nxt = RESET;
        endcase
    end

    // outputs always comb
    always_comb begin

        //  defaults
        enemy1_kill_nxt = 1'b0;
        enemy2_kill_nxt = 1'b0;
        enemy3_kill_nxt = 1'b0;

        killcount_nxt = killcount;

        case(state)

            RESET: begin
                enemy1_kill_nxt = 1'b0;
                enemy2_kill_nxt = 1'b0;
                enemy3_kill_nxt = 1'b0;
                killcount_nxt = '0;
            end

            IDLE: begin //jezeli 
                if ( spawn_enemy1 && rocketfire && (abs_diff(xcursor, xenemy1) <= XY_PRECISION) && (abs_diff(ycursor, yenemy1) <= XY_PRECISION) ) begin
                    enemy1_kill_nxt = 1'b1;
                    killcount_nxt = killcount + 1;
                end
                if ( spawn_enemy2 && rocketfire && (abs_diff(xcursor, xenemy2) <= XY_PRECISION) && (abs_diff(ycursor, yenemy2) <= XY_PRECISION) ) begin
                    enemy2_kill_nxt = 1'b1;
                    killcount_nxt = killcount + 1;
                end
                if ( spawn_enemy3 && rocketfire && (abs_diff(xcursor, xenemy3) <= XY_PRECISION) && (abs_diff(ycursor, yenemy3) <= XY_PRECISION) ) begin
                    enemy3_kill_nxt = 1'b1;
                    killcount_nxt = killcount + 1;
                end
            end

        endcase

    end

endmodule