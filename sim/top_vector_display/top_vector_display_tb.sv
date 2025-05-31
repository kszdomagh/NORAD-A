module top_vector_display_tb;

    // Testbench signals
    logic clk;
    logic rst;


    import vector_pkg::*;


    // INTERNAL WIRES
    logic [ADDRESSWIDTH-1:0] uwu_addr;
    logic [DATAWIDTH-1:0] uwu_data;

    logic [DAC_WIDTH-1:0] x_data;
    logic [DAC_WIDTH-1:0] y_data;



    logic [DAC_WIDTH-1:0] xch;
    logic [DAC_WIDTH-1:0] ych;

    //MODULE DECLARATIONS

    top_vector_display #(
        .OUT_WIDTH(DAC_WIDTH)
    ) u_vector_display (
        .enable(1),
        .clk(clk),
        .rst(rst),

        .data_in(uwu_data),
        .addr(uwu_addr),
        
        .x_ch(xch),
        .y_ch(ych)
    );


    uwu_rom #(
        .ADDRESSWIDTH(4),
        .DATAWIDTH(18)
    ) u_uwu_rom (

        .addr(uwu_addr),
        .data_out(uwu_data)

    );



    assign x_data = uwu_data[9:2];
    assign y_data = uwu_data[17:10];



    // Clock generation
    always #5 clk = ~clk; // 100MHz clock

    // Stimulus block
    initial begin
        // Initialize signals
        clk = 0;
        rst = 0;


        // Reset the design
        rst = 1;
        #10 rst = 0;
    end

endmodule
