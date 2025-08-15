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
    parameter int DATAWIDTH = 18,
    parameter int BRES_WIDTH = OUT_WIDTH+1 // 8+1 unsigned to signed conversion
    )(

    // control signals
    input logic clk,
    input logic rst,
    input logic enable,

    // data inputs
    input logic [DATAWIDTH-1:0] data_in,

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

    wire [OUT_WIDTH-1:0] x;
    wire [OUT_WIDTH-1:0] y;
    wire line, pos;

    assign x = data_in [17:10]; //fix
    assign y = data_in [9:2];
    assign line = data_in [1];
    assign pos = data_in [0];

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
        RESET        = 6'd0,
        GETDATA      = 6'd1,
        CHECKDATA    = 6'd2,
        SENDDATA     = 6'd3,
        GODOWN       = 6'd4,
        WAITBUSY     = 6'd5,
        ADR          = 6'd6,
        VECTOR_RESET1 = 6'd7,
        VECTOR_RESET2 = 6'd8
    } state_t;

    state_t state, state_nxt;

    always_ff@(posedge clk) begin
        if(rst) begin
            state <= RESET;
            adr = 0;

        end else begin
            state <= state_nxt;
            
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
        state_nxt = RESET; //default
        case(state)
            RESET: state_nxt = enable ? GETDATA : RESET;
            GETDATA: state_nxt = busy ? GETDATA : CHECKDATA;
            CHECKDATA: state_nxt = (pos && line) ? VECTOR_RESET1 : SENDDATA;
            SENDDATA: state_nxt = GODOWN;
            GODOWN: state_nxt = WAITBUSY;
            WAITBUSY: state_nxt = done ? ADR : WAITBUSY;
            ADR: state_nxt = GETDATA;

            VECTOR_RESET1: state_nxt = RESET;

            default: state_nxt = RESET;
        endcase
    end

    // outputs always comb
    always_comb begin

        // default
        go_nxt = go;
        adr_nxt = adr;

        stax_nxt = stax;
        endx_nxt = endx;
        stay_nxt = stay;
        endy_nxt = endy;

        x_prev_nxt = x_prev;
        y_prev_nxt = y_prev;

        vector_reset = 1'b0;

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
                go_nxt = 0;
                adr_nxt = adr;
                if(pos) begin
                    stax_nxt = {1'b0, x};
                    endx_nxt = {1'b0, x};

                    stay_nxt = {1'b0, y};
                    endy_nxt = {1'b0, y};

                    x_prev_nxt = {1'b0, x};
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
                go_nxt = 0;
                adr_nxt = adr;

                stax_nxt = stax;
                endx_nxt = endx;
                stay_nxt = stay;
                endy_nxt = endy;

                x_prev_nxt = x_prev;
                y_prev_nxt = y_prev;

                vector_reset = 1'b0;
            end

            SENDDATA: begin
                go_nxt = 1'b1;
                adr_nxt = adr;

                stax_nxt = stax;
                endx_nxt = endx;
                stay_nxt = stay;
                endy_nxt = endy;

                x_prev_nxt = x_prev;
                y_prev_nxt = y_prev;

                vector_reset = 1'b0;
            end

            GODOWN: begin
                go_nxt = 1'b0;
                adr_nxt = adr;

                stax_nxt = stax;
                endx_nxt = endx;
                stay_nxt = stay;
                endy_nxt = endy;

                x_prev_nxt = x_prev;
                y_prev_nxt = y_prev;

                vector_reset = 1'b0;
            end

            WAITBUSY: begin
                go_nxt = 1'b0;
                adr_nxt = adr;

                stax_nxt = stax;
                endx_nxt = endx;
                stay_nxt = stay;
                endy_nxt = endy;

                x_prev_nxt = x_prev;
                y_prev_nxt = y_prev;

                vector_reset = 1'b0;
            end

            ADR: begin
                go_nxt = 1'b0;
                adr_nxt = adr + 1;

                stax_nxt = stax;
                endx_nxt = endx;
                stay_nxt = stay;
                endy_nxt = endy;

                x_prev_nxt = x_prev;
                y_prev_nxt = y_prev;

                vector_reset = 1'b0;
            end
            
            VECTOR_RESET1: begin
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

        endcase
    end


endmodule

