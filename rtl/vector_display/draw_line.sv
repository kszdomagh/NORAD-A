




module draw_line #(

    parameter int OUT_WIDTH = 8,
    parameter int FRAME_MIN = 0,
    parameter int FRAME_MAX = 255

)(
    input logic clk,
    input logic rst,
    input logic enabled,

    //      data drawing inputs
    input logic [OUT_WIDTH-1:0] x_point,
    input logic [OUT_WIDTH-1:0] y_point,
    input logic zero,


    //       done signal for prev module
    output logic draw_done,

    //      output signals
    input logic [OUT_WIDTH-1:0] x_line,
    input logic [OUT_WIDTH-1:0] y_line

);







endmodule