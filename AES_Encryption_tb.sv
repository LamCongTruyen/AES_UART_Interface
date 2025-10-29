`timescale 1ns/1ps

module AES_Encryption_tb;

  // ==== Testbench signals ====
  logic clk;
  logic reset;
  logic enable;
  logic [127:0] plaintext;
  logic [127:0] key;
  logic [127:0] cypher;

  // ==== DUT ====
  AES_Encryption dut (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .plaintext(plaintext),
    .key(key),
    .cypher(cypher)
  );

  // ==== Clock generator ====
  initial clk = 0;
  always #5 clk = ~clk;   // 100MHz clock (10ns period)

  // ==== Stimulus ====
  initial begin
    // Khởi tạo
    reset      = 1;
    enable     = 0;
    plaintext  = 128'h0;
    key        = 128'h0;

    // Reset giữ 2 chu kỳ
    #20;
    reset = 0;

    // Nạp dữ liệu test
    plaintext = 128'h00112233445566778899aabbccddeeff;
    key       = 128'h000102030405060708090a0b0c0d0e0f;

    // Kích hoạt enable cho Key Expansion
    enable = 1;
	 @(posedge clk)
	 enable = 0;

    // Chờ quá trình chạy
    #2000;  // delay dài cho đủ rounds chạy

    // In kết quả
    $display("=====================================");
    $display("Plaintext = %h", plaintext);
    $display("Key       = %h", key);
    $display("Cipher    = %h", cypher);
    $display("=====================================");

    $stop;
  end

endmodule
