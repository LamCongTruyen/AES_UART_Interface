`timescale 1ns/1ps

module tb_AES_CTR_pipeline_Handshake;

    logic clk;
    logic reset;

    // Handshake signals
    logic valid_in;
    logic ready_in;

    // AES input
    logic [127:0] key;
    logic [127:0] nonce;
    logic [127:0] plaintext;

    // AES output
    logic valid_out;
    logic [127:0] ciphertext;

    // ==============================
    // DUT
    // ==============================
    AES_CTR_pipeline_Handshake uut (
        .clk(clk),
        .reset(reset),
        .valid_in(valid_in),
        .ready_in(ready_in),
        .key(key),
        .nonce(nonce),
        .plaintext(plaintext),
        .valid_out(valid_out),
        .ciphertext(ciphertext)
    );

    // ==============================
    // Clock generation
    // ==============================
    initial clk = 0;
    always #5 clk = ~clk;   // 100 MHz clock

    // ==============================
    // Ready logic (giả lập)
    // ==============================
    initial begin
        ready_in = 1;   // luôn sẵn sàng nhận
    end

    // ==============================
    // Test sequence
    // ==============================
    initial begin
        // Init
        reset = 1;
        valid_in = 0;
        plaintext = 0;
        key = 128'h0f1571c947d9e8590cb7add6af7f6798;
        nonce = 128'h00000000000000000000000000000001;
        #20;
        reset = 0;

        // --- Chuỗi 1 ---
        @(posedge clk);
        valid_in <= 1;
        plaintext <= 128'h00112233445566778899AABBCCDDEEFF;

        @(posedge clk);
        plaintext <= 128'h0102030405060708090A0B0C0D0E0F10;

        // --- Ngưng 3 chu kỳ ---
        @(posedge clk);
        valid_in <= 0;
        plaintext <= 128'h0;
        repeat (3) @(posedge clk);

        // --- Chuỗi 2 (tiếp theo sau 3 chu kỳ) ---
        @(posedge clk);
        valid_in <= 1;
        plaintext <= 128'hA1A2A3A4A5A6A7A8A9AAABACADAEAFB0;

        @(posedge clk);
        valid_in <= 0;

        // --- Kết thúc ---
        repeat (30) @(posedge clk);
        $finish;
    end

    // ==============================
    // Monitor
    // ==============================
    initial begin
        $display("Time\tvalid_in\tready_in\tvalid_out\tplaintext\t\t\t\tciphertext");
        $monitor("%0t\t%b\t\t%b\t\t%b\t\t%h\t%h",
                 $time, valid_in, ready_in, valid_out, plaintext, ciphertext);
    end

endmodule
