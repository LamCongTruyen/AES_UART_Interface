

    // ==============================
    //ĐÂY LÀ TOPMODULE CAO NHẤT, CHỨA 3 MODULE LÀ: topmoduel cũ
	 //AES: MÃ HÓA VÀ 2 MODULE UART TRUYỀN DỮ LIỆU
    // ==============================


module aes_uart_top (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        rx,
    output logic         tx
);

    logic [127:0] data_out_128;
	 logic [127:0] key= 128'h0f1571c947d9e8590cb7add6af7f6798;
	 logic [127:0] nonce = 128'h00000000000000000000000000000001;
    logic         data_valid;
    logic         uart_rx_enable;

    logic [127:0] aes_ciphertext;
    logic         aes_done;
    logic         aes_enable;

    logic         uart_tx_start;
    logic         tx_done;

    aes_to_tx_top u_uart_tx (
        .clk(clk),
        .reset(rst_n),
        .start(uart_tx_start),
        .ciphertext(aes_ciphertext),
        .tx(tx),
        .done(tx_done)
    );

    //assign TX_valid_out = tx_done;
    uart_rx_top u_uart_rx (
        .clk(clk),
        .rst_n(rst_n),
        .rx(rx),
        .enable(uart_rx_enable),
        .data_out_128(data_out_128),
        .data_valid(data_valid)
    );

    AES_CTR_pipelined u_aes_ctr (
        .clk(clk),
        .reset(rst_n),
        .enable(aes_enable),
        .key(key),
        .nonce(nonce),
        .plaintext(data_out_128),
        .ciphertext(aes_ciphertext),
        .valid_out(aes_done)
    );

    //assign aes_valid_out = aes_done;
    //assign ciphertextout = aes_ciphertext;

    typedef enum logic [1:0] {
        IDLE,
        AES_BUSY
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= IDLE;
        else
            state <= next_state;
    end

    always_comb begin
        next_state     = state;
        uart_rx_enable = 1'b0;
        aes_enable     = 1'b0;
        uart_tx_start  = 1'b0;

        case (state)
            IDLE: begin
                uart_rx_enable = 1'b1;
                if (data_valid) begin
                    aes_enable    = 1'b1; 
                    next_state    = AES_BUSY;
                end
            end
            AES_BUSY: begin
					 aes_enable    = 1'b0;
                if (aes_done) begin
                    uart_tx_start = 1'b1; 
                    next_state    = IDLE;
                end
            end
        endcase
    end

endmodule
