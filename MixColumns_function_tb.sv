`timescale 1ns / 1ps

module MixColumns_function_tb;
  logic [127:0] data;
  logic [127:0] dataout;

  MixColumns_function dut (
    .in(data),
    .dataout(dataout)
  );

  initial begin
    data = 128'hed6fe27a1a675b4c840019419712dc2a;

    #200;
	 $display("BeforeMix = %h", data);
    $display("AfterMix = %h", dataout);

  end

endmodule
