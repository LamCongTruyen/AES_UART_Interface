//==================================================================================//
// uart_aes_loopback – ĐÃ SỬA LỖI MULTIPLE DRIVERS
// Gộp tất cả logic vào 1 always_ff duy nhất
//==================================================================================//
module uart_aes_loopback (
    input  wire  clk,
    input  wire  rst_n,
    input  wire  rx,
    input  wire [127:0] key,
    input  wire [127:0] nonce,
    output wire  tx
);

    // =============================================================================
    // PARAMETERS
    // =============================================================================
    localparam RX_BLOCK_SIZE = 16;
    localparam TX_FIFO_DEPTH = 64;
    localparam DATA_WIDTH    = 8;

    // =============================================================================
    // INTERNAL SIGNALS
    // =============================================================================
    wire [7:0]  rx_data;
    wire        rx_valid;

    reg         aes_enable;
    reg [127:0] aes_plaintext;
    wire [127:0] ciphertext;
    wire        aes_valid_out;

    // RX: Gom 16 byte
    reg [127:0] rx_block_reg;
    reg [3:0]   rx_byte_count;
    reg         rx_block_ready;

    // TX FIFO
    reg [7:0]   tx_fifo [0:TX_FIFO_DEPTH-1];
    reg [5:0]   tx_wr_ptr, tx_rd_ptr;
    reg [6:0]   tx_count;
    wire        tx_fifo_not_empty;
    reg         tx_trigger;
    wire        tx_busy;
    reg [7:0]   tx_data;

    // =============================================================================
    // INSTANCES
    // =============================================================================
    uart_rx uart_rx_inst (
        .clk(clk),
        .rst_n(rst_n),
        .rx(rx),
        .data_out(rx_data),
        .valid(rx_valid)
    );

    AES_CTR_pipelined u_aes (
        .clk(clk),
        .reset(~rst_n),
        .enable(aes_enable),
        .key(key),
        .nonce(nonce),
        .plaintext(aes_plaintext),
        .ciphertext(ciphertext),
        .valid_out(aes_valid_out)
    );

    uart_tx uart_tx_inst (
        .clk(clk),
        .rst_n(rst_n),
        .trigger(tx_trigger),
        .data_in(tx_data),
        .tx(tx),
        .busy(tx_busy)
    );

    assign tx_fifo_not_empty = (tx_count > 0);

    // =============================================================================
    // SINGLE always_ff BLOCK – TẤT CẢ LOGIC Ở ĐÂY
    // =============================================================================
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset tất cả
            rx_block_reg    <= 128'h0;
            rx_byte_count   <= 4'd0;
            rx_block_ready  <= 1'b0;
            aes_enable      <= 1'b0;
            aes_plaintext   <= 128'h0;
            tx_wr_ptr       <= 6'd0;
            tx_rd_ptr       <= 6'd0;
            tx_count        <= 7'd0;
            tx_trigger      <= 1'b0;
            tx_data         <= 8'h00;

        end else begin
            // Default values
            rx_block_ready <= 1'b0;
            aes_enable     <= 1'b0;
            tx_trigger     <= 1'b0;

            // =================================================================
            // 1. RX: Gom 16 byte → 128 bit
            // =================================================================
            if (rx_valid) begin
                rx_block_reg  <= {rx_block_reg[119:0], rx_data};
                rx_byte_count <= rx_byte_count + 1;

                if (rx_byte_count == 4'd15) begin
                    rx_block_ready <= 1'b1;
                    rx_byte_count  <= 4'd0;
                end
            end

            // =================================================================
            // 2. AES: Kích hoạt khi có block
            // =================================================================
            if (rx_block_ready) begin
                aes_plaintext <= {rx_block_reg[119:0], rx_data};  // block cuối
                aes_enable    <= 1'b1;
            end

            // =================================================================
            // 3. AES → TX FIFO: Ghi 16 byte
            // =================================================================
            if (aes_valid_out && tx_count <= TX_FIFO_DEPTH - 16) begin
                integer i;
                for (i = 0; i < 16; i = i + 1) begin
                    tx_fifo[tx_wr_ptr + i] <= ciphertext[127 - 8*i -: 8];
                end
                tx_wr_ptr <= tx_wr_ptr + 16;
                tx_count  <= tx_count + 16;
            end

            // =================================================================
            // 4. TX FIFO → UART TX
            // =================================================================
            if (tx_fifo_not_empty && !tx_busy && !tx_trigger) begin
                tx_data    <= tx_fifo[tx_rd_ptr];
                tx_trigger <= 1'b1;
                tx_rd_ptr  <= (tx_rd_ptr == TX_FIFO_DEPTH-1) ? 0 : tx_rd_ptr + 1;
                tx_count   <= tx_count - 1;
            end

        end
    end

    // =============================================================================
    // POINTER WRAP (an toàn)
    // =============================================================================
    // Đã xử lý trong điều kiện tăng

endmodule