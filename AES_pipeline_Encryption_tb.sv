`timescale 1ns/1ps

module AES_pipeline_Encryption_tb;

  // Clock & reset
  logic clk;
  logic reset;

  // DUT inputs/outputs
  logic [127:0] plaintext;
  logic [127:0] key;
  logic [127:0] cypher;

  // Instantiate DUT
  AES_pipeline_Encryption dut (
      .clk(clk),
      .reset(reset),
      .plaintext(plaintext),
      .key(key),
      .cypher(cypher)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;   // 100 MHz clock (10 ns period)
  end

  // Stimulus
  initial begin
    // --- Initial conditions ---
    reset = 1;
    plaintext = 128'h00000000000000000000000000000001;
    key = 128'h0f1571c947d9e8590cb7add6af7f6798;

    // --- Release reset ---
    #20 reset = 0;

    // --- Feed plaintext continuously every clock ---
    repeat (20) begin
      @(posedge clk);
      plaintext <= plaintext + 128'h1; // thay bằng dữ liệu thật nếu muốn
    end

    // --- Giữ thêm vài chu kỳ để pipeline xả hết dữ liệu ---
    repeat (15) @(posedge clk);

    $finish;
  end

  // --- Monitor kết quả ---
  integer cycle = 0;
  always @(posedge clk) begin
    if (reset)
      cycle <= 0;
    else
      cycle <= cycle + 1;

    $display("Time=%0t | Cycle=%0d | Plaintext=%032h | Cypher=%032h",
              $time, cycle, plaintext, cypher);
  end

endmodule
