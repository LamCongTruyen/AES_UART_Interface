`timescale 1ns/1ps

module AES1_tb;

  // Tín hiệu test
  logic clk;
  logic [127:0] plaintext;
  logic [127:0] key;
  logic [127:0] cypher;

  // Khởi tạo AES1
  AES1 uut (
      .clk(clk),
      .plaintext(plaintext),
      .key(key),
      .cypher(cypher)
  );

  // Tạo clock 10ns
  initial clk = 0;
  always #5 clk = ~clk;

  // Test vector
  initial begin
    $display("=== AES1 Single-Round Test ===");
plaintext = 128'h0E3634AECE7225B6F26B174ED92B5588;
    key = 128'hDC9037B09B49DFE997FE723F388115A7;

    // Bắt đầu mô phỏng
    $monitor("Time=%0t | Plaintext=%h | Key=%h | Cypher=%h",
             $time, plaintext, key, cypher);

    // Chờ vài chu kỳ
    #100;
    $display("=== Simulation End ===");
    $stop;
  end

endmodule

	 
