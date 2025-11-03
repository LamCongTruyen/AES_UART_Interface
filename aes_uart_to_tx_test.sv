
    // ==============================
    //module chương trình lấy cipher từ AES truyền qua UART_TX. TESTBENCH của nó là tb_aes_uart_to_tx_test
    // ==============================

module aes_uart_to_tx_test (
    input  logic        clk,
    input  logic        reset,
	 input  logic			 key1,   
	 input  logic   		 rx,
    output logic         tx

);
	 localparam [127:0] PLAINTEXT = 128'h22222222222222222222222222222222; 
	 localparam [127:0] KEY= 128'h0f1571c947d9e8590cb7add6af7f6798;
	 localparam [127:0] NONCE = 128'h00000000000000000000000000000001;
	 
	 logic [127:0] data_out_rx_128;
    logic         data_valid;
    logic         uart_rx_enable;
    logic [127:0] aes_ciphertext;
	 logic [127:0] aes_plaintext;
	 logic [127:0] cipher_latched;
	 logic  			validout_latch;
	 logic [127:0] data_out_rx_128_latched;
	 logic  			data_valid_latch;
    logic         aes_done;
    logic         aes_enable;
    logic         uart_tx_start;
    logic         tx_done;
	 logic start_signal;
    logic done_signal;
	 logic key1_sync_0, key1_sync_1, key1_prev;
    logic reset_sync_0, reset_sync_1;
	 logic reset_n;

    //assign aes_valid_out = aes_done;
    //assign ciphertextout = aes_ciphertext;
    typedef enum logic [1:0] {
        IDLE,
        AES_BUSY,
		  TX_BUSY
    } state_t;

    state_t state, next_state;

	 always_ff @(posedge clk) begin
        reset_sync_0 <= reset;
        reset_sync_1 <= reset_sync_0;
		  
        key1_sync_0 <= key1;
        key1_sync_1 <= key1_sync_0;
        key1_prev   <= key1_sync_1;
    end
	 
	 assign start_signal = (key1_prev == 1'b1 && key1_sync_1 == 1'b0);
    assign reset_n = reset_sync_1;
	 
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n)
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
					 //uart_tx_start = 1'b0;
                uart_rx_enable = 1'b1;
                if (data_valid_latch) begin
                    aes_enable    = 1'b1; 
                    next_state    = AES_BUSY;
                end
            end
            AES_BUSY: begin
					 aes_enable    = 1'b0;
                if (validout_latch) begin
						  uart_tx_start = 1'b1;
						  //cipher_latched = aes_ciphertext;
                    next_state    = TX_BUSY;
                end
            end
				TX_BUSY: begin
					 uart_tx_start = 1'b0; 
					 if(tx_done) begin
						next_state = IDLE;
					 end
				end
        endcase
    end
	
	 always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            cipher_latched <= 128'd0;
				data_out_rx_128_latched <= 128'd0;
				validout_latch <= 1'b0;
				data_valid_latch <= 1'b0;
		  end
        else if (aes_done) begin
				validout_latch <= aes_done;
				cipher_latched <= aes_ciphertext;
		  end
		  else if(data_valid) begin
				data_valid_latch <= 1'b1;
				data_out_rx_128_latched <= data_out_rx_128;
		  end
		  else begin
		     cipher_latched <= 128'd0;
			  data_out_rx_128_latched <= 128'd0;
			  validout_latch <= 1'b0;
			  data_valid_latch <= 1'b0;
		  end
    end

	uart_rx_top #(
		  .BUFFER_SIZE(256),
		  .DATA_WIDTH(8)
		  ) u_uart_rx (
        .clk(clk),
        .rst_n(reset_n),
        .rx(rx), 
        .data_out_128(data_out_rx_128),
        .data_valid(data_valid)
    );
	 
	aes_to_tx_top #(
		  .BUFFER_SIZE(256),
		  .DATA_WIDTH(8)
		  ) u_uart_tx (
        .clk(clk),
        .reset(reset_n),
        .start(uart_tx_start),
        .ciphertext(cipher_latched),
        .tx(tx),
        .done(tx_done)
    );

    AES_CTR_pipelined u_aes_ctr (
        .clk(clk),
        .reset(reset_n),
        .enable(aes_enable),
        .key(KEY),
        .nonce(NONCE),
        .plaintext(data_out_rx_128_latched),
        .ciphertext(aes_ciphertext),
        .valid_out(aes_done)
    );
endmodule
