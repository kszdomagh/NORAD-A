module memory_draw_vector_master #(
    parameter int ADDRESSWIDTH = 10,
    parameter int OUT_WIDTH = 8,
    parameter int FRAME_MIN = 0,
    parameter int FRAME_MAX = 255
)(
    input  logic                  clk,
    input  logic                  rst_n,

    // memory inputs data
    input  logic                  pos,
    input  logic                  draw,
    input  logic [OUT_WIDTH-1:0] i_x,
    input  logic [OUT_WIDTH-1:0] i_y,

    // info from linedraw
    input  logic                  busy,

    // memory manage signals
    input  logic                    inc,
    output logic [ADDRESSWIDTH-1:0] count_adr,

    // draw_vector_master outputs
    output logic                  go,
    output logic [OUT_WIDTH-1:0]  o_start_x,
    output logic [OUT_WIDTH-1:0]  o_start_y,
    output logic [OUT_WIDTH-1:0]  o_end_x,
    output logic [OUT_WIDTH-1:0]  o_end_y
);


    logic [OUT_WIDTH-1:0] o_start_x_nxt;
    logic [OUT_WIDTH-1:0] o_start_y_nxt;
    logic [OUT_WIDTH-1:0] o_end_x_nxt;
    logic [OUT_WIDTH-1:0] o_end_y_nxt;

    logic [OUT_WIDTH-1:0] x_prev;
    logic [OUT_WIDTH-1:0] y_prev;

    logic go_nxt;
    logic [ADDRESSWIDTH-1:0] count_adr_nxt;


    always_comb begin

        // defaults
        o_start_x_nxt = o_start_x;
        o_start_y_nxt = o_start_y;
        o_end_x_nxt   = o_end_x;
        o_end_y_nxt   = o_end_y;
        go_nxt        = 1'b0;
        count_adr_nxt = count_adr_nxt;
        //memory manage


        //  IF THE LINEDRAW IS NOT DRAWING
        if (~busy) begin

            count_adr_nxt = count_adr + 1;

            //  POSITION CURSOR IN THE COORDINATES
            if (pos) begin
                go_nxt = 1'b1;
                o_start_x_nxt = i_x;
                o_start_y_nxt = i_y;
                o_end_x_nxt = i_x;
                o_end_y_nxt = i_y;
            //  DRAW A LINE BETWEEN COORDINATES
            end else if (draw) begin
                go_nxt = 1'b1;
                o_start_x_nxt = x_prev;
                o_start_y_nxt = y_prev;
                o_end_x_nxt = i_x;
                o_end_y_nxt = i_y;
            end else begin
                go_nxt = 1'b1;
            end
        end
    end


    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count_adr <= 0;

            o_start_x <= FRAME_MIN;
            o_start_y <= FRAME_MIN;
            o_end_x <= FRAME_MIN;
            o_end_y <= FRAME_MIN;

            x_prev <= FRAME_MIN;
            y_prev <= FRAME_MIN;

            go <= 1'b0;
        end else begin

            // MEMORY MANAGE
            count_adr <= count_adr_nxt;

            // POINTS MANAGE
            o_start_x <= o_start_x_nxt;
            o_start_y <= o_start_y_nxt;
            o_end_x <= o_end_x_nxt;
            o_end_y <= o_end_y_nxt;

            x_prev <= i_x;
            y_prev <= i_y;

            go <= go_nxt;
        end
    end

endmodule
