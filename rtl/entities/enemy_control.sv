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
    //input logic enemy_randomize,     // randomize what enemy

    output logic [OUT_WIDTH-1:0] xenemy,
    output logic [OUT_WIDTH-1:0] yenemy,
    output logic base_hit,
    output logic spawn
);

    import vector_pkg::*;
    import ROM_pkg::*;

    logic [OUT_WIDTH-1:0] yenemy_nxt;
    logic [OUT_WIDTH-1:0] xenemy_nxt;
    logic base_hit_nxt;
    logic spawn_nxt;


    always_comb begin

        base_hit_nxt  = base_hit;
        spawn_nxt     = spawn;
        xenemy_nxt    = xenemy;
        yenemy_nxt    = yenemy;

        // y is constant
        case(TARGET_BASE)
            1: begin
                yenemy_nxt = Y_ENEMY1_BASE1;
                if(xenemy == X_BASE1) base_hit_nxt = 1;
            end
            2: begin
                yenemy_nxt = Y_ENEMY2_BASE2;
                if(xenemy == X_BASE2) base_hit_nxt = 1;
            end
            3: begin
                yenemy_nxt = Y_ENEMY3_BASE3;
                if(xenemy == X_BASE3) base_hit_nxt = 1;
            end
        endcase



        if(rst) begin
            xenemy_nxt      = '0;
            base_hit_nxt    = 1'b0;
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
        base_hit    <= base_hit_nxt;
        spawn       <= spawn_nxt;
    end

endmodule