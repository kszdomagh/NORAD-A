//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   bresenham
 Author:        https://projectf.io/posts/lines-and-triangles/
 Description:  module used for drawing straight lines using bresenham algorithm

  Change log: 
    05.08.2025 - kszdom - changed signed values to unsigned values
    13.08.2025 - kszdom - added enable input port
    26.08.2025 - kszdom - added cease drawing behav to solve issue in DRAW state
 */
//////////////////////////////////////////////////////////////////////////////
module bresenham #(
    parameter   BRES_WIDTH = 9,
    parameter CEASE_CYCLES = 2  // number of cycles to hold

    )(  // signed coordinate width
    input  wire logic clk,             // clock
    input  wire logic rst,             // reset
    input  wire logic enable,
    input  wire logic go,           // start line drawing
    input  wire logic signed [BRES_WIDTH-1:0] stax, stay,  // point 0
    input  wire logic signed [BRES_WIDTH-1:0] endx, endy,  // point 1
    output      logic signed [BRES_WIDTH-1:0] x,  y,   // drawing position
    output      logic drawing,         // actively drawing
    output      logic busy,            // drawing request in progress
    output      logic done             // drawing is complete (high for one tick)
    );

    // line properties
    logic swap;   // swap points to ensure endy >= stay
    logic right;  // drawing direction
    logic signed [BRES_WIDTH-1:0] xa, ya;  // start point
    logic signed [BRES_WIDTH-1:0] xb, yb;  // end point
    logic signed [BRES_WIDTH-1:0] x_end, y_end;  // register end point
    always_comb begin
        swap = (stay > endy);  // swap points if stay is below endy - FOR NOW IT WORKS BUT MAKE IT NOT SWAP
        xa = swap ? endx : stax;
        xb = swap ? stax : endx;
        ya = swap ? endy : stay;
        yb = swap ? stay : endy;
    end

    // error values
    logic signed [BRES_WIDTH:0] err;  // a bit wider as signed
    logic signed [BRES_WIDTH:0] dx, dy;
    logic movx, movy;  // horizontal/vertical move required
    logic [$clog2(CEASE_CYCLES+1)-1:0] cease_cnt;       // counter for cease state
    always_comb begin
        movx = (2*err >= dy);
        movy = (2*err <= dx);
    end

    // draw state machine
    enum {IDLE, INIT_0, INIT_1, DRAW} state;
    always_comb drawing = (state == DRAW );

    always_ff @(posedge clk) begin
        case (state)
            DRAW: begin
                if (cease_cnt < CEASE_CYCLES) begin
                    cease_cnt <= cease_cnt + 1;  // CEASE: hold x, y, err
                end else begin
                    cease_cnt <= 0;
                    // Normal DRAW movement
                    if (x == x_end && y == y_end) begin
                        state <= IDLE;
                        busy <= 0;
                        done <= 1;
                    end else begin
                        if (movx) begin
                            x <= right ? x + 1 : x - 1;
                            err <= err + dy;
                        end
                        if (movy) begin
                            y <= y + 1;
                            err <= err + dx;
                        end
                        if (movx && movy) begin
                            x <= right ? x + 1 : x - 1;
                            y <= y + 1;
                            err <= err + dy + dx;
                        end
                    end
                end
            end

            INIT_0: begin
                state <= INIT_1;
                dx <= right ? xb - xa : xa - xb;  // dx = abs(xb - xa)
                dy <= ya - yb;  // dy = -abs(yb - ya)
            end
            INIT_1: begin
                state <= DRAW;
                err <= dx + dy;
                x <= xa;
                y <= ya;
                x_end <= xb;
                y_end <= yb;
            end
            default: begin  // IDLE
                done <= 0;
                if (go) begin
                    state <= INIT_0;
                    right <= (xa < xb);  // draw right to left?
                    busy <= 1;
                end
            end
        endcase

        if (rst || !(enable)) begin //kszdom: added enable
            state <= IDLE;
            busy <= 0;
            done <= 0;
        end
    end
endmodule