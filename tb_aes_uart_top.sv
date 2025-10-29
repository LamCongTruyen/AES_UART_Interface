`timescale 1ns/1ps

module tb_aes_uart_top;

    // -----------------------------
    // Thông số UART
    // -----------------------------
    localparam CLK_FREQ   = 50000000;    // 50 MHz
    localparam BAUD_RATE  = 115200;
    //localparam BIT_PERIOD = 1000000000 / BAUD_RATE; // ns
	 localparam BIT_PERIOD = 8680;
    // -----------------------------
    // Tín hiệu mô phỏng
    // -----------------------------
    logic clk;
    logic rst_n;
    logic rx;
    //logic [127:0] key;
    //logic [127:0] nonce;
    logic [127:0] ciphertextout;
    logic aes_valid_out;
    //logic buffer_full, buffer_empty;
	 logic TX_valid_out;
	 logic tx;
    // -----------------------------
    // Clock 50 MHz
    // -----------------------------
    always #10 clk = ~clk; // 20ns period → 50MHz

    // -----------------------------
    // Gọi DUT
    // -----------------------------
    aes_uart_top dut (
        .clk          (clk),
        .rst_n        (rst_n),
        .rx           (rx),
        //.key          (key),
        //.nonce        (nonce),
        .ciphertextout   (ciphertextout),
        .aes_valid_out(aes_valid_out),
		  .TX_valid_out(TX_valid_out),
		  .tx(tx)
    );

    // -----------------------------
    // Task gửi 1 byte qua UART RX
    // -----------------------------
    task send_uart_byte(input [7:0] data);
        int i;
        begin
				rx = 1'b1;
            #(BIT_PERIOD)
            // start bit
            rx = 1'b0;
            #(BIT_PERIOD);

            // 8 bit data (LSB first)
            for (i = 0; i < 8; i++) begin
                rx = data[i];
                #(BIT_PERIOD);
            end

            // stop bit
            rx = 1'b1;
            #(BIT_PERIOD);
        end
    endtask
	byte plaintext[0:31];
    // -----------------------------
    // Main test sequence
    // -----------------------------
    initial begin
        $display("\n=== BẮT ĐẦU MÔ PHỎNG AES_UART_TOP ===");
		  
        clk = 0;
        rx  = 1'b1;
        rst_n = 0;
        //key   = 128'h0f1571c947d9e8590cb7add6af7f6798;
        //nonce = 128'h00000000000000000000000000000001;
			plaintext = '{
				  8'h00, 8'h11, 8'h22, 8'h33,
				  8'h44, 8'h55, 8'h66, 8'h77,
				  8'h88, 8'h99, 8'haa, 8'hbb,
				  8'hcc, 8'hdd, 8'hee, 8'hff,
				  8'h00, 8'h11, 8'h22, 8'h33,
				  8'h44, 8'h55, 8'h66, 8'h77,
				  8'h88, 8'h99, 8'haa, 8'hbb,
				  8'hcc, 8'hdd, 8'hee, 8'h01
			 };
        // Reset
        repeat(5) @(posedge clk);
        rst_n = 1;
        $display("[%0t ns] Hệ thống khởi động xong", $time);

        // -----------------------------
        // Gửi 16 byte (0x00 → 0x0F)
        // -----------------------------
        $display("[%0t ns] Gửi 16 byte vào UART RX...", $time);
        for (int b = 0; b < 33; b++) begin
            send_uart_byte(plaintext[b]);
        end
		  /*
			wait (dut.u_uart_tx.done);
			$display("[%0t ns] AES CTR mã hóa xong, plaintext = %h", $time, ciphertextout);
			$display("[%0t ns] AES CTR mã hóa xong, plaintext = %h", $time, dut.u_uart_tx.ciphertext);
        // -----------------------------
        // Theo dõi AES output
        // -----------------------------
		  */
        //wait (aes_valid_out);
        $display("[%0t ns] AES CTR mã hóa xong, ciphertext = %h", $time, ciphertextout);

        #10000000;
        $stop;
    end
	 always_ff @(posedge clk) begin
			if(dut.u_uart_tx.start) begin
					$display("[%0t ns] UART_TX truyen xong, ciphertext = %h", $time, dut.u_uart_tx.ciphertext);
			end
			if(dut.u_aes_ctr.valid_out) begin
					$display("[%0t ns] AES CTR ma hoa xong, ciphertext = %h", $time, dut.u_aes_ctr.ciphertext);
			end
	 end

endmodule
