
module aes_uart_rx_top (
    input  logic clk,
    input  logic reset,
    input  logic rx,
    output logic tx,
    output logic done
);
	 logic [127:0] key   = 128'h0f1571c947d9e8590cb7add6af7f6798;
    logic [127:0] nonce = 128'h00000000000000000000000000000001;
    // RX
    logic [7:0] uart_data_out;
    logic uart_valid;

    // AES
    logic aes_enable;
    logic [127:0] aes_plaintext;
    logic [127:0] ciphertext;
    logic valid_out;

    // TX
    logic start_uart;
    logic uart_done;

    logic [7:0] buffer [0:79];
    logic [6:0] byte_count;  
    logic [2:0] block_index; 
    logic [127:0] latched_ciphertext;
    logic latched_valid;

    typedef enum logic [3:0] {
        ST_IDLE     = 4'd0,
        ST_RECEIVE  = 4'd1,
        ST_PREPARE  = 4'd2,
        ST_START_AES= 4'd3,
        ST_WAIT_AES = 4'd4,
        ST_SEND_UART= 4'd5,
        ST_NEXT_BLK = 4'd6,
        ST_DONE     = 4'd7
    } state_t;
    state_t state;

    // UART RX
    uart_rx u_uart_rx (
        .clk(clk),
        .rst_n(~reset),
        .rx(rx),
        .data_out(uart_data_out),
        .valid(uart_valid)
    );

    // AES CTR
    AES_CTR_pipelined u_aes (
        .clk(clk),
        .reset(reset),
        .enable(aes_enable),
        .key(key),
        .nonce(nonce),
        .plaintext(aes_plaintext),
        .ciphertext(ciphertext),
        .valid_out(valid_out)
    );

    // UART TX
    aes_to_tx_top aes_to_tx_inst (
        .clk        (clk),
        .reset      (reset),
        .start      (start_uart),
        .ciphertext (latched_ciphertext),
        .tx         (tx),
        .done       (uart_done)
    );

    // ================= FSM ==================
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= ST_IDLE;
            byte_count <= 0;
            block_index <= 0;
            aes_enable <= 0;
            start_uart <= 0;
            done <= 0;
            latched_valid <= 0;
        end else begin
            // default
            aes_enable <= 0;
            start_uart <= 0;
            done <= 0;

            case (state)
                // --- Giai đoạn nhận UART ---
                ST_IDLE: begin
                    byte_count <= 0;
                    block_index <= 0;
                    if (uart_valid) begin
                        buffer[0] <= uart_data_out;
                        byte_count <= 1;
                        state <= ST_RECEIVE;
                    end
                end

                ST_RECEIVE: begin
                    if (uart_valid) begin
                        buffer[byte_count] <= uart_data_out;
                        byte_count <= byte_count + 1;
                    end
                    if (byte_count == 7'd80) begin
                        state <= ST_PREPARE;  // nhận đủ 80 byte
                    end
                end

                // --- Chuẩn bị 1 block 128 bit ---
                ST_PREPARE: begin
                    for (int i = 0; i < 16; i++) begin
                        aes_plaintext[127 - i*8 -: 8] <= buffer[block_index*16 + i];
                    end
                    state <= ST_START_AES;
                end

                // --- Bắt đầu mã hóa ---
                ST_START_AES: begin
                    aes_enable <= 1'b1;
                    state <= ST_WAIT_AES;
                end

                // --- Đợi AES hoàn thành ---
                ST_WAIT_AES: begin
                    if (valid_out) begin
                        latched_ciphertext <= ciphertext;
                        latched_valid <= 1'b1;
                        state <= ST_SEND_UART;
                    end
                end

                // --- Gửi dữ liệu ra TX ---
                ST_SEND_UART: begin
                    start_uart <= 1'b1;
                    if (uart_done) begin
                        latched_valid <= 1'b0;
                        state <= ST_NEXT_BLK;
                    end
                end

                // --- Kiểm tra còn block không ---
                ST_NEXT_BLK: begin
                    if (block_index < 4) begin
                        block_index <= block_index + 1;
                        state <= ST_PREPARE;
                    end else begin
                        state <= ST_DONE;
                    end
                end

                ST_DONE: begin
                    done <= 1'b1;
                    if (!uart_valid)
                        state <= ST_IDLE;
                end
            endcase
        end
    end

endmodule
