

    // ==============================
    //testbench này giả lập module UART-RX nhận dữ liệu từ chân rx rồi xuất ra dataout 128bit(plaintext cấp cho AES)
	 //chương trình chính của nó là: uart_rx_top
    // ==============================

	 
 
`timescale 1ns/1ps

module tb_uart_rx_top;

    localparam CLK_FREQ   = 50000000;      
    localparam BAUD_RATE  = 115200;         
    localparam BIT_PERIOD = 8680;
	 //localparam [127:0] PLAINTEXT = 128'h00112233445566778899aabbccddeeff; 
	 localparam [127:0] KEY= 128'h0f1571c947d9e8590cb7add6af7f6798;
	 localparam [127:0] NONCE = 128'h00000000000000000000000000000001;

    logic clk;
    logic rst_n;
    logic rx;
    logic enable;

    logic [127:0] data_out_128;
	 logic [127:0] latch_data_out_128;
	 logic [127:0] aes_ciphertext;
	 logic aes_done;
    logic data_valid;
	 byte plaintext[0:31];
	 integer k;
	 
    uart_rx_top dut (
        .clk(clk),
        .rst_n(rst_n),
        .rx(rx),
        //.enable(enable),
        .data_out_128(data_out_128),
        .data_valid(data_valid)
    );
	  
	 AES_CTR_pipelined u_aes_ctr (
        .clk(clk),
        .reset(rst_n),
        .enable(data_valid),
        .key(KEY),
        .nonce(NONCE),
        .plaintext(latch_data_out_128),
        .ciphertext(aes_ciphertext),
        .valid_out(aes_done)
    );
	 
    initial clk = 0;
    always #10 clk = ~clk; 
	 always @(posedge clk) begin
			if(rst_n) begin
				latch_data_out_128 <= 128'd0;
			end else if(data_valid) begin
			   latch_data_out_128 <= data_out_128;
			end
	 end

    task send_uart_byte(input [7:0] data);
        integer i;
        begin

            rx = 0;
            #(BIT_PERIOD);

            for (i = 0; i < 8; i = i + 1) begin
                rx = data[i];
                #(BIT_PERIOD);
            end

            rx = 1;
            #(BIT_PERIOD);
        end
    endtask
   
    initial begin
        rx      = 1;
        rst_n   = 0;
        enable  = 0;

        #(200);
        $display("[%0t ns] Bắt đầu gửi UART...", $time);
	/*		
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
			 */
			 
        repeat(5) @(posedge clk);
        rst_n = 1;
        $display("[%0t ns] Hệ thống khởi động xong", $time);

        $display("[%0t ns] Gửi 16 byte vào UART RX...", $time);
        for (int b = 1; b < 66; b++) begin
            send_uart_byte(b);
        end
		  
        /* Gửi 32 byte (2 khối 128-bit)
        for (int i = 0; i < 16; i= i + 1) begin
            send_uart_byte(i);  // gửi dữ liệu mẫu: 00,01,02,...,0F
        end
*/
        $display("[%0t ns] Đã gửi xong 32 byte UART.", $time);

        //#(BIT_PERIOD * 20);

        enable = 1;
        #(500);
        enable = 0;
/*
        #(5000);
        enable = 1;
        @(posedge clk);
        enable = 0;
			#(5000);
        enable = 1;
        @(posedge clk);
        enable = 0;
		  #(5000);
        enable = 1;
        @(posedge clk);
        enable = 0;
		  #(5000);
        enable = 1;
        @(posedge clk);
        enable = 0;
		  #(5000);
        enable = 1;
        @(posedge clk);
        enable = 0;
		  */
        #(10000000);
        $stop;
    end

    always @(posedge clk) begin
        if (data_valid)
            $display("[%0t ns] ✅ DATA 128-bit = %032h", $time, data_out_128);
    end

endmodule
