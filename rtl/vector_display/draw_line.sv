module line_drawer (
    input logic clk,
    input logic rst_n,           // Reset, active low
    input logic [7:0] x0, y0,    // Start coordinates
    input logic [7:0] x1, y1,    // End coordinates
    output logic [7:0] x_out, y_out,  // Current point on the line
    output logic line_done       // Signal when the line drawing is done
);
    logic [7:0] x, y;          // Current coordinates
    logic [7:0] dx, dy;        // Differences in x and y
    logic [7:0] sx, sy;        // Step directions
    logic [7:0] err, e2;       // Error terms

    // Initialize values on reset
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            x <= 0;
            y <= 0;
            x_out <= 0;
            y_out <= 0;
            line_done <= 0;
        end else begin
            if (!line_done) begin
                //     BRESENHAMS LINE DRAWING ALGORITHM
                dx <= (x1 > x0) ? (x1 - x0) : (x0 - x1);
                dy <= (y1 > y0) ? (y1 - y0) : (y0 - y1);
                sx <= (x0 < x1) ? 1 : -1;
                sy <= (y0 < y1) ? 1 : -1;
                err <= dx - dy;
                
                //DRAWING LINE
                if (x == x1 && y == y1) begin
                    line_done <= 1;
                end else begin
                    e2 <= err << 1;
                    if (e2 > -dy) begin
                        err <= err - dy;
                        x <= x + sx;
                    end
                    if (e2 < dx) begin
                        err <= err + dx;
                        y <= y + sy;
                    end
                    // Output current coordinates
                    x_out <= x;
                    y_out <= y;
                end
            end
        end
    end
endmodule