module draw_frame #(
	parameter int OUT_WIDTH = 8,
    parameter int FRAME_MIN = 0,
    parameter int FRAME_MAX = 255
	)(
	input logic clk,
	input logic rst,
	input logic enable,

    output logic [OUT_WIDTH-1:0] x_out,
	output logic [OUT_WIDTH-1:0] y_out
);

    logic [OUT_WIDTH-1:0] x_out_nxt;
    logic [OUT_WIDTH-1:0] y_out_nxt;

	always_comb begin

        if(rst == 1)begin
            x_out_nxt = 0;
            y_out_nxt = 0;

        end else if (enable) begin

            // Y COUNTING UP; X CONSTANT FRAME_MIN
            if ( (y_out != FRAME_MAX) || (x_out == FRAME_MIN ) ) begin

                x_out_nxt = FRAME_MIN;
                y_out_nxt = y_out + 1;

            // Y CONSTANT FRAME_MAX; X COUNTING UP
            end else if( (y_out == FRAME_MAX) || (x_out != FRAME_MAX ) ) begin

                x_out_nxt = x_out + 1;
                y_out_nxt = FRAME_MAX;

            // Y COUNTING DOWN; X CONSTANT FRAME_MAX
            end else if( (y_out != FRAME_MIN) || (x_out == FRAME_MAX ) ) begin

                x_out_nxt = FRAME_MAX;
                y_out_nxt = y_out - 1;



            // Y CONSTANT FRAME_MIN; X COUNTING DOWN
            end else if( (y_out == FRAME_MIN) || (x_out != FRAME_MIN ) ) begin

                x_out_nxt = x_out - 1;
                y_out_nxt = FRAME_MIN;


            // ERROR - DOT IN THE MIDDLE
            end else begin

                x_out_nxt = (FRAME_MAX+1)/2;
                y_out_nxt = (FRAME_MAX+1)/2;
            
            end

        //IF NOT ENABLED STAY IN PLACE
		end else begin
            x_out_nxt = x_out;
            y_out_nxt = y_out;
		end
	
	end



	always_ff@(posedge clk) begin
		x_out <= x_out_nxt;
		y_out <= y_out_nxt;
	end
endmodule

