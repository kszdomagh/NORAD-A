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

    input logic [OUT_WIDTH-1:0] current_x,
    input logic [OUT_WIDTH-1:0] current_y,


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

    logic [2:0] delayinc;  // max val = 8
    logic [2:0] delayinc_nxt;




    always_comb begin

        // Default assignments
        go_nxt         = 1'b0;
        inc_nxt        = 1'b0;
        zero_nxt       = 1'b0;

        o_start_x_nxt  = o_start_x;
        o_start_y_nxt  = o_start_y;
        o_end_x_nxt    = o_end_x;
        o_end_y_nxt    = o_end_y;

        x_prev_nxt     = x_prev;
        y_prev_nxt     = y_prev;

        delayinc_nxt = delayinc;


            if(pos & line) begin //RESET LIKE BEHAV
                go_nxt         = 1'b0;
                inc_nxt        = 1'b0;
                zero_nxt       = 1'b1;

                o_start_x_nxt  = FRAME_MIN;
                o_start_y_nxt  = FRAME_MIN;
                o_end_x_nxt    = FRAME_MIN;
                o_end_y_nxt    = FRAME_MIN;
                x_prev_nxt     = FRAME_MIN;
                y_prev_nxt     = FRAME_MIN;
            end




            if( (current_x == i_x) & (current_y == i_y) ) begin
                delayinc_nxt = delayinc + 1;
                if(delayinc == 4) begin
                    inc_nxt = 1;
                    delayinc_nxt = 0;
                end
            end else if(~busy) begin //  IF THE LINEDRAW IS NOT DRAWING

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

                        x_prev_nxt = i_x;
                        y_prev_nxt = i_y;

                    end else begin
                            
                    end
            //  IF IT IS BUSY THEN STAY IN PLACE
            end else begin

                o_start_x_nxt = o_start_x;
                o_start_y_nxt = o_start_y;
                o_end_x_nxt = o_end_x;
                o_end_y_nxt = o_end_y;

                x_prev_nxt = x_prev;
                y_prev_nxt = y_prev;

            end
    end



    always_ff@(posedge clk) begin
        if( (rst == 1) )begin

            o_start_x <= FRAME_MIN;
            o_start_y <= FRAME_MIN;
            o_end_x <= FRAME_MIN;
            o_end_y <= FRAME_MIN;

            x_prev <= FRAME_MIN;
            y_prev <= FRAME_MIN;

            go <= 1'b0;
            zero <= 1;
            inc <= 0;
            delayinc <= 0;

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

            delayinc <= delayinc_nxt;

        end

    end

endmodule
