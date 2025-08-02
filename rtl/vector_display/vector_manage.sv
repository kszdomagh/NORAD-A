module vector_manage #(
    parameter int OUT_WIDTH = 8,
    parameter int FRAME_MIN = 0,
    parameter int FRAME_MAX = 255,
    parameter int ADR_WIDTH = 8
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
    input logic busy,

    //  outputs
    output logic go,
    output logic [OUT_WIDTH-1:0] stax,
    output logic [OUT_WIDTH-1:0] endx,
    output logic [OUT_WIDTH-1:0] stay,
    output logic [OUT_WIDTH-1:0] endy,

    output logic [ADR_WIDTH-1:0] adr,
    output logic vector_reset

);

    //nxt logics
    logic go_nxt;
    logic [OUT_WIDTH-1:0] stax_nxt;
    logic [OUT_WIDTH-1:0] endx_nxt;
    logic [OUT_WIDTH-1:0] stay_nxt;
    logic [OUT_WIDTH-1:0] endy_nxt;
    logic [ADR_WIDTH-1:0] adr_nxt;

    logic [OUT_WIDTH-1:0] x_prev;
    logic [OUT_WIDTH-1:0] y_prev;
    logic [OUT_WIDTH-1:0] x_prev_nxt;
    logic [OUT_WIDTH-1:0] y_prev_nxt;


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
            WAITBUSY: state_nxt = busy ? WAITBUSY : ADR;
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
                    stax_nxt = x;
                    endx_nxt = x;

                    stay_nxt = y;
                    endy_nxt = y;

                    x_prev_nxt = x;
                    y_prev_nxt = y; // x was here before and it took me 2 days to notice it - now fixed
                end else if(line) begin
                    stax_nxt = x_prev;
                    endx_nxt = x;

                    stay_nxt = y_prev;
                    endy_nxt = y;

                    x_prev_nxt = x;
                    y_prev_nxt = y; //same thing as before
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

