//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   fire_control
 Author:        kszdom
 Description:   control module for counting kills
 */
//////////////////////////////////////////////////////////////////////////////
module fire_control #(
    parameter int OUT_WIDTH = 8
    
)(
	input logic clk,
	input logic rst,

    output logic [OUT_WIDTH-1:0] killcount,

    //  kill signals
    input logic hit1,
    input logic hit2,
    input logic hit3

);

    import vector_pkg::*;
    import img_pkg::*;


    typedef enum logic [1:0] {
        RESET             = 2'd0,
        IDLE              = 2'd1
    } state_t;

    state_t state, state_nxt;


    logic [OUT_WIDTH-1:0] killcount_nxt;



    always_ff@(posedge clk) begin
        if(rst) begin
            state <= RESET;

        end else begin
            state <= state_nxt;

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
        killcount_nxt = killcount;

        case(state)

            RESET: begin

                killcount_nxt = '0;
            end

            IDLE: begin 
                if ( hit1 == 1 ) begin
                    killcount_nxt = killcount + 1;
                end
                if ( hit2 == 1 ) begin
                    killcount_nxt = killcount + 1;
                end
                if ( hit3 == 1 ) begin
                    killcount_nxt = killcount + 1;
                end
            end

        endcase

    end

endmodule