//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   timer
 Author:        kszdom
 Description:   simple timer with parameters; one timer out of many in  speed_timer_cluster.
                timer time = parameter - (dec signal)*2^14
 */
//////////////////////////////////////////////////////////////////////////////
module timer #(
    parameter int TIMER_TIME = 100_000_000
)(
    input  logic clk,
    input  logic rst,
    input logic [30:0] dec,
    output logic pulse
);

    localparam int COUNT_WIDTH = $clog2(TIMER_TIME);    //calc the width of count number
    logic [COUNT_WIDTH-1:0] count;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 0;
            pulse <= 0;
        end else begin
            if (count == TIMER_TIME-1 - (dec << 14) ) begin
                count <= 0;
                pulse <= 1;
            end else begin
                count <= count + 1;
                pulse <= 0;
            end
        end
    end

endmodule
