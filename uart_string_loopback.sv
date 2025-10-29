module uart_string_loopback (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        rx,
    output logic        tx
);

    // Parameters
    localparam BUFFER_SIZE_RX = 16; // bytes for AES plaintext (128-bit)
    localparam BUFFER_SIZE_TX = 16; // bytes for AES ciphertext (128-bit)

    // ------------ UART <-> internal signals -------------
    logic [7:0]   rx_data;
    logic         rx_valid;

    logic [7:0]   tx_data;
    logic         tx_trigger;
    logic         tx_busy;

    // ------------ RX buffering (simple counter + ring index) -------------
    logic [7:0]   rx_buffer [0:BUFFER_SIZE_RX-1];
    logic [$clog2(BUFFER_SIZE_RX)-1:0] rx_write_ptr;
    logic [$clog2(BUFFER_SIZE_RX)-1:0] rx_read_ptr;
    logic         rx_buffer_full;
    logic         rx_buffer_empty;
    logic         rx_buffer_ready;

    // ------------ TX buffering (simple) -------------
    logic [7:0]   tx_buffer [0:BUFFER_SIZE_TX-1];
    logic [$clog2(BUFFER_SIZE_TX)-1:0] tx_write_ptr;
    logic [$clog2(BUFFER_SIZE_TX)-1:0] tx_read_ptr;
    logic         tx_buffer_full;
    logic         tx_buffer_empty;

    // ------------ AES related -------------
    logic aes_reset;
    logic aes_enable;
    logic [127:0] key   = 128'h0f1571c947d9e8590cb7add6af7f6798;
    logic [127:0] nonce = 128'h00000000000000000000000000000001;
    logic [127:0] aes_plaintext;
    logic [127:0] aes_ciphertext;
    logic         aes_valid_out;
	 logic aes_processing;
	 
    reg [127:0] last_plaintext;
    reg [127:0] last_ciphertext;
    
    assign aes_reset = ~rst_n;
	 assign rx_buffer_full  = (rx_write_ptr + 1'b1) == rx_read_ptr;
    assign rx_buffer_empty = rx_write_ptr == rx_read_ptr;
    assign rx_buffer_ready = (rx_write_ptr - rx_read_ptr) == BUFFER_SIZE_RX;
	 assign tx_buffer_full  = (tx_write_ptr + 1'b1) == tx_read_ptr;
    assign tx_buffer_empty = tx_write_ptr == tx_read_ptr;
	 
    // ------------- Instantiate AES and UART modules -------------
    AES_CTR_pipelined aes_inst (
        .clk       (clk),
        .reset     (aes_reset),
        .enable    (aes_enable),
        .key       (key),
        .nonce     (nonce),
        .plaintext (aes_plaintext),
        .ciphertext(aes_ciphertext),
        .valid_out (aes_valid_out)
    );

    uart_rx uart_rx_inst (
        .clk      (clk),
        .rst_n    (rst_n),
        .rx       (rx),
        .data_out (rx_data),
        .valid    (rx_valid)
    );

    uart_tx uart_tx_inst (
        .clk     (clk),
        .rst_n   (rst_n),
        .trigger (tx_trigger),  // <-- Kết nối đúng trigger
        .data_in (tx_data),
        .tx      (tx),
        .busy    (tx_busy)
    );

    // ---------------- Reset / init ----------------
   always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rx_write_ptr   <= '0;
            rx_read_ptr    <= '0;
            aes_processing <= 1'b0;
            aes_enable     <= 1'b0;
            last_plaintext <= '0;
            last_ciphertext <= '0;
        end else begin
            // --- RX: Nhận byte từ UART ---
            if (rx_valid && !rx_buffer_full) begin
                rx_buffer[rx_write_ptr] <= rx_data;
                rx_write_ptr <= (rx_write_ptr == BUFFER_SIZE_RX-1) ? '0 : rx_write_ptr + 1'b1;
            end

            // --- AES: Khi đủ 16 byte, kích hoạt mã hóa ---
            if (rx_buffer_ready && !aes_processing) begin
                // Ghép 16 byte thành 128-bit plaintext
                for (int i = 0; i < 16; i++) begin
                    aes_plaintext[127 - i*8 -: 8] <= rx_buffer[i];
                end
                aes_enable     <= 1'b1;
                aes_processing <= 1'b1;
                rx_read_ptr    <= rx_write_ptr;  // Xóa buffer RX
            end else begin
                aes_enable <= 1'b0;
            end

            // --- AES: Khi mã hóa xong, lưu kết quả ---
            if (aes_valid_out) begin
                aes_processing  <= 1'b0;
                last_plaintext  <= aes_plaintext;
                last_ciphertext <= aes_ciphertext;
            end
        end
    end

    // Logic bộ đệm TX: Khi AES hoàn tất, phân tách ciphertext vào bộ đệm TX
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            tx_write_ptr <= '0;
            tx_read_ptr  <= '0;
            tx_trigger   <= 1'b0;
        end else begin
            // --- TX: Ghi ciphertext vào buffer khi AES xong ---
            if (aes_valid_out && !tx_buffer_full) begin
                for (int i = 0; i < 16; i++) begin
                    tx_buffer[i] <= aes_ciphertext[127 - i*8 -: 8];
                end
                tx_write_ptr <= (tx_write_ptr + 16) % BUFFER_SIZE_TX;
            end

            // --- TX: Gửi byte ra UART ---
            if (!tx_busy && !tx_buffer_empty && !tx_trigger) begin
                tx_data     <= tx_buffer[tx_read_ptr];
                tx_trigger  <= 1'b1;
                tx_read_ptr <= (tx_read_ptr == BUFFER_SIZE_TX-1) ? '0 : tx_read_ptr + 1'b1;
            end else begin
                tx_trigger  <= 1'b0;
            end
        end
    end

endmodule
