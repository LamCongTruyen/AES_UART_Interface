`timescale 1ns / 1ps

module keyExpansion_tb;

    parameter nk = 4;
    parameter nr = 10;

    reg clk;
    reg [(nk * 32) - 1:0] key;
    wire [(128 * (nr + 1)) - 1:0] w;

    KeyExp #(nk, nr) dut (
        .clk(clk),
        .key(key),
        .w(w)
    );

    always #5 clk = ~clk;

    integer j;

    initial begin
     
        clk = 0;
        key = 128'h0f1571c947d9e8590cb7add6af7f6798;  // Key máº«u chuáº©n

        #200;

        $display("Round Keys:");
        for (j = 0; j < 11; j = j + 1) begin
    $display("Round %0d: %h", j, w[((10 - j)*128) +: 128]);
end

    end

endmodule
