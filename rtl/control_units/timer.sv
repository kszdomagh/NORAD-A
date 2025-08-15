//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   timer
 Author:        kszdom
 Description:  simple timer with parameters; one timer of speed_timer_cluster 
 */
//////////////////////////////////////////////////////////////////////////////
module timer #(
    parameter int TIMER_TIME = 100_000_000
)(
    input  logic clk,
    input  logic rst,
    output logic pulse
);

    localparam int COUNT_WIDTH = $clog2(TIMER_TIME);    //calc the width of count number
    logic [COUNT_WIDTH-1:0] count;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 0;
            pulse <= 0;
        end else begin
            if (count == TIMER_TIME-1) begin
                count <= 0;
                pulse <= 1;
            end else begin
                count <= count + 1;
                pulse <= 0;
            end
        end
    end

endmodule
