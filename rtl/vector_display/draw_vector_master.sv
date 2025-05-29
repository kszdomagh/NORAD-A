module draw_vector_master #(
    parameter int OUT_WIDTH = 8,
    parameter int FRAME_MIN = 0,
    parameter int FRAME_MAX = 255
    )(

    // control signals
    input logic clk,
    input logic rst,
    input logic busy,

    // memory control outputs
    output logic zero,
    output logic inc,


    // vector inputs
    input logic pos,
    input logic line,
    input logic [OUT_WIDTH-1:0] i_x,
    input logic [OUT_WIDTH-1:0] i_y,


    //  outputs
    output logic go,
    output logic [OUT_WIDTH-1:0] o_start_x,
    output logic [OUT_WIDTH-1:0] o_start_y,
    output logic [OUT_WIDTH-1:0] o_end_x,
    output logic [OUT_WIDTH-1:0] o_end_y

);

    logic [OUT_WIDTH-1:0] o_start_x_nxt;
    logic [OUT_WIDTH-1:0] o_start_y_nxt;

    logic [OUT_WIDTH-1:0] o_end_x_nxt;
    logic [OUT_WIDTH-1:0] o_end_y_nxt;


    logic [OUT_WIDTH-1:0] x_prev;
    logic [OUT_WIDTH-1:0] y_prev;

    logic [OUT_WIDTH-1:0] x_prev_nxt;
    logic [OUT_WIDTH-1:0] y_prev_nxt;

    logic go_nxt;

    logic inc_nxt;
    logic zero_nxt;


    always_comb begin

        //  IF THE LINEDRAW IS NOT DRAWING
        if(~busy) begin

            inc_nxt = inc + 1;


            //  POSITION CURSOR IN THE COORDINATES
            if (pos) begin

                go_nxt = 1'b1;
                o_start_x_nxt = i_x;
                o_start_y_nxt = i_y;
                o_end_x_nxt = i_x;
                o_end_y_nxt = i_y;

                x_prev_nxt = i_x;
                y_prev_nxt = i_y;


            //  DRAW A LINE BETWEEN COORDINATES
            end else if (line) begin 

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

        //  IF IT IS BUSY THEN STAY IN PLACE
        end else begin

            go_nxt = 1'b0;
            inc_nxt = inc;

            o_start_x_nxt = o_start_x;
            o_start_y_nxt = o_start_y;
            o_end_x_nxt = o_end_x;
            o_end_y_nxt = o_end_y;

            x_prev_nxt = x_prev;
            y_prev_nxt = y_prev;

        end

    end



    always_ff@(posedge clk) begin
        if(rst == 1)begin

            o_start_x <= FRAME_MIN;
            o_start_y <= FRAME_MIN;
            o_end_x <= FRAME_MIN;
            o_end_y <= FRAME_MIN;

            x_prev <= FRAME_MIN;
            y_prev <= FRAME_MIN;

            go <= go_nxt;
            zero <= 1;
            inc <= 0;


        end else begin

            o_start_x <= o_start_x_nxt;
            o_start_y <= o_start_y_nxt;
            o_end_x <= o_end_x_nxt;
            o_end_y <= o_end_y_nxt;

            x_prev <= x_prev_nxt;
            y_prev <= y_prev_nxt;

            go <= go_nxt;

            inc <= inc_nxt;
            zero <= zero_nxt;


        end

    end

endmodule

