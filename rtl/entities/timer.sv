//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   timer
 Author:        kszdom
 Description:  simple timer with parameters; one timer of speed_timer_cluster 
 */
//////////////////////////////////////////////////////////////////////////////
module timer #(
 	parameter int TIMER_TIME = 100_000_000  // one second - max
	)(
	input logic clk100MHz,
	input logic rst,
    output logic pulse
);

    // Automatically calculate the minimum width needed for TIMER_TIME
    localparam int COUNT_WIDTH = $clog2(TIMER_TIME + 1);
    
    logic [COUNT_WIDTH-1:0] count;
    logic [COUNT_WIDTH-1:0] count_nxt;
    logic pulse_nxt;

    always_comb begin
        if(rst) begin
            count_nxt = '0;
            pulse_nxt = 1'b0;

        end else begin
            count_nxt = count + 1;
            pulse_nxt = 1'b0;
            if(count == TIMER_TIME) begin
                pulse_nxt = 1'b1;
                count_nxt = '0;
            end
        end
    end

    always_ff@(posedge clk100MHz) begin
        count <= count_nxt;
        pulse <= pulse_nxt;
    end

endmodule