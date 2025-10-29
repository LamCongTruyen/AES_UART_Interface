`timescale 1ns / 1ps

module tb_aes_uart_tx; //testbench của module : aes_uart_tx_top

    localparam CLK_FREQ  = 50000000;
    localparam BAUD_RATE = 115200;
    localparam CLK_PERIOD = 20; 
	 localparam BAUD_DIV   = 434;          // 50M / 115200 ≈ 434
    localparam TICK_DIV   = 27;           // 16x oversampling
    localparam BIT_TIME   = BAUD_DIV * TICK_DIV * CLK_PERIOD; // ~8680 ns
	 
	 
	 
    logic clk;
    logic reset;
	 logic [127:0] key;
	 logic [127:0] nonce;
    logic aes_enable;
	 logic [127:0] plaintext;
    logic [127:0] outputplaintext;
	 logic [127:0] outputciphertext;
	 logic dataaes_valid;
    logic tx;
	 logic rx;
    logic done;
	 
	 logic [127:0] test_plaintext = 128'h00112233445566778899AABBCCDDEEFF;
	 
    aes_uart_tx_top #(
        .CLK_FREQ(CLK_FREQ),
        .BAUD_RATE(BAUD_RATE)
    ) dut (
        .clk(clk),
        .reset(reset),
		  .rx(rx),
		  .key(key),
		  .nonce(nonce),
		  .plaintext(plaintext),
        .aes_enable(aes_enable),
        .outputplaintext(outputplaintext),
		  .outputciphertext(outputciphertext),
		  .dataaes_valid(dataaes_valid),
        .tx(tx),
        .done(done)
    );
 
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end
	
	 task send_uart_byte(input [7:0] data);
        integer i;
        begin
            rx = 1'b0;
            #(BIT_TIME);

            for (i = 0; i < 8; i++) begin
                rx = data[i];
                #(BIT_TIME);
            end

            rx = 1'b1;
            #(BIT_TIME);
        end
    endtask

    // ========================================
    // Task: Gửi toàn bộ 16 byte plaintext
    // ========================================
    task send_plaintext();
        integer i;
        begin
            $display("\n=== GUI  16 BYTE QUA UART RX ===");
            for (i = 0; i < 16; i++) begin
                send_uart_byte(test_plaintext[127 - i*8 -: 8]);
                $display("  gui byte %0d: %02h", i, test_plaintext[127 - i*8 -: 8]);
            end
        end
    endtask
	
    initial begin
		  clk =0;
		  rx = 1;
		  aes_enable = 0;
		  plaintext = 128'h0;
		  nonce = 128'h00000000000000000000000000000001;
		  key =  128'h0f1571c947d9e8590cb7add6af7f6798;
		  reset = 1; 
		  #100;
		  reset = 0;
		  aes_enable  = 1;
		  plaintext = 128'h00112233445566778899AABBCCDDEEFF;

		  @(posedge clk);
		  aes_enable  = 0;
		  
		  //send_plaintext();

        $display("[%0t] bat dau ma hoa va truyen UART...", $time);
		 
		  wait(dut.aes_enable);
		  $display("[%0t] AES done, plaintext=%032h", $time, dut.aes_core.plaintext);
		  wait(dut.dataaes_valid);
		  $display("[%0t] AES done, ciphertext=%032h", $time, dut.aes_core.ciphertext);
		  
		  wait(dut.done);
//////////////////////////////////////////////////////////////////////////////////////////		
  /*
		  //plaintext = 128'hD30216C83D902E5090291C9D378FFC08;
		  $display("[%0t] plaintext 1 dua vao ma hoa : =%032h", $time, dut.aes_core.plaintext);
		  @(posedge clk);
        aes_enable = 1;
		  
		  //Sau khi cấp plaintext thì dễ lỗi nhất là thời gian đợi sau khi enable được kích lên 1.chú ý khúc này
		  #(CLK_PERIOD);
		  //#200;
		  @(posedge clk);
		  plaintext = 128'h00112233445566778899AABBCCDDEEFF;
		  //repeat (2)@(posedge clk);
		  
        aes_enable = 0;
	  
		  wait(dut.aes_core.valid_out);
		  $display("[%0t] AES done, plaintext=%032h", $time, dut.aes_core.plaintext);
		  $display("[%0t] AES done, ciphertext=%032h", $time, dut.aes_core.ciphertext);
		  wait(dut.done);
		  $display("[%0t] top level da hoan thanh ma hoa + truyen ra TX", $time);
		  //repeat (20) @(posedge clk);
	*/		  
		  /*
		  wait(dut.aes_core.valid_out);
		  $display("[%0t] AES valid_out, ciphertext 1 AES xuat du lieu ra : =%032h", $time, dut.aes_core.ciphertext);
		  
		  //repeat (12) @(posedge clk);
		  wait(dut.aes_to_tx_inst.ciphertext);
		  $display("[%0t] module UART-TX nhan cipher: =%032h!", $time, dut.aes_to_tx_inst.ciphertext);
		  
		  wait(dut.aes_to_tx_inst.done);
		  $display("[%0t] module UART-TX da truyen du lieu xong!", $time);
		  
		  wait(dut.done);
		  $display("[%0t] top level da hoan thanh ma hoa + truyen ra TX", $time);
		  */
		  
//////////////////////////////////////////////////////////////////////////////////////////
		  /* 
		  @(posedge clk);
		  aes_enable = 1;
		  plaintext = 128'hd30216c83d902e5090291c9d378ffc08;
		  #(CLK_PERIOD);
		  @(posedge clk);
        aes_enable = 0; 
		  
		  wait(dut.aes_core.valid_out);
		  $display("[%0t] AES done, plaintext=%032h", $time, dut.aes_core.plaintext);
		  $display("[%0t] AES done, ciphertext=%032h", $time, dut.aes_core.ciphertext);
        wait(dut.aes_to_tx_inst.done); 
		  $display("[%0t] module UART-TX đã truyền dữ liệu 128bit xong!", $time);
		  wait(dut.done);
		  $display("[%0t] top level da hoan thanh ma hoa + truyen ra TX", $time);
		 */
//////////////////////////////////////////////////////////////////////////////////////////  
		/*
		  plaintext = 128'h00112233445566778899aabbccddeeff;
		  $display("[%0t] plaintext 3 dua vao ma hoa : =%032h", $time, dut.aes_core.plaintext);
		  @(posedge clk);
		  aes_enable = 1;
		  
		  #100;
		  @(posedge clk);
        aes_enable = 0;
        wait(dut.aes_core.valid_out);
		  $display("[%0t] AES valid_out, ciphertext 3 AES xuat du lieu ra : =%032h", $time, dut.aes_core.ciphertext);
        wait(dut.aes_to_tx_inst.done); 
		  $display("[%0t] module UART-TX đã truyền dữ liệu 128bit xong!", $time);
		  wait(dut.done);
		  $display("[%0t] top level da hoan thanh ma hoa + truyen ra TX", $time);
		  
//////////////////////////////////////////////////////////////////////////////////////////

		  plaintext = 128'hd30216c83d902e5090291c9d378ffc08;
		  $display("[%0t] plaintext 4 dua vao ma hoa : =%032h", $time, dut.aes_core.plaintext);
		  @(posedge clk);
		  aes_enable = 1;
		  #100;
		  
		  @(posedge clk); 
        aes_enable = 0;
		  wait(dut.aes_core.valid_out);
		  $display("[%0t] AES valid_out, ciphertext 3 AES xuat du lieu ra : =%032h", $time, dut.aes_core.ciphertext);
        wait(dut.aes_to_tx_inst.done); 
		  $display("[%0t] module UART-TX đã truyền dữ liệu 128bit xong!", $time);
		  wait(dut.done);
		  $display("[%0t] top level da hoan thanh ma hoa + truyen ra TX", $time);
		  */
//////////////////////////////////////////////////////////////////////////////////////////  
			//#5000;
		  $stop;
    end 
 //ngày mai kiểm tra lại điều kiện in out , điều kiện khi nào cho phép và hãy viết lại thời gian của từng thời điểm cho chính xác
	/*	always @(posedge clk) begin
		
		  if(dut.aes_core.enable) begin
				$display("[%0t] AES enable, enable=%0b, plaintext 1 dua lieu vao AES : =%032h", $time,dut.aes_core.enable, dut.aes_core.plaintext);
		  end
		  
		  if(dut.aes_to_tx_inst.ciphertext) begin
				$display("[%0t] module UART-TX nhan cipher: =%032h!", $time, dut.aes_to_tx_inst.ciphertext);
		  end
		 

		 if(dut.aes_core.valid_out) begin
				$display("[%0t] AES valid_out,valid_out=%0b, ciphertext 1 AES xuat du lieu ra : =%032h, plaintext luc nay la:=%032h", $time,dut.aes_core.valid_out, dut.aes_core.ciphertext, dut.aes_core.plaintext);
		 end
		  
		 if (dut.aes_to_tx_inst.uart_trigger)begin
				$display("[%0t] UART trigger -> gui byte %0d = 0x%02h", $time, dut.aes_to_tx_inst.byte_idx, dut.aes_to_tx_inst.uart_data_in);
		  end
	end
	*/
endmodule
