//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   cursor
 Author:        kszdom
 Description:  module used for translating button presses to cursor control signals
 */
//////////////////////////////////////////////////////////////////////////////
module cursor #(
    parameter int OUTWIDTH = 8,          // szerokość współrzędnych
    parameter int STEP     = 1,            
    parameter int MINVAL   = 10,
    parameter int MAXVAL   = 245
)(
    input  logic clk,
    input  logic rst,
    input  logic btnR,                    // "prawy przycisk myszy” 
    input  logic btnL,                    // „lewy przycisk myszy” 
    //  input  logic btnC,                    // „środkowy przycisk myszy”  - unused
    input  logic btnU,                    // „górny przycisk myszy” 
    input  logic btnD,                    // „dolny przycisk myszy” 
    output logic [OUTWIDTH-1:0] ycursor,
    output logic [OUTWIDTH-1:0] xcursor
);

    // min + max )/ 2 = middle
    localparam logic [OUTWIDTH-1:0] MIDVAL = ((MAXVAL + MINVAL) >> 1);

    // Rejestry aktualnego stanu
    logic [OUTWIDTH-1:0] x_q, y_q;
    // Następny stan
    logic [OUTWIDTH-1:0] x_d, y_d;

    // inc with sat at MAXVAL
    function automatic logic [OUTWIDTH-1:0] sat_inc(
        input logic [OUTWIDTH-1:0] val,
        input int unsigned step
    );
        logic [OUTWIDTH:0] wide;
        begin
            wide = val + step;
            sat_inc = (wide > MAXVAL) ? MAXVAL : wide[OUTWIDTH-1:0];
        end
    endfunction

    // dec with sat at MINVAL
    function automatic logic [OUTWIDTH-1:0] sat_dec(
        input logic [OUTWIDTH-1:0] val,
        input int unsigned step
    );
        begin
            sat_dec = (val <= (MINVAL + step)) ? MINVAL 
                                               : (val - step[OUTWIDTH-1:0]);
        end
    endfunction

    always_comb begin
        x_d = x_q;
        y_d = y_q;

        // X
        if (btnR & ~btnL) begin
            x_d = sat_inc(x_q, STEP);
        end else if (btnL & ~btnR) begin
            x_d = sat_dec(x_q, STEP);
        end

        // Y
        if (btnU & ~btnD) begin
            y_d = sat_inc(y_q, STEP);
        end else if (btnD & ~btnU) begin
            y_d = sat_dec(y_q, STEP);
        end
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            x_q <= MIDVAL;
            y_q <= MIDVAL;
        end else begin
            x_q <= x_d;
            y_q <= y_d;
        end
    end

    assign xcursor = x_q;
    assign ycursor = y_q;

endmodule
