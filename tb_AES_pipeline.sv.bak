`timescale 1ns/1ps

module tb_AES_pipeline;

  // ===== Clock & Reset =====
  logic clk;
  logic reset;

  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 100 MHz clock
  end

  initial begin
    reset = 1;
    #20 reset = 0;
  end

  // ===== DUT I/O =====
  logic [127:0] plaintext;
  logic [127:0] cypher;
  logic [1407:0] all_keys;  // 11 round keys (key0..key10)

  // ===== Instantiate DUT =====
  AES_pipeline dut (
      .clk(clk),
      .plaintext(plaintext),
      .all_keys(all_keys),
      .cypher(cypher)
  );

  // ===== Test vectors =====
  logic [127:0] plaintext_mem [0:15];  // 16 plaintext blocks
  integer i;

  initial begin
    // --- Example plaintexts (incrementing for easy tracking)
    for (i = 0; i < 16; i++) begin
      plaintext_mem[i] = 128'h00000000000000000000000000000000 + i;
    end

    // --- Dummy round keys (for testing pipeline only) ---
    // => khi bạn có module KeyExpansion thì thay bằng round keys thật
    for (i = 0; i < 11; i++) begin
      all_keys[1407 - i*128 -: 128] = 128'h2b7e151628aed2a6abf7158809cf4f3c + i;
    end
  end

  // ===== Send plaintext stream =====
  initial begin
    @(negedge reset);
    $display("# Time\tCycle\tPlaintext_in\t\t\tCypher_out");

    for (i = 0; i < 16; i++) begin
      plaintext = plaintext_mem[i];
      @(posedge clk);
      $display("%0t\t%0d\t%032h\t%032h", $time, i, plaintext, cypher);
    end

    // Sau khi nạp xong 16 block, tiếp tục 10 chu kỳ để flush pipeline
    for (i = 0; i < 10; i++) begin
      plaintext = 128'hxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      @(posedge clk);
      $display("%0t\t%0d\t%032h\t%032h", $time, 16+i, plaintext, cypher);
    end

    #50;
    $display("=== Simulation Done ===");
    $finish;
  end

endmodule
