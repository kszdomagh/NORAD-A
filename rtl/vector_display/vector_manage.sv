//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   vector_manage
 Author:        kszdom
 Description:  module used for extracting data from memory (acording to specifications) and
               converting it into format used by line-drawing "bresenham" module

  Change log: 
    05.08.2025 - kszdom - changed unsigned output values to signed values in 
                          order to fix bresenham module overflow issue
 */
//////////////////////////////////////////////////////////////////////////////

module vector_manage #(
    parameter int OUT_WIDTH = 8,
    parameter int FRAME_MIN = 0,
    parameter int FRAME_MAX = 255,
    parameter int ADR_WIDTH = 8,
    parameter int BRES_WIDTH = OUT_WIDTH+1 // 8+1 unsigned to signed conversion
    )(

    // control signals
    input logic clk,
    input logic rst,
    output logic [5:0] state_debug,

    // data inputs
    input logic [OUT_WIDTH-1:0] x,
    input logic [OUT_WIDTH-1:0] y,
    input logic line,
    input logic pos,

    // line inputs
    input logic busy,   //replaced by done
    input logic done,

    //  outputs
    output logic go,
    output logic signed [BRES_WIDTH-1:0] stax,
    output logic signed [BRES_WIDTH-1:0] endx,
    output logic signed [BRES_WIDTH-1:0] stay,
    output logic signed [BRES_WIDTH-1:0] endy,

    output logic [ADR_WIDTH-1:0] adr,
    output logic vector_reset

);

    //nxt logics
    logic go_nxt;
    logic signed [BRES_WIDTH-1:0] stax_nxt;
    logic signed [BRES_WIDTH-1:0] endx_nxt;
    logic signed [BRES_WIDTH-1:0] stay_nxt;
    logic signed [BRES_WIDTH-1:0] endy_nxt;

    logic [ADR_WIDTH-1:0] adr_nxt;

    logic signed [BRES_WIDTH-1:0] x_prev;
    logic signed [BRES_WIDTH-1:0] y_prev;
    logic signed [BRES_WIDTH-1:0] x_prev_nxt;
    logic signed [BRES_WIDTH-1:0] y_prev_nxt;


    typedef enum logic [5:0] {
        RESET      = 6'b000001,
        GETDATA    = 6'b000010,
        CHECKDATA  = 6'b000011,     //fix this later
        SENDDATA   = 6'b000100,
        GODOWN     = 6'b001000,
        WAITBUSY   = 6'b010000,
        ADR        = 6'b100000
    } state_t;

    state_t state, state_nxt;

    always_ff@(posedge clk) begin
        if(rst) begin
            state <= RESET;
            go <= 1'b0;
            adr <= '0;

        end else begin
            state <= state_nxt;
            state_debug <= state_nxt;
            
            go <= go_nxt;
            adr <= adr_nxt;

            stax <= stax_nxt;
            endx <= endx_nxt;
            
            stay <= stay_nxt;
            endy <= endy_nxt;
            
            x_prev <= x_prev_nxt;
            y_prev <= y_prev_nxt;
        end
    end

    // next state always comb
    always_comb begin
        case(state)
            RESET: state_nxt = GETDATA;
            GETDATA: state_nxt = busy ? GETDATA : CHECKDATA;
            CHECKDATA: state_nxt = (pos && line) ? RESET : SENDDATA;
            SENDDATA: state_nxt = GODOWN;
            GODOWN: state_nxt = WAITBUSY;
            WAITBUSY: state_nxt = done ? ADR : WAITBUSY;
            ADR: state_nxt = GETDATA;
        endcase
    end

    // outputs always comb
    always_comb begin

        case(state)
            RESET: begin
                go_nxt = 0;
                adr_nxt = 0;

                stax_nxt = 0;
                endx_nxt = 0;
                stay_nxt = 0;
                endy_nxt = 0;

                x_prev_nxt = 0;
                y_prev_nxt = 0;
                vector_reset = 1'b1;

            end

            GETDATA: begin
                vector_reset = 1'b0;
                if(pos) begin
                    stax_nxt = {1'b0, x};
                    endx_nxt = {1'b0, x};

                    stay_nxt = {1'b0, y};
                    endy_nxt = {1'b0, y};

                    x_prev_nxt = {1'b0, y};
                    y_prev_nxt = {1'b0, y}; // x was here before and it took me 2 days to notice it - now fixed
                end else if(line) begin
                    stax_nxt = x_prev;
                    endx_nxt = {1'b0, x};

                    stay_nxt = y_prev;
                    endy_nxt = {1'b0, y};

                    x_prev_nxt = {1'b0, x};
                    y_prev_nxt = {1'b0, y}; //same thing as before
                end
            end
            
            CHECKDATA: begin

            end

            SENDDATA: begin
                go_nxt = 1'b1;
            end

            GODOWN: begin
                go_nxt = 1'b0;
            end

            WAITBUSY: begin
                go_nxt = 1'b0;
            end

            ADR: begin
                adr_nxt = adr + 1;
            end

        endcase
    end


endmodule

