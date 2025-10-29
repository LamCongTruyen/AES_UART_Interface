`timescale 1ns / 1ps

module initial_transform_tb;

  logic [127:0] text;
  logic [127:0] key;
  logic [127:0] out1;

  initial_transform dut (
    .text(text),
    .key(key),
    .out1(out1)
  );
initial begin
  text = 128'h9faf634b37ec39fb518c04b137fa66d7;
  key  = 128'hcc96ed1674eaaa031e863f24b2a8316a;
  #1; // cho DUT xử lý
  $display("text  = %h", text);
  $display("key   = %h", key);
  $display("out1  = %h", out1);
  #10;
  $finish;
end
endmodule