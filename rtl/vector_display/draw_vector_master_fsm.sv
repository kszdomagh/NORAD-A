//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   template_fsm
 Author:        Robert Szczygiel
 Version:       1.0
 Last modified: 2023-05-18
 Coding style: safe with FPGA sync reset
 Description:  Template for modified Moore FSM for UEC2 project
 */
//////////////////////////////////////////////////////////////////////////////
module draw_vector_master_fsm #(
    parameter int OUT_WIDTH = 8,
    parameter int FRAME_MIN = 0,
    parameter int FRAME_MAX = 255
)
(
    //  CONTROL SIGNALS
    input  wire  clk,  // posedge active clock
    input  wire  rst,  // high-level active synchronous reset
    input  logic  busy

    // MEMORY CONTROL
    output  logic  inc, 
    output  logic  zero,

    //  VECTOR INPUTS
    input logic pos,
    input logic draw,
    input logic [OUT_WIDTH-1:0] i_x,
    input logic [OUT_WIDTH-1:0] i_y,

    //  outputs
    output logic go,
    output logic [OUT_WIDTH-1:0] o_start_x,
    output logic [OUT_WIDTH-1:0] o_start_y,
    output logic [OUT_WIDTH-1:0] o_end_x,
    output logic [OUT_WIDTH-1:0] o_end_y
);

//------------------------------------------------------------------------------
// local parameters
//------------------------------------------------------------------------------
localparam STATE_BITS = 3; // number of bits used for state register

//------------------------------------------------------------------------------
// local variables
//------------------------------------------------------------------------------
logic      myout_nxt;

enum logic [STATE_BITS-1 :0] {
    IDLE = 2'b00, // idle state
    MEM = 2'b01,
    NEWDATA = 2'b11,
} state, state_nxt;

//------------------------------------------------------------------------------
// state sequential with synchronous reset
//------------------------------------------------------------------------------
always_ff @(posedge clk) begin : state_seq_blk
    if(rst)begin : state_seq_rst_blk
        state <= IDLE;
    end
    else begin : state_seq_run_blk
        state <= state_nxt;
    end
end
//------------------------------------------------------------------------------
// next state logic
//------------------------------------------------------------------------------
always_comb begin : state_comb_blk

    case(state)
        IDLE: state_nxt    = busy ? IDLE : MEM;
        MEM: state_nxt    = NEWDATA;
        NEWDATA: state_nxt    = IDLE;
        default: state_nxt = IDLE;
    endcase

end
//------------------------------------------------------------------------------
// output register
//------------------------------------------------------------------------------
always_ff @(posedge clk) begin : out_reg_blk
    if(rst) begin : out_reg_rst_blk
        myout <= 1'b0;
    end
    else begin : out_reg_run_blk
        myout <= myout_nxt;
    end
end
//------------------------------------------------------------------------------
// output logic
//------------------------------------------------------------------------------
always_comb begin : out_comb_blk
    case(state_nxt)
        ST_3: myout_nxt    = 1'b1;
        default: myout_nxt = 1'b0;
    endcase



    if(state_nxt == IDLE) begin
        go_nxt = 1'b0;
        o_start_x_nxt = o_start_x;
        o_start_y_nxt = o_start_y;
        o_end_x_nxt = o_end_x;
        o_end_y_nxt = o_end_y;
    end



    if(state_nxt == MEM) begin
        inc_nxt = inc + 1;
    end


    if(state_nxt == NEWDATA) begin
            if (pos) begin //  POSITION CURSOR IN THE COORDINATES
                go_nxt = 1'b1;
                o_start_x_nxt = i_x;
                o_start_y_nxt = i_y;
                o_end_x_nxt = i_x;
                o_end_y_nxt = i_y;
            end else if (draw) begin //  DRAW A LINE BETWEEN COORDINATES
                go_nxt = 1'b1;
                o_start_x_nxt = x_prev;
                o_start_y_nxt = y_prev;
                o_end_x_nxt = i_x;
                o_end_y_nxt = i_y;
            end else begin
                go_nxt = 1'b1;
                o_start_x_nxt = o_start_x;
                o_start_y_nxt = o_start_y;
                o_end_x_nxt = o_end_x;
                o_end_y_nxt = o_end_y;

            end
    end

end

endmodule
