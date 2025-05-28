module uwu_rom #(
    parameter int ADDRESSWIDTH = 4,  // 4 bits => 16 entries
    parameter int DATAWIDTH = 18  // 8+8+1+1 = 18 bits
)(
    input logic [ADDRESSWIDTH-1:0] addr,
    output logic [DATAWIDTH-1:0] data_out
);

    always_comb begin
        unique case (addr)
            4'd0:  data_out = {8'd174, 8'd162, 1'b0, 1'b1};
            4'd1:  data_out = {8'd161, 8'd147, 1'b1, 1'b0};
            4'd2:  data_out = {8'd148, 8'd162, 1'b1, 1'b0};
            4'd3:  data_out = {8'd92 , 8'd148, 1'b0, 1'b1};
            4'd4:  data_out = {8'd80 , 8'd165, 1'b1, 1'b0};
            4'd5:  data_out = {8'd105, 8'd167, 1'b1, 1'b0};
            4'd6:  data_out = {8'd210, 8'd98 , 1'b0, 1'b1};
            4'd7:  data_out = {8'd208, 8'd65 , 1'b1, 1'b0};
            4'd8:  data_out = {8'd189, 8'd49 , 1'b1, 1'b0};
            4'd9:  data_out = {8'd151, 8'd49 , 1'b1, 1'b0};
            4'd10: data_out = {8'd133, 8'd68 , 1'b1, 1'b0};
            4'd11: data_out = {8'd118, 8'd50 , 1'b1, 1'b0};
            4'd12: data_out = {8'd79 , 8'd51 , 1'b1, 1'b0};
            4'd13: data_out = {8'd54 , 8'd65 , 1'b1, 1'b0};
            4'd14: data_out = {8'd54 , 8'd105, 1'b1, 1'b0};
            default: data_out = '0;
        endcase
    end

endmodule
