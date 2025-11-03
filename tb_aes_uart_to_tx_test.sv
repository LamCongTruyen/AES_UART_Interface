`timescale 1ns/1ps


    // ==============================
    //module testbench cho chương trình lấy cipher từ AES truyền qua UART_TX. TOPMODULE CỦA NÓ LÀ: aes_uart_to_tx_test
    // ==============================
	 
	
module tb_aes_uart_to_tx_test;

    localparam BIT_PERIOD = 8680;

    logic clk;
    logic reset;
    logic key1;
    logic  tx;
	 logic  rx;
	 logic valid;
	 logic [7:0] data_out;
	 logic [127:0] cipher_latched;

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    aes_uart_to_tx_test DUT (
        .clk(clk),
        .reset(reset),
        .key1(key1),
		  .rx(rx),
        .tx(tx)
    );
    uart_rx uut (
        .clk(clk),
        .rst_n(reset),
        .rx(tx),
        .data_out(data_out),
        .valid(valid)
    );
	 
	 task send_uart_byte(input [7:0] data);
        int i;
        begin
				rx = 1'b1;
            #(BIT_PERIOD)

            rx = 1'b0;
            #(BIT_PERIOD);

            for (i = 0; i < 8; i++) begin
                rx = data[i];
                #(BIT_PERIOD);
            end

            rx = 1'b1;
            #(BIT_PERIOD);
        end
    endtask

    initial begin
        $display("=== BẮT ĐẦU MÔ PHỎNG AES_UART_TO_TX ===");
        reset = 1'b0;
        key1  = 1'b1;
        #100;
        reset = 1'b1;    // Thả reset
        #100;
		  
		  $display("[%0t ns] Gửi 16 byte vào UART RX...", $time);
        for (int b = 0; b < 128; b++) begin
            send_uart_byte(b);
        end
		  /*
        for (int i = 0; i < 5; i++) begin
            $display("\n[TB] --- Chu kỳ %0d ---", i);
            key1 = 1'b0;   // Nhấn nút (active low)
            #40;           // giữ 40ns
            key1 = 1'b1;   // Nhả nút

            // Chờ AES hoàn tất và UART truyền xong
            wait (DUT.aes_done == 1);
            #10;
            $display("[TB] AES hoàn tất! Ciphertext = %h", DUT.aes_ciphertext);

            wait (DUT.tx_done == 1);
            #10;
            $display("[TB] UART truyền xong frame %0d", i);

            #500; // Nghỉ 500ns giữa các lần nhấn
        end
*/      
		  cipher_latched = DUT.cipher_latched;
        $display("\n=== KẾT THÚC MÔ PHỎNG ===");
        #200;
        $finish;
    end

    initial begin
        $monitor("[%0t] state=%0d | aes_done=%b | tx_done=%b | tx=%b", 
                  $time, DUT.state, DUT.aes_done, DUT.tx_done, tx);
    end

endmodule
