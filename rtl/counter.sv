
module counter #(
	parameter int MAXCOUNT = 255,
	parameter int COUNT_WIDTH = 8
	)(
	input logic clk,
	input logic rst,
	input logic enable,

	input logic load,
	input logic countdown,


    input logic [COUNT_WIDTH-1:0] load_number,
    output logic [COUNT_WIDTH-1:0] count_out
);


	logic [COUNT_WIDTH-1:0] count_nxt;

	always_comb begin

		 if(rst == 1)begin
			  count_nxt = 0;
        end else if(load) begin
            count_nxt = load_number;


        //      OPERATION WHEN ENABLED
        end else if (enable) begin

            if (countdown) begin
                //      COUNTING DOWN
                if (count_out == 0) begin //zeroing after overflow
                    count_nxt = MAXCOUNT;
                end else begin      //normal operation
                    count_nxt = count_out - 1;
                end

            end else begin
                //      COUNTING UP
                if (count_out == (MAXCOUNT)) begin //zeroing after overflow
                    count_nxt = 255;
                end else begin      //normal operation
                    count_nxt = count_out + 1;
                end
            end
		end else begin
		 	count_nxt = count_out;
		end
	
	end



	always_ff@(posedge clk) begin
		count_out <= count_nxt;
	end
endmodule