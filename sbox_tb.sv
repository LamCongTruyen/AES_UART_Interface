
`timescale 1ns / 1ps

module sbox_tb;

  // Dùng logic thay cho reg và wire
  logic [7:0] data;
  logic [7:0] sbox_out;

  // Gọi module sbox (DUT - Device Under Test)
  sbox dut (
    .a(data),
    .c(sbox_out)
  ); 

  initial begin

    data = 8'h5c; 
    #5;
    data = 8'h7b;
    #100;

    data = 8'hb4;
    #15;

    data = 8'h9a;
    #20;

	 data = 8'h6b; 
    #25;
    data = 8'h72;
    #30;

    data = 8'h12;
    #35;

    data = 8'h94;
    #40;
  end

endmodule