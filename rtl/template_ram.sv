//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   template_ram
 Author:        Robert Szczygiel
 Version:       1.0
 Last modified: 2023-05-19
 Coding style: Xilinx recommended + ANSI ports
 Description:  Template for RAM module as recommended by Xilinx. The module
 				has second output port 'dpo', which can be removed when not needed
 				(together with 'dpra' and 'read_dpra');

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
		input wire [ADDRESSWIDTH-1:0] a,     // read/write address
		input wire [ADDRESSWIDTH-1:0] dpra,  // read address for second port
		input wire [BITWIDTH-1:0] din, // data input
		output logic [BITWIDTH-1:0] spo, // first output data
		output logic [BITWIDTH-1:0] dpo  // second output data
	);

	(* ram_style = "block" *)
	logic [BITWIDTH-1:0] ram [DEPTH-1:0];

	logic [ADDRESSWIDTH-1:0] read_dpra;
	logic [ADDRESSWIDTH-1:0] read_a;

	always_ff @(posedge clk) begin : ram_operation_blk
		if (we) begin
			ram [a] <= din;
		end
		read_a <= a;        // latch read address on posedge clk
		read_dpra <= dpra;  // latch second read address on posedge clk
	end

	assign spo = ram [read_a];
	assign dpo = ram [read_dpra];

endmodule


