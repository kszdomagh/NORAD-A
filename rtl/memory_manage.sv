//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   memory_manage
 Author:        kszdom
 Description:  module used for extracting data from memory (acording to specifications) and
               converting it into format used by line-drawing "bresenham" module


this is the heart of the whole program - please be gentle and think twice before you change something here
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
    input logic halt,
    output logic go,
    output logic [4:0] state_debug,

    //  ROM signals
    input logic [DATAWIDTH-1:0] dataROM,
    output logic [ADR_WIDTH-1:0] adrROM,

    //  write to RAM signals
    output logic [DATAWIDTH-1:0] dataWRITE,
    output logic [ADR_WIDTH-1:0] adrWRITE,


    //SIGNALS FROM CONTROL UNITS

    //  mouse signals
    input logic [OUT_WIDTH-1:0] xcursor,
    input logic [OUT_WIDTH-1:0] ycursor,

    // enemy signals
    input logic [OUT_WIDTH-1:0] xenemy1,
    input logic [OUT_WIDTH-1:0] yenemy1,
    input logic spawn_enemy1,
    input logic [ADR_WIDTH-1:0] adr_enemy1,

    input logic [OUT_WIDTH-1:0] xenemy2,
    input logic [OUT_WIDTH-1:0] yenemy2,
    input logic spawn_enemy2,
    input logic [ADR_WIDTH-1:0] adr_enemy2,

    input logic [OUT_WIDTH-1:0] xenemy3,
    input logic [OUT_WIDTH-1:0] yenemy3,
    input logic spawn_enemy3,
    input logic [ADR_WIDTH-1:0] adr_enemy3
);

    import vector_pkg::*;
    import img_pkg::*;
    

    // OUTPUT DATA 
    logic [OUT_WIDTH-1:0] xROM;
    logic [OUT_WIDTH-1:0] yROM;
    logic lineROM;
    logic posROM;

    //  NXT SIGNALS
    logic go_nxt;
    logic [ADR_WIDTH-1:0] adrROM_nxt;
    logic [ADR_WIDTH-1:0] adrWRITE_nxt;
    logic [DATAWIDTH-1:0] dataWRITE_nxt;


    typedef enum logic [4:0] { //5 bit state so 65 states possible
        //CONTROL SIGNALS
        DONE            = 5'd0,
        RESET           = 5'd1,
        WAIT_FRAME_DONE = 5'd2,
        DRAW_RESET      = 5'd3,

        //DRAW BACKGROUND
        DRAW_FRAME = 5'd10,
        DRAW_MAP   = 5'd11,

        //DRAW ENEMIES
        DRAW_ENEMY1 = 5'd13,
        DRAW_ENEMY2 = 5'd14,
        DRAW_ENEMY3 = 5'd15,

        //DRAW INTERACTABLES
        DRAW_CURSOR = 5'd12
    } state_t;

    state_t state, state_nxt;

    always_ff@(posedge clk) begin
        state_debug <= state_nxt;

        if(rst) begin
            state <= RESET;

        end else begin
            state <= state_nxt;

            go <= go_nxt;
            adrROM    <= adrROM_nxt;
            adrWRITE  <= adrWRITE_nxt;
            dataWRITE <= dataWRITE_nxt;
        end
    end

    // next state always comb
    always_comb begin
        case(state)
            RESET: state_nxt = DRAW_FRAME;

            //CUR_STATE: state_nxt = (posROM & lineROM) ? NEXT_STATE : CUR_STATE;
            DRAW_FRAME: state_nxt = (posROM & lineROM) ? DRAW_MAP : DRAW_FRAME;
            DRAW_MAP: state_nxt = (posROM & lineROM) ? DRAW_CURSOR : DRAW_MAP;
            DRAW_CURSOR: state_nxt = (posROM & lineROM) ? DRAW_ENEMY1 : DRAW_CURSOR;

            DRAW_ENEMY1:state_nxt = ((posROM & lineROM) || !spawn_enemy1) ? DRAW_ENEMY2 : DRAW_ENEMY1;
            DRAW_ENEMY2:state_nxt = ((posROM & lineROM) || !spawn_enemy2) ? DRAW_ENEMY3 : DRAW_ENEMY2;
            DRAW_ENEMY3:state_nxt = ((posROM & lineROM) || !spawn_enemy3) ? DRAW_RESET : DRAW_ENEMY3;


            DRAW_RESET: state_nxt = DONE;

            DONE: state_nxt = halt ? DONE : WAIT_FRAME_DONE;
            WAIT_FRAME_DONE: state_nxt = halt ? RESET : WAIT_FRAME_DONE;

            default: state_nxt = RESET;
        endcase
    end

    // outputs always comb
    always_comb begin

        //signals usefull in DRAW_ states
        xROM = dataROM[17:10];
        yROM = dataROM[9:2];
        lineROM = dataROM[1];
        posROM = dataROM[0];

        // default - outputs stay the same
        adrROM_nxt      = adrROM;
        adrWRITE_nxt    = adrWRITE;
        dataWRITE_nxt   = dataWRITE;
        go_nxt  = 0;


        case(state)
/*///////////////////////////////////////////////////////////////////////////////////////////////
            RESET SIGNAL
///////////////////////////////////////////////////////////////////////////////////////////////*/
            RESET: begin
                adrWRITE_nxt = 0;
                dataWRITE_nxt = {8'd0, 8'd0, 1'b0, 1'b1}; //make a point at bottom left corner
                adrROM_nxt = ADR_FRAME_START;
            end




/*///////////////////////////////////////////////////////////////////////////////////////////////
            BELOW YOU ARE NOW DRAWING THE FRAME IMAGE
///////////////////////////////////////////////////////////////////////////////////////////////*/
            DRAW_FRAME: begin

                if (state != state_nxt) adrROM_nxt = ADR_MAP_START; //next state adr start

                if(lineROM & posROM) begin
                    // no nothing
                end else begin
                    dataWRITE_nxt = {xROM, yROM, lineROM, posROM};
                    adrWRITE_nxt = adrWRITE + 1;
                end

                if(state_nxt == DRAW_FRAME) begin
                    adrROM_nxt = adrROM + 1;
                end
            end




/*///////////////////////////////////////////////////////////////////////////////////////////////
            BELOW YOU ARE NOW DRAWING THE BACKGROUND MAP
///////////////////////////////////////////////////////////////////////////////////////////////*/
            DRAW_MAP: begin
                if (state != state_nxt) adrROM_nxt = ADR_CURSOR_START; //next state adr start
                
                if(lineROM & posROM) begin
                    // no nothing
                end else begin
                    dataWRITE_nxt = {xROM, yROM, lineROM, posROM};
                    adrWRITE_nxt = adrWRITE + 1;
                end

                if(state_nxt == DRAW_MAP) begin
                    adrROM_nxt = adrROM + 1;
                end
            end





/*///////////////////////////////////////////////////////////////////////////////////////////////
            BELOW YOU ARE NOW DRAWING THE PLAYER CURSOR
///////////////////////////////////////////////////////////////////////////////////////////////*/
            DRAW_CURSOR: begin
                if (state != state_nxt) adrROM_nxt = adr_enemy1; //next state adr start
                
                if(lineROM & posROM) begin
                    // no nothing
                end else begin
                    dataWRITE_nxt = {xROM -  CURSOR_MID_X + xcursor, yROM - CURSOR_MID_Y + ycursor, lineROM, posROM};
                    adrWRITE_nxt = adrWRITE + 1;
                end

                if(state_nxt == DRAW_CURSOR) begin
                    adrROM_nxt = adrROM + 1;
                end
            end




/*///////////////////////////////////////////////////////////////////////////////////////////////
            BELOW YOU ARE NOW DRAWING THE FIRST ENEMY - please change parameters from uwu memory to the good memory specific
///////////////////////////////////////////////////////////////////////////////////////////////*/
            DRAW_ENEMY1: begin
                if (state != state_nxt) adrROM_nxt = adr_enemy2; //next state adr start
                
                if((posROM & lineROM) || !spawn_enemy1) begin
                    // no nothing
                end else begin
                    dataWRITE_nxt = {xROM - ENEMY_MID_X + xenemy1, yROM - ENEMY_MID_Y + yenemy1, lineROM, posROM};
                    adrWRITE_nxt = adrWRITE + 1;
                end

                if(state_nxt == DRAW_ENEMY1) begin
                    adrROM_nxt = adrROM + 1;
                end
            end





/*///////////////////////////////////////////////////////////////////////////////////////////////
            BELOW YOU ARE NOW DRAWING THE SECOND ENEMY
///////////////////////////////////////////////////////////////////////////////////////////////*/
            DRAW_ENEMY2: begin
                if (state != state_nxt) adrROM_nxt = adr_enemy3; //next state adr start
                
                if((posROM & lineROM) || !spawn_enemy2) begin
                    // no nothing
                end else begin
                    dataWRITE_nxt = {xROM - ENEMY_MID_X + xenemy2, yROM - ENEMY_MID_Y + yenemy2, lineROM, posROM};
                    adrWRITE_nxt = adrWRITE + 1;
                end

                if(state_nxt == DRAW_ENEMY2) begin
                    adrROM_nxt = adrROM + 1;
                end
            end


/*///////////////////////////////////////////////////////////////////////////////////////////////
            BELOW YOU ARE NOW DRAWING THE THIRD AND LAST ENEMY
///////////////////////////////////////////////////////////////////////////////////////////////*/
            DRAW_ENEMY3: begin
                if (state != state_nxt) adrROM_nxt = 0; //next state adr start
                
                if((posROM & lineROM) || !spawn_enemy3) begin
                    // no nothing
                end else begin
                    dataWRITE_nxt = {xROM - ENEMY_MID_X + xenemy3, yROM - ENEMY_MID_Y + yenemy3, lineROM, posROM};
                    adrWRITE_nxt = adrWRITE + 1;
                end

                if(state_nxt == DRAW_ENEMY3) begin
                    adrROM_nxt = adrROM + 1;
                end
            end





/*///////////////////////////////////////////////////////////////////////////////////////////////
            BELOW YOU ARE NOW DRAWING THE RESET SIGNAL FOR THE WHOLE MEMORY MODULE
///////////////////////////////////////////////////////////////////////////////////////////////*/
            DRAW_RESET: begin
                    dataWRITE_nxt = {8'd0, 8'd0, 1'b1, 1'b1}; //make a point at bottom left corner
                    adrWRITE_nxt = adrWRITE + 1;
            end





/*///////////////////////////////////////////////////////////////////////////////////////////////
            BELOW YOU ARE NOW WAITING FOR THE FRAME TO BE DISPLAYED
///////////////////////////////////////////////////////////////////////////////////////////////*/
            DONE: begin
                go_nxt = 1;
            end

            WAIT_FRAME_DONE: begin
                go_nxt = 1;
                adrROM_nxt = 0; //reset next so zero the ROM read adr
            end

        endcase
    end

endmodule

