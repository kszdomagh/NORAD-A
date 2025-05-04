module draw_line #(
    parameter int OUT_WIDTH = 8,
    parameter int FRAME_MIN = 0,
    parameter int FRAME_MAX = 255

)(
    input logic clk,
    input logic rst,
    input logic enabled,

    //  data drawing position inputs
    input logic [OUT_WIDTH-1:0] x_end,
    input logic [OUT_WIDTH-1:0] y_end,

    input logic [OUT_WIDTH-1:0] x_start,
    input logic [OUT_WIDTH-1:0] y_start,

    //  data drawing instructions
    input logic pos,
    input logic draw,

    //  done signal for prev module
    output logic draw_done,

    //  output signals
    output logic [OUT_WIDTH-1:0] x_line,
    output logic [OUT_WIDTH-1:0] y_line,

    output logic [OUT_WIDTH-1:0] x_previous,
    output logic [OUT_WIDTH-1:0] y_previous,

    output logic [3:0] state_cur
);

//  internal signals declaration
logic [OUT_WIDTH-1:0] x_line_nxt, y_line_nxt, x_previous_nxt, y_previous_nxt;
logic draw_done_nxt;

logic signed [9:0] dx, dy, offset, e2;
logic right, down;

logic signed [9:0] dx_nxt, dy_nxt, offset_nxt, e2_nxt;
logic right_nxt, down_nxt;
logic signed [9:0] e2_tmp;


//  machine state declaration - thermometric code 
enum logic [3:0] {
    READY    = 4'b0001,
    DRAWING  = 4'b0010,
    DONE     = 4'b0100,
    POSITION = 4'b1000
} state, state_nxt;

//  next state seq with reset
always_ff @(posedge clk) begin
    if (rst) begin
        state <= READY;
        x_line <= FRAME_MIN;
        y_line <= FRAME_MIN;
        draw_done <= 1'b0;
    end else begin
        //  outputs
        x_line <= x_line_nxt;
        y_line <= y_line_nxt;

        draw_done <= draw_done_nxt;

        x_previous <= x_previous_nxt;
        y_previous <= y_previous_nxt;

        //  internal
        dx <= dx_nxt;
        dy <= dy_nxt;
        offset <= offset_nxt;
        e2 <= e2_nxt;

        right <= right_nxt;
        down <= down_nxt;

        state <= state_nxt;
        state_cur <= state;
    end
end

//  next state logic
always_comb begin
    case(state)

        READY: begin
            draw_done_nxt = 1'b0;
            x_line_nxt = x_line;
            y_line_nxt = y_line;

            if (pos) begin
                state_nxt = POSITION;
            end else if (draw) begin
                logic signed [9:0] dx_tmp, dy_tmp;
                dx_tmp = x_end - x_start;
                dy_tmp = y_end - y_start;

                right_nxt = (dx_tmp >= 0);
                down_nxt  = (dy_tmp >= 0);

                dx_nxt = right_nxt ? dx_tmp : -dx_tmp;
                dy_nxt = down_nxt ? dy_tmp : -dy_tmp;

                offset_nxt = dx_nxt + dy_nxt;

                x_line_nxt = x_start;
                y_line_nxt = y_start;
                x_previous_nxt = x_start;
                y_previous_nxt = y_start;

                state_nxt = DRAWING;
            end else begin
                state_nxt = READY;
            end
        end

        DRAWING: begin
            draw_done_nxt = 1'b0;

            x_line_nxt = x_line;
            y_line_nxt = y_line;
            offset_nxt = offset;
            e2_tmp = offset;

            if ((e2_tmp <<< 1) > -dy) begin
                offset_nxt = offset + dy;
                x_line_nxt = right ? x_line + 1 : x_line - 1;
            end

            if ((e2_tmp <<< 1) < dx) begin
                offset_nxt = offset_nxt + dx;
                y_line_nxt = down ? y_line + 1 : y_line - 1;
            end

            e2_nxt = offset_nxt;

            if ((x_line == x_end) && (y_line == y_end)) begin
                state_nxt = DONE;
            end else begin
                state_nxt = DRAWING;
            end
        end

        
        

        POSITION: begin
            draw_done_nxt = 1'b0;
            x_line_nxt = x_end;
            y_line_nxt = y_end;
            state_nxt = DONE;
        end

        DONE: begin
            draw_done_nxt = 1'b1;
            state_nxt = READY;

            x_previous_nxt = x_line;
            y_previous_nxt = y_line;
        end

        default: state_nxt = READY;
    endcase
end

endmodule
