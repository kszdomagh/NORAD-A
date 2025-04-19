//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   template_rom
 Author:        Robert Szczygiel
 Version:       1.0
 Last modified: 2017-04-03
 Coding style: Xilinx recommended + ANSI ports
 Description:  Template for ROM module as recommended by Xilinx

 ** This example shows the use of the Vivado rom_style attribute
 **
 ** Acceptable values are:
 ** block : Instructs the tool to infer RAMB type components.
 ** distributed : Instructs the tool to infer LUT ROMs.
 **
 */
//////////////////////////////////////////////////////////////////////////////
module template_rom
	#(parameter
		ADDR_WIDTH = 8,
		DATA_WIDTH = 16
	)
	(
		input wire clk, // posedge active clock
		input wire en,  // enable, can be removed if not needed
		input wire [ADDR_WIDTH - 1 : 0 ] addrA,
		output logic [DATA_WIDTH - 1 : 0 ] xdata_out,
		output logic [DATA_WIDTH - 1 : 0 ] ydata_out
	);

	(* rom_style = "block" *) // block || distributed

	logic [DATA_WIDTH-1:0] xrom [2**ADDR_WIDTH-1:0]; // rom memory
	logic [DATA_WIDTH-1:0] yrom [2**ADDR_WIDTH-1:0]; // rom memory

	initial
		$readmemh("vector_.data", rom);

	always_ff @(posedge clk) begin : rom_read_blk
		if (en)
			xdata_out <= xrom[addrA];
			ydata_out <= yrom[addrA];
	end

endmodule


