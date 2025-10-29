`timescale 1ns/1ps
module tb_AES_top_Encryption;

  logic clk, reset;
  logic [127:0] plaintext;
  logic [127:0] key;
  logic [127:0] cypher;

  // === Instantiate DUT ===
  AES_pipeline_Encryption dut (
      .clk(clk),
      .reset(reset),
      .plaintext(plaintext),
      .key(key),
      .cypher(cypher)
  );

  // === Clock generation ===
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 100 MHz
  end

  // === Stimulus ===
  integer i;

  initial begin
    $display("# Time\tCycle\tPlaintext_in\t\t\t\t\tCypher_out");
    $display("--------------------------------------------------------------------------");

    reset = 1;
    plaintext = 128'h0;
    key = 128'h2b7e151628aed2a6abf7158809cf4f3c; // AES NIST example key
    #20;
    reset = 0;

    // Feed 16 plaintext blocks (giống counter tăng dần trong CTR)
    for (i = 0; i < 16; i++) begin
      plaintext = i;
      @(posedge clk);
      $display("%0t\t%d\t%032h\t%032h", $time, i, plaintext, cypher);
    end

    // Giữ thêm vài chu kỳ để lấy hết dữ liệu ra
    repeat (10) @(posedge clk);
    $display("=== Simulation Done ===");
    $finish;
  end

endmodule
