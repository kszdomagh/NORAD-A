//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   enemy_control
 Author:        kszdom
 Description:  control module for enemy
 */
//////////////////////////////////////////////////////////////////////////////
module enemy_control #(
    parameter int OUT_WIDTH = 8,
    parameter int TARGET_BASE = 1 //either 1 or 2 or 3
	)(
	input logic clk,
	input logic rst,

    input logic speed_pulse,
    input logic spawn_pulse,
    input logic en,
    //input logic enemy_randomize,     // randomize what enemy

    output logic [OUT_WIDTH-1:0] xenemy,
    output logic [OUT_WIDTH-1:0] yenemy,
    output logic spawn
);

    import vector_pkg::*;
    import ROM_pkg::*;

    logic [OUT_WIDTH-1:0] yenemy_nxt;
    logic [OUT_WIDTH-1:0] xenemy_nxt;
    logic spawn_nxt;


    always_comb begin

        spawn_nxt     = spawn;
        xenemy_nxt    = xenemy;
        yenemy_nxt    = yenemy;

        // y is constant
        if(TARGET_BASE == 1) begin
            yenemy_nxt = Y_ENEMY1_BASE1;
        end else if(TARGET_BASE == 2) begin

            yenemy_nxt = Y_ENEMY2_BASE2;
        end else if(TARGET_BASE == 3) begin
            yenemy_nxt = Y_ENEMY3_BASE3;
        end


        if(rst | !en) begin
            xenemy_nxt      = '0;
            spawn_nxt       = 1'b0;
        end else begin

            // spawning enemy
            if(spawn_pulse & !spawn) begin
                spawn_nxt = 1'b1;
                xenemy_nxt = X_ENEMY1_START;
            end

            if(speed_pulse & spawn) xenemy_nxt = xenemy - 1;

        end
    end

    always_ff@(posedge clk) begin
        xenemy      <= xenemy_nxt;
        yenemy      <= yenemy_nxt;
        spawn       <= spawn_nxt;
    end

endmodule