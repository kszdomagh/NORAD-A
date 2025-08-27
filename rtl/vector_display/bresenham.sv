//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   bresenham
 Author:        https://projectf.io/posts/lines-and-triangles/
 Description:  module used for drawing straight lines using bresenham algorithm

  Change log: 
    05.08.2025 - kszdom - changed signed values to unsigned values
    13.08.2025 - kszdom - added enable input port
    26.08.2025 - kszdom - added cease drawing behav to solve issue in DRAW state
    27.09.2025 - kszdom - changed switch confition and logic from (stay > endy) 
                           to (stax > endx)
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
    logic swap;   // swap points to ensure xa <= xb (swap by X)
    logic right;  // drawing direction
    logic up;     // direction for y (+1 or -1)
    logic signed [BRES_WIDTH-1:0] xa, ya;  // start point
    logic signed [BRES_WIDTH-1:0] xb, yb;  // end point
    logic signed [BRES_WIDTH-1:0] x_end, y_end;  // register end point

    // swap based on X (user request)
    always_comb begin
        swap = (stax > endx);  // swap points if stax is greater than endx
        xa = swap ? endx : stax;
        xb = swap ? stax : endx;
        ya = swap ? endy : stay;
        yb = swap ? stay : endy;
        up = (ya < yb); // if true we should increment y, else decrement
    end

    // error values
    logic signed [BRES_WIDTH:0] err;  // a bit wider as signed
    logic signed [BRES_WIDTH:0] dx, dy; // dx positive, dy negative (we keep same err math)
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
                        // use mutually-exclusive branches to avoid multiple non-blocking assignments
                        if (movx && movy) begin
                            x <= right ? x + 1 : x - 1;
                            y <= up    ? y + 1 : y - 1;
                            err <= err + dy + dx;
                        end else if (movx) begin
                            x <= right ? x + 1 : x - 1;
                            err <= err + dy;
                        end else if (movy) begin
                            y <= up ? y + 1 : y - 1;
                            err <= err + dx;
                        end
                    end
                end
            end

            INIT_0: begin
                state <= INIT_1;
                // xa <= xb now ensured by swap (swap based on X)
                dx <= xb - xa;  // dx = abs(xb - xa) (should be >= 0)
                // make dy negative absolute value so err = dx + dy works the same as before
                if (yb >= ya)
                    dy <= - (yb - ya);
                else
                    dy <= - (ya - yb);
            end
            INIT_1: begin
                state <= DRAW;
                err <= dx + dy;
                x <= xa;
                y <= ya;
                x_end <= xb;
                y_end <= yb;
                cease_cnt <= 0;
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
