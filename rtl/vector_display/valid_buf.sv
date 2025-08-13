//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   valid buf
 Author:        kszdom
 Description:  module used for gating output 
 */
//////////////////////////////////////////////////////////////////////////////
module valid_buf #(
	parameter   OUTWIDTH = 8,
    parameter   BRES_WIDTH = 9
    )(  
    input logic clk,             // clock
    input logic rst,             // reset
    input logic valid,           // if valid is high output goes thriuh
    input logic enable,           // enable signal
    input logic signed [BRES_WIDTH-1:0] inx, iny,  // bren signed 
    output logic  [OUTWIDTH-1:0] outx, outy         // DAC output logic
    );


    logic  [OUTWIDTH-1:0] outx_nxt, outy_nxt; 


    always_comb begin

        outx_nxt = 0;
        outy_nxt = 0;

        if(valid) begin
            outx_nxt = inx[OUTWIDTH-1:0];    //no negatives values will occur so i can cut MSB (signed to unsigned conversion)
            outy_nxt = iny[OUTWIDTH-1:0];
        end else begin  // if non valid hold last value
            outx_nxt = outx;
            outy_nxt = outy;
        end
    end

    always_ff@(posedge clk) begin

        if(rst || !(enable)) begin
            outx <= '0;
            outy <= '0;
        end else begin
            outx <= outx_nxt;
            outy <= outy_nxt;
        end

    end


endmodule