

    // ==============================
    //module chương trình giả lập UART_TX truyền dữ liệu cipher ra cổng TX. 
	 //TESTBENCH của nó là tb_aes_uart_to_tx_test
    // ==============================

module uart_tx_top_test #(
    parameter CLK_FREQ  = 50_000_000,   
    parameter BAUD_RATE = 115200,
    parameter BUFFER_SIZE = 1024
)(
    input  logic clk,     
    input  logic reset,     
    input  logic key1,      
    output logic tx       
);

    localparam [127:0] CIPHERTEXT = 128'h22222222222222222222222222222222;

    logic start_signal;
    logic done_signal;

    logic key1_sync_0, key1_sync_1, key1_prev;
    logic reset_sync_0, reset_sync_1;

    always_ff @(posedge clk) begin
        reset_sync_0 <= reset;
        reset_sync_1 <= reset_sync_0;

        key1_sync_0 <= key1;
        key1_sync_1 <= key1_sync_0;
        key1_prev   <= key1_sync_1;
    end

    logic reset_n;
    assign reset_n = reset_sync_1;
    assign start_signal = (key1_prev == 1 && key1_sync_1 == 0);
    aes_to_tx_top tx_inst (
        .clk(clk),
        .reset(reset_n),
        .start(start_signal),
        .ciphertext(CIPHERTEXT),
        .tx(tx),
        .done(done_signal)
    );

endmodule
