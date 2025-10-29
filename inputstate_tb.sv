`timescale 1ns / 1ps

module inputstate_tb;

  logic [127:0] plaintext;
  logic [7:0] s [0:15];  // Mảng 16 phần tử 8-bit

  // Gọi module inputstate (DUT - Device Under Test)
  inputstate dut (
    .plaintext(plaintext),
    .s(s)
  ); 

  initial begin
    // In tiêu đề

    // Test case 1
    plaintext = 128'h0123456789abcdeffedcba9876543210;

    #100; // Cho mô phỏng chạy thêm
  end
endmodule