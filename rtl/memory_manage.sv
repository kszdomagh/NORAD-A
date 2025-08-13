//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   memory_manage
 Author:        kszdom
 Description:  module used for extracting data from memory (acording to specifications) and
               converting it into format used by line-drawing "bresenham" module
 */
//////////////////////////////////////////////////////////////////////////////

module memory_manage #(
    parameter int OUT_WIDTH = 8,
    parameter int FRAME_MIN = 0,
    parameter int FRAME_MAX = 255,
    parameter int ADR_WIDTH = 16,
    parameter int DATAWIDTH = 18
    )(

    // control signals
    input logic clk,
    input logic rst,
    input logic frame_done,
    output logic draw_frame,

    //  ROM signals
    input logic [DATAWIDTH-1:0] dataROM,
    output logic [ADR_WIDTH-1:0] adrROM,

    //  write to RAM signals
    output logic [DATAWIDTH-1:0] dataWRITE,
    output logic [ADR_WIDTH-1:0] adrWRITE,


    //SIGNALS FROM CONTROL UNITS

    //  mouse signals
    input logic [OUT_WIDTH-1:0] x_cursor,
    input logic [OUT_WIDTH-1:0] y_cursor

);

    import vector_pkg::*;
    import ROM_pkg::*;

    // OUTPUT DATA 
    logic [OUT_WIDTH-1:0] xROM;
    logic [OUT_WIDTH-1:0] yROM;
    logic lineROM;
    logic posROM;

    //  NXT SIGNALS
    logic draw_frame_nxt;
    logic [ADR_WIDTH-1:0] adrROM_nxt;
    logic [ADR_WIDTH-1:0] adrWRITE_nxt;
    logic [DATAWIDTH-1:0] dataWRITE_nxt;


    typedef enum logic [4:0] {
        //CONTROL SIGNALS
        DONE            = 5'd0,
        RESET           = 5'd1,
        WAIT_FRAME_DONE = 5'd2,

        //DRAW BACKGROUND
        DRAW_FRAME = 5'd10,
        DRAW_MAP   = 5'd11,

        //DRAW INTERACTABLES
        DRAW_CURSOR = 5'd12
    } state_t;

    state_t state, state_nxt;

    always_ff@(posedge clk) begin
        if(rst) begin
            state <= RESET;

        end else begin
            draw_frame <= draw_frame_nxt;
            adrROM    <= adrROM_nxt;
            adrWRITE  <= adrWRITE_nxt;
            dataWRITE <= dataWRITE_nxt;
        end
    end

    // next state always comb
    always_comb begin
        state_nxt = RESET; //default
        case(state)
            RESET: state_nxt = DRAW_FRAME;
            DRAW_FRAME: state_nxt = (posROM & lineROM) ? DRAW_MAP : DRAW_FRAME;
            DRAW_MAP: state_nxt = (posROM & lineROM) ? DRAW_CURSOR : DRAW_FRAME;
            DRAW_CURSOR: state_nxt = (posROM & lineROM) ? DONE : DRAW_CURSOR;

            DONE: state_nxt = WAIT_FRAME_DONE;
            WAIT_FRAME_DONE: state_nxt = frame_done ? DRAW_FRAME : WAIT_FRAME_DONE;

            default: state_nxt = RESET;
        endcase
    end

    // outputs always comb
    always_comb begin

        xROM = dataROM[9:2];
        yROM = dataROM[17:10];
        lineROM = dataROM[1];
        posROM = dataROM[0];

        // default - outputs stay the same
        adrROM_nxt      = adrROM;
        adrWRITE_nxt    = adrWRITE;
        dataWRITE_nxt   = dataWRITE;
        draw_frame_nxt  = 0;


        case(state)
            RESET: begin
                adrWRITE_nxt = 0;
                dataWRITE_nxt = {FRAME_MIN, FRAME_MIN, 0, 1}; //make a point at bottom left corner
                adrROM_nxt = 0;
            end



            DRAW_FRAME: begin

                if (state != state_nxt) adrROM_nxt = ADR_FRAME_START;

                if(lineROM & posROM) begin
                    // no nothing
                end else begin
                    dataWRITE_nxt = dataROM;
                    adrWRITE_nxt = adrWRITE + 1;
                end

                if(state_nxt == DRAW_FRAME) begin
                    adrROM_nxt = adrROM + 1;
                end

            end

            DRAW_MAP: begin

                if (state != state_nxt) adrROM_nxt = ADR_MAP_START;
                
                if(lineROM & posROM) begin
                    // no nothing
                end else begin
                    dataWRITE_nxt = dataROM;
                    adrWRITE_nxt = adrWRITE + 1;
                end

                if(state_nxt == DRAW_MAP) begin
                    adrROM_nxt = adrROM + 1;
                end

            end

            DRAW_CURSOR: begin

                if (state != state_nxt) adrROM_nxt = ADR_CURSOR_START;
                
                if(lineROM & posROM) begin
                    // no nothing
                end else begin
                    dataWRITE_nxt = dataROM;
                    adrWRITE_nxt = adrWRITE + 1;
                end

                if(state_nxt == DRAW_CURSOR) begin
                    adrROM_nxt = adrROM + 1;
                end

            end

            DONE: begin
                draw_frame_nxt = 1;
            end


            WAIT_FRAME_DONE: begin
                draw_frame_nxt = 1;
            end

        endcase
    end


endmodule

