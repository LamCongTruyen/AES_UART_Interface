`timescale 1ns/1ps

module top_aes_pipeline_tb;

  // Tín hiệu clock và reset
  logic clk;
  logic rs;

  // Output
  logic [127:0] cypher_out;

  // Instantiate DUT (Device Under Test)
  top_aes_pipeline dut (
      .clk(clk),
      .rs(rs),
      .cypher_out(cypher_out)
  );

  // Tạo xung clock 10ns (100 MHz)
  initial clk = 0;
  always #5 clk = ~clk;

  // Reset logic
  initial begin
    rs = 1;
    #20;
    rs = 0;
  end

  // Giám sát kết quả
  initial begin
    $display("=== AES Pipeline Encryption Test ===");
    $monitor("Time=%0t | Reset=%b | Cypher_out=%h", $time, rs, cypher_out);
  end

  // Kết thúc mô phỏng sau 2000ns
  initial begin
    #2000;
    $display("=== Simulation finished ===");
    $stop;
  end

endmodule
