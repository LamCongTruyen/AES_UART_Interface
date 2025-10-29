`timescale 1ns/1ps

module KeyExp_tb;

  // =====================
  // DUT (Design Under Test)
  // =====================
  logic [127:0] key;
  logic [127:0] round [0:10];

  // Instantiate Key Expansion module
  KeyExp uut (
      .key(key),
      .round(round)
  );

  // =====================
  // Test sequence
  // =====================
  initial begin
    $display("==============================================");
    $display(" AES-128 Key Expansion Testbench (Static Mode)");
    $display("==============================================");

    // Example key: 128-bit (FIPS-197 example)
    key = 128'h2b7e151628aed2a6abf7158809cf4f3c;

    // Wait some time for combinational logic to settle
    #10;

    $display("Input Key = %h\n", key);

    // Print all 11 round keys
    $display("Round | Key (128-bit)");
    $display("------|------------------------------------------------------");
    for (int i = 0; i < 11; i++) begin
      $display("  %0d   | %h", i, round[i]);
    end

    $display("\n=== Simulation Done ===");
    $finish;
  end

endmodule
