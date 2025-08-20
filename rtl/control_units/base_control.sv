//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   base_control
 Author:        kszdom
 Description:  control module for enemy
 */
//////////////////////////////////////////////////////////////////////////////
module base_control #(
    parameter int OUT_WIDTH = 8,
    parameter int ADDRESSWIDTH = 0,
    
    //  BASE XY 
    parameter int X_BASE = 0,
    parameter int Y_ENEMY_BASE = 0,

    // COSMETICS
    parameter int DESTOY_ANIMATION_TIME = 3
)(
	input logic clk,
	input logic rst,

    input logic [OUT_WIDTH-1:0] xenemy,
    output logic base_nuked
);

    import vector_pkg::*;
    import img_pkg::*;

    logic base_nuked_nxt;

    logic [3:0] destroyed_counter;


    typedef enum logic [4:0] {
        RESET             = 5'd0,
        IDLE              = 5'd1,
        NUKED               = 5'd2,
        GONE              = 5'd4        //maybe not use it bcuz nuclear explosion effect wound look cooler on the usa map
    } state_t;

    state_t state, state_nxt;

    always_ff@(posedge clk) begin
        if(rst) begin
            state <= RESET;

        end else begin
            state <= state_nxt;

            base_nuked <=   base_nuked_nxt;
            
        end
    end

    // next state always comb
    always_comb begin
        state_nxt = RESET; //default
        case(state)
            RESET: state_nxt = IDLE;

            IDLE: state_nxt = ( xenemy == X_BASE ) ? NUKED : IDLE;

            NUKED: state_nxt = NUKED;

            GONE: state_nxt = GONE; // not needed

            default: state_nxt = RESET;
        endcase
    end

    // outputs always comb
    always_comb begin

        base_nuked_nxt = base_nuked;


        case(state)

            RESET: base_nuked_nxt = 0;

            IDLE: base_nuked_nxt = 0;

            NUKED: base_nuked_nxt = 1;

            GONE: base_nuked_nxt = 1;   // not needed


        endcase

    end



endmodule