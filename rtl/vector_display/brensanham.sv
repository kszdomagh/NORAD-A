



module bresenham(

input logic clk, reset,
input logic start,

input logic [8:0] x0, y0, x1, y1,


output logic plot,

output logic [10:0] x, y,
output logic done);




logic signed [11:0] dx, dy, err, e2;
logic right, down;

typedef enum logic {IDLE, RUN} state_t;
state_t state;


always_ff @(posedge clk) begin
    done <= 0;
    plot <= 0;
    if (reset) state <= IDLE;


    else case (state)

        IDLE:
            if (start) begin
                dx = x1- x0; // Blocking!
                right = dx >= 0;

                if (~right) dx =-dx;
                    dy = y1- y0;
                    down = dy >= 0;

                if (down) dy =-dy;
                    err = dx + dy;
                    x <= x0;
                    y <= y0;
                    plot <= 1;
                    state <= RUN;

        RUN:
            if (x == x1 && y == y1) begin
                done <= 1;
                state <= IDLE;
            end else begin
                plot <= 1;
                e2 = err << 1;
            if (e2 > dy) begin
                err += dy;
            if (right) x <= x + 10’d 1;
            else
            end
            end
            x <= x- 10’d 1;
            end
            if (e2 < dx) begin
            err += dx;
            if (down) y <= y + 10’d 1;
            else
            y <= y- 10’d 1;


        default:
            state <= IDLE;
        endcase
end
       








endmodule