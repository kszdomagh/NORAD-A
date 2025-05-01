
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
    output logic [OUT_WIDTH-1:0] y_previous




);


//  internal signals declaration
logic [OUT_WIDTH-1:0] x_line_nxt;
logic [OUT_WIDTH-1:0] y_line_nxt;
logic draw_done_nxt;

logic signed [9:0] dx, dy, offset, e2;
logic right, down;

//  machine state declaration - termometric code 
enum logic [3:0] {
    READY    = 4'b0001,
    DRAWING  = 4'b0010,
    DONE     = 4'b0100,
    POSITION = 4'b1000
} state, state_nxt;


//  next state seq with reset
always_ff @(posedge clk) begin

    if(rst)begin
        state <= READY;
    end else begin
        state <= state_nxt;
        x_line <= x_line_nxt;
        y_line <= y_line_nxt;

        draw_done <= draw_done_nxt;
    end

end


//  next state logic
always_comb begin

    case(state)

        READY: begin

            x_line_nxt = x_line;
            y_line_nxt = y_line;

            if(pos) begin
                state_nxt = POSITION;
            end else if(draw) begin
                dx = x_end - x_start;
                right = (dx >= 0);

                if(~right) begin
                    dx = -dx;
                end

                dy = y_end - y_start;
                down = (dy >= 0); 

                if(down) begin
                    dy=-dy;
                end

                offset = dx + dy;
                state_nxt = DRAWING;

            end else begin
                state_nxt = READY;
            end
        end

        // drawing a line between two points
        DRAWING: begin
            x_line_nxt = x_start;
            y_line_nxt = y_start;
            draw_done_nxt = 1'b0;


            if ( (x_line == x_end) && (y_line ==y_end) ) begin
                state_nxt = DONE;

            end else begin

                e2 = offset << 1;

                if(e2 < dy) begin
                    offset += dy;

                    if(right) begin
                        x_line_nxt = x_line + 1;
                    end else begin
                        x_line_nxt = x_line - 1;
                    end
                    
                end else if(e2 < dx) begin
                    offset += dx;

                    if(down) begin
                        y_line_nxt = y_line + 1;
                    end else begin
                        y_line_nxt = y_line - 1;
                    end
                end

                state_nxt = DRAWING;
            end

        end

        //  position cursor in the next point wihout drawing a line
        POSITION: begin
            x_line_nxt = x_end;
            y_line_nxt = y_end;
            state_nxt = READY;
        end

        //  operaring with current coordinates ended => proceed
        DONE: begin
            draw_done_nxt = 1'b1;
            state_nxt = READY;
        end

        default: state_nxt = READY;


    endcase

end



endmodule