`timescale 1ns/1ps

module test1_tb;

  // Tín hiệu kết nối với DUT
  logic [7:0] in;
  logic [7:0] out;

  // Khởi tạo DUT
  test1 dut (
    .in(in),
    .out(out)
  );



  initial begin

    in = 8'hFC; #10;

    in = 8'hC6; #20;

    in = 8'h78; #30;

    in = 8'h73; #40;

  end

endmodule
