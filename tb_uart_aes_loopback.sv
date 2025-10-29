`timescale 1ns / 1ps

module tb_uart_aes_loopback;

    // =============================================================================
    // PARAMETERS
    // =============================================================================
    localparam CLK_PERIOD = 20;
    localparam BAUD_PERIOD = 8680;
    localparam NUM_BLOCKS = 5;

    // =============================================================================
    // DUT SIGNALS
    // =============================================================================
    reg         clk = 0;
    reg         rst_n = 0;
    reg         rx = 1;
    reg [127:0] key;
    reg [127:0] nonce;
    wire        tx;

    // =============================================================================
    // DUT INSTANCE
    // =============================================================================
    uart_aes_loopback dut (
        .clk(clk),
        .rst_n(rst_n),
        .rx(rx),
        .key(key),
        .nonce(nonce),
        .tx(tx)
    );

    // =============================================================================
    // CLOCK
    // =============================================================================
    always #(CLK_PERIOD/2) clk = ~clk;

    // =============================================================================
    // UART TASKS
    // =============================================================================
    task send_byte(input [7:0] data);
        integer i;
        begin
            rx = 0; #(BAUD_PERIOD);
            for (i = 0; i < 8; i = i + 1) begin
                rx = data[i];
                #(BAUD_PERIOD);
            end
            rx = 1; #(BAUD_PERIOD);
        end
    endtask

    task recv_byte(output [7:0] data);
        integer i;
        reg [7:0] bits;
        begin
            @(negedge tx);
            #(BAUD_PERIOD * 1.5);
            for (i = 0; i < 8; i = i + 1) begin
                #(BAUD_PERIOD);
                bits[i] = tx;
            end
            data = bits;
            #(BAUD_PERIOD);
        end
    endtask

    // =============================================================================
    // TEST DATA
    // =============================================================================
    reg [127:0] plaintext_blocks [0:NUM_BLOCKS-1];
    reg [127:0] expected_cipher_blocks [0:NUM_BLOCKS-1];
    reg [7:0]   received_bytes [0:NUM_BLOCKS*16-1];
    integer     byte_idx;

    initial begin
        integer i;
        for (i = 0; i < NUM_BLOCKS; i = i + 1) begin
            plaintext_blocks[i] = $random;
            expected_cipher_blocks[i] = plaintext_blocks[i] ^ (128'h0 + i);
        end
    end

    // =============================================================================
    // GỬI DỮ LIỆU
    // =============================================================================
    initial begin
        key = 128'h00112233_44556677_8899AABB_CCDDEEFF;
        nonce = 128'h12345678_90ABCDEF_FEDCBA09_87654321;

        #(CLK_PERIOD*10);
        rst_n = 1;
        #(CLK_PERIOD*10);

        $display("=== GỬI %0d BLOCK ===", NUM_BLOCKS);
        for (int blk = 0; blk < NUM_BLOCKS; blk = blk + 1) begin
            for (int b = 0; b < 16; b = b + 1) begin
                send_byte(plaintext_blocks[blk][127 - 8*b -: 8]);
            end
            #(BAUD_PERIOD * 5);
        end

        // Chờ TX gửi hết
        wait(byte_idx >= NUM_BLOCKS*16);
        #(BAUD_PERIOD * 100);

        check_results();
        $display("=== TEST HOÀN TẤT ===");
        $finish;
    end

    // =============================================================================
    // NHẬN DỮ LIỆU – ĐÃ SỬA LỖI LABEL
    // =============================================================================
    // =============================================================================
// NHẬN DỮ LIỆU – PHIÊN BẢN HOÀN HẢO
// =============================================================================
initial begin
    byte_idx = 0;
    while (byte_idx < NUM_BLOCKS*16) begin
        recv_byte(received_bytes[byte_idx]);
        byte_idx = byte_idx + 1;
    end
    check_results();
    $display("=== TEST HOÀN TẤT ===");
    $finish;
end

    // =============================================================================
    // KIỂM TRA KẾT QUẢ
    // =============================================================================
    task check_results();
        integer blk, b;
        reg [127:0] recv_block;
        begin
            $display("=== KIỂM TRA KẾT QUẢ ===");
            for (blk = 0; blk < NUM_BLOCKS; blk = blk + 1) begin
                recv_block = 0;
                for (b = 0; b < 16; b = b + 1) begin
                    recv_block = {recv_block[119:0], received_bytes[blk*16 + b]};
                end
                if (recv_block === expected_cipher_blocks[blk]) begin
                    $display("BLOCK %0d: PASS", blk);
                end else begin
                    $error("BLOCK %0d: SAI! Nhận=%h, Kỳ vọng=%h", blk, recv_block, expected_cipher_blocks[blk]);
                end
            end
        end
    endtask

endmodule