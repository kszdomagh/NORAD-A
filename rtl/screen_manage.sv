//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   screen_manage
 Author:        kszdom
 Description:   module used for controlling whats beeing displayed
 */
//////////////////////////////////////////////////////////////////////////////
module screen_manage #(
    parameter int DATAWIDTH = 18,
    parameter int ADRESSWIDTH = 8
)(
	input logic base1_nuked,
	input logic base2_nuked,
	input logic base3_nuked,

	input logic start_game,
    input logic mtm_show,
    input logic show_death,

	output logic [ADRESSWIDTH-1:0] adr_mtm,
	output logic [ADRESSWIDTH-1:0] adr_ram,
	output logic [ADRESSWIDTH-1:0] adr_startscreen,
	output logic [ADRESSWIDTH-1:0] adr_endscreen,

	input logic [DATAWIDTH-1:0] data_mtm,
	input logic [DATAWIDTH-1:0] data_ram,
	input logic [DATAWIDTH-1:0] data_startscreen,
	input logic [DATAWIDTH-1:0] data_endscreen,


	output logic [DATAWIDTH-1:0] data_out,
	input logic [ADRESSWIDTH-1:0] adr_in
    
);

    always_comb begin
        adr_mtm = '0;
        adr_ram = '0;
        adr_startscreen = '0;
        adr_endscreen = '0;

        if (mtm_show) begin
            adr_mtm = adr_in;
            data_out = data_mtm;
        end else if ((base1_nuked & base2_nuked & base3_nuked) || show_death) begin
            adr_endscreen = adr_in;
            data_out = data_endscreen;
        end else if (!start_game) begin
            adr_startscreen = adr_in;
            data_out = data_startscreen;
        end else begin
            adr_ram = adr_in;
            data_out = data_ram;
        end
    end




endmodule
