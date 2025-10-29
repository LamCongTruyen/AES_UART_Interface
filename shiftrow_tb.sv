`timescale 1ns / 1ps

module shiftrow_tb;

  logic [127:0] in;
  logic [127:0] out ;
  shiftrow dut (
    .in(in),
    .out(out));

  initial begin
     in = 128'hed12194c1a6fdc418467e22a97005b7a;
    #10; 
	 $display("BeforeShiftround = %h", in);
    $display("AfterShiftround = %h", out);
  end


endmodule