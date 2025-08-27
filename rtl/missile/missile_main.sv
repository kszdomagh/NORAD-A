//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   missile_main
 Author:        kszdom
 Description:  module used for controlling a missile
 */
//////////////////////////////////////////////////////////////////////////////

module missile_main #(
    parameter int OUT_WIDTH = 8,
    parameter int FRAME_MIN = 0,
    parameter int FRAME_MAX = 255,
    parameter    XY_PRECISION = 12
    )(

    // control signals
    input logic clk,
    input logic rst,


    //SIGNALS FROM CONTROL UNITS

    input logic fired,
    input logic valid_drawing,
    input logic bren_done,

    //  mouse signals
    input logic [OUT_WIDTH-1:0] xcursor,
    input logic [OUT_WIDTH-1:0] ycursor,

    input logic [OUT_WIDTH-1:0] xflying,
    input logic [OUT_WIDTH-1:0] yflying,

    // enemy signals
    input logic [OUT_WIDTH-1:0] xenemy1,
    input logic [OUT_WIDTH-1:0] yenemy1,
    input logic spawn_enemy1,

    input logic [OUT_WIDTH-1:0] xenemy2,
    input logic [OUT_WIDTH-1:0] yenemy2,
    input logic spawn_enemy2,

    input logic [OUT_WIDTH-1:0] xenemy3,
    input logic [OUT_WIDTH-1:0] yenemy3,
    input logic spawn_enemy3,

    output logic hit1,
    output logic hit2,
    output logic hit3,

    output logic bren_go,
    output logic [OUT_WIDTH-1:0] xflying_end,
    output logic [OUT_WIDTH-1:0] yflying_end
);

    import vector_pkg::*;
    import img_pkg::*;


    logic bren_go_nxt;
    logic [OUT_WIDTH-1:0] xflying_end_nxt;
    logic [OUT_WIDTH-1:0] yflying_end_nxt;

    logic hit1_nxt, hit2_nxt, hit3_nxt;

    //  func to check the difference
    function automatic [11:0] abs_diff(input [11:0] a, input [11:0] b);
        abs_diff = (a >= b) ? (a - b) : (b - a);
    endfunction


    typedef enum logic [4:0] { //5 bit state so 65 states possible
        //CONTROL SIGNALS
        RESET   = 5'd0,
        IDLE    = 5'd1,
        SHOOT   = 5'd2,
        FLYING  = 5'd3,
        GONE    = 5'd4,
        HIT1     = 5'd5,
        HIT2     = 5'd6,
        HIT3     = 5'd7
    } state_t;

    state_t state, state_nxt;

    always_ff@(posedge clk) begin
        //state_debug <= state_nxt;

        if(rst) begin
            state <= RESET;

            xflying_end <= '0;
            yflying_end <= '0;
            bren_go <= '0;
            hit1 <= '0;
            hit2 <= '0;
            hit3 <= '0;

        end else begin
            state <= state_nxt;

            xflying_end <= xflying_end_nxt;
            yflying_end <= yflying_end_nxt;
            bren_go <= bren_go_nxt;
            hit1 <= hit1_nxt;
            hit2 <= hit2_nxt;
            hit3 <= hit3_nxt;

        end
    end

    // next state always comb
    always_comb begin
        case(state)
            RESET: state_nxt = IDLE;

            IDLE: state_nxt = fired ? SHOOT : IDLE;

            SHOOT: state_nxt = valid_drawing ? FLYING : SHOOT;

            FLYING: begin       // wtf is this condition
                if( spawn_enemy1 && (abs_diff(xflying, xenemy1) <= XY_PRECISION) && (abs_diff(yflying, yenemy1) <= XY_PRECISION) ) state_nxt = HIT1;

                else if( spawn_enemy2 && (abs_diff(xflying, xenemy2) <= XY_PRECISION) && (abs_diff(yflying, yenemy2) <= XY_PRECISION)) state_nxt = HIT2;

                else if( spawn_enemy3 && (abs_diff(xflying, xenemy3) <= XY_PRECISION) && (abs_diff(yflying, yenemy3) <= XY_PRECISION)) state_nxt = HIT3;

                else if( (xflying < FRAME_MIN+2) || (xflying > FRAME_MAX-2) || (yflying < FRAME_MIN+2) || (yflying > FRAME_MAX-2) || bren_done) begin
                    state_nxt = GONE;
                end else begin
                    state_nxt = FLYING;
                end
            end

            GONE: state_nxt = IDLE;

            HIT1: state_nxt = IDLE;
            HIT2: state_nxt = IDLE;
            HIT3: state_nxt = IDLE;

            default: state_nxt = RESET;
        endcase
    end

    // outputs always comb
    always_comb begin

        //  defaults

        xflying_end_nxt = xflying_end;
        yflying_end_nxt = yflying_end;
        bren_go_nxt = 1'b0;
        hit1_nxt = 1'b0;
        hit2_nxt = 1'b0;
        hit3_nxt = 1'b0;



        case(state)

            RESET: begin

                bren_go_nxt = 1'b0;
                xflying_end_nxt = '0;
                yflying_end_nxt = '0;

            end

            IDLE: begin
                bren_go_nxt = 1'b0;
                xflying_end_nxt = xcursor;
                yflying_end_nxt = ycursor;
            end

            SHOOT: begin
                bren_go_nxt = 1'b1;
                xflying_end_nxt = xcursor;
                yflying_end_nxt = ycursor;
            end

            FLYING: begin
                bren_go_nxt = 1'b1;
                xflying_end_nxt = xflying_end;
                yflying_end_nxt = yflying_end;
            end

            HIT1: hit1_nxt = 1'b1;

            HIT2: hit2_nxt = 1'b1;

            HIT3: hit3_nxt = 1'b1;

            GONE: begin
                bren_go_nxt = 1'b0;
            end



        endcase
    end

endmodule

