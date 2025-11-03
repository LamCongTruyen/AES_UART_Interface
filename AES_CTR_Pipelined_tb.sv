`timescale 1ns/1ps

module AES_CTR_Pipelined_tb;
	 localparam CLK_FREQ  = 50000000;
    localparam BAUD_RATE = 115200;
    localparam CLK_PERIOD = 20; 
	 localparam [127:0] PLAINTEXT = 128'h0102030405060708090a0b0c0d0e0f10; 
	 localparam [127:0] KEY= 128'h0f1571c947d9e8590cb7add6af7f6798;
	 localparam [127:0] NONCE = 128'h00000000000000000000000000000001;
    // -------------------------
    // Thông số clock
    // -------------------------
    logic clk;
    logic reset;
    logic enable;

    // -------------------------
    // Dữ liệu vào/ra
    // -------------------------
    logic [127:0] key;
    logic [127:0] nonce;
    logic [127:0] plaintext;
    logic [127:0] ciphertext;
   // logic [127:0] counter_debug;
    logic         valid_out;

    // -------------------------
    // Clock 10ns (100 MHz)
    // -------------------------
    initial clk = 0;
    always #10 clk = ~clk;

    // -------------------------
    // DUT
    // -------------------------
    AES_CTR_pipelined uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .key(KEY),
        .nonce(NONCE),
        .plaintext(PLAINTEXT),
        .ciphertext(ciphertext),
        .valid_out(valid_out)
        //.counter_debug(counter_debug)
    );
 
    // -------------------------
    // Test stimulus
    // -------------------------
    initial begin
        $display("==== AES CTR PIPELINE TEST ====");
        $dumpfile("aes_ctr_pipeline.vcd");
        $dumpvars(0, AES_CTR_Pipelined_tb);
		  // Reset phase
        
        enable = 0;
        plaintext = 128'h0;
		  reset = 0;
        //key = 128'h0f1571c947d9e8590cb7add6af7f6798;
        //nonce = 128'h00000000000000000000000000000001;
        repeat (5) @(posedge clk);
        reset = 1;
        #10;
		  
		  for (int i = 0; i < 20; i++) begin
            $display("\n[TB] --- Chu kỳ %0d ---", i);
            enable = 1'b1;   // Nhấn nút (active low)
            repeat (1) @(posedge clk);          // giữ 40ns
            enable = 1'b0;   // Nhả nút

            // Chờ AES hoàn tất và UART truyền xong
            repeat (5) @(posedge clk);
            //#10;
				wait (uut.valid_out == 1);
            $display("[TB] AES hoàn tất! Ciphertext = %h", ciphertext);

            //wait (DUT.tx_done == 1);
            //#10;
            //$display("[TB] UART truyền xong frame %0d", i);

            //#500; // Nghỉ 500ns giữa các lần nhấn
        end
		  
        // -------------------------
        // Test: gửi từng block một
        // -------------------------

		  /*
        for (int i = 0; i < 20; i++) begin
            // Nạp 1 plaintext
            plaintext = 128'h0102030405060708090a0b0c0d0e0f10  + i;
            //plaintext = 128'h00102030405060708090a0b0c0d0e0f1 + i;
            // Bật enable trong 1 chu kỳ
            enable = 1;
            @(posedge clk);
            enable = 0;

            // Chờ 20 chu kỳ để pipeline xử lý
            repeat (5) @(posedge clk);
				
				
        end
		  */
//
        $display("==== TEST DONE ====");
			/*	
        // Reset
        reset = 1;
        enable = 0;
        plaintext = 128'h0;
		  nonce = 128'h00000000000000000000000000000001;
		  key =  128'h0f1571c947d9e8590cb7add6af7f6798;
        #100;
        reset = 0;
		  #(CLK_PERIOD);
		  @(posedge clk);
        // Bắt đầu mã hóa liên tục
        enable = 1;
		  /*
        for (int i = 0; i < 20; i++) begin
            plaintext = 128'h11111111111111111111111111111111 + i;
            @(posedge clk);
        end
		  //
		  #(CLK_PERIOD);
		  @(posedge clk);
		  plaintext = 128'h00112233445566778899AABBCCDDEEFF;
        // Dừng luồng dữ liệu
        enable = 0;
		  
		  wait(valid_out);
        repeat (14) @(posedge clk);
		  $display("[%0t] AES done, plaintext=%032h", $time, uut.plaintext);
		  $display("[%0t] AES done, ciphertext=%032h", $time, uut.ciphertext);
		  $display("[%0t] AES da hoan thanh ma hoa!!!!!!!!!!!!!!", $time);
		  
		  
		  enable = 1;
		  #(CLK_PERIOD);
		  @(posedge clk);
		  plaintext = 128'hD30216C83D902E5090291C9D378FFC08; 
		  enable = 0;
		  wait(valid_out);
		  $display("[%0t] AES done, plaintext=%032h", $time, uut.plaintext);
		  $display("[%0t] AES done, ciphertext=%032h", $time, uut.ciphertext);
		  repeat (14) @(posedge clk);
		  $display("[%0t] AES da hoan thanh ma hoa!!!!!!!!!!!!!!", $time);
		  */

        $stop;
    end
/*
    always @(posedge clk) begin
        $display("[%0t] enable=%0b valid_out=%0b plaintext=%032h ciphertext=%032h",
                  $time, enable, valid_out, plaintext, ciphertext);
    end
*/
endmodule
