//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   template_ram
 Author:        Robert Szczygiel
 Version:       1.0
 Last modified: 2023-05-19
 Coding style: Xilinx recommended + ANSI ports
 Description:  Template for RAM module as recommended by Xilinx. The module
 				has second output port 'dpo', which can be removed when not needed
 				(together with 'adr_r' and 'read_adr_r');

 ** This example shows the use of the Vivado rom_style attribute
 **
 ** Acceptable values are:
 ** block : Instructs the tool to infer RAMB type components.
 ** distributed : Instructs the tool to infer LUT ROMs.
 **
 */
//////////////////////////////////////////////////////////////////////////////
module template_ram
	#(parameter
		ADDRESSWIDTH = 6,
		BITWIDTH = 10,
		DEPTH = 34
	)
	(
		input wire clk, // posedge active clock
		input wire we,  // write enable
		input wire [ADDRESSWIDTH-1:0] adr_rw,     // read/write address
		input wire [ADDRESSWIDTH-1:0] adr_r,  // read address for second port
		input wire [BITWIDTH-1:0] din, // data input
		output logic [BITWIDTH-1:0] data_out1, // first output data
		output logic [BITWIDTH-1:0] data_out2  // second output data
	);

	(* ram_style = "block" *)
	logic [BITWIDTH-1:0] ram [DEPTH-1:0];

	logic [ADDRESSWIDTH-1:0] read_adr_r;
	logic [ADDRESSWIDTH-1:0] read_a;

	always_ff @(posedge clk) begin : ram_operation_blk
		if (we) begin
			ram [adr_rw] <= din;
		end
		read_a <= adr_rw;        // latch read address on posedge clk
		read_adr_r <= adr_r;  // latch second read address on posedge clk
	end

	assign data_out1 = ram [read_a];
	assign data_out2 = ram [read_adr_r];

endmodule


