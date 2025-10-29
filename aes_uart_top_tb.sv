`timescale 1ns / 1ps

module aes_uart_top_tb;

    // Tham số
    localparam CLK_PERIOD = 10; // Chu kỳ xung nhịp 10ns (100 MHz)
    localparam BAUD_RATE = 115200;
    localparam BIT_PERIOD = 8681; // Thời gian 1 bit (≈ 1/115200 s)

    // Tín hiệu
    reg         clk;
    reg         rst_n;
    reg         rx;
    wire        tx;

    // Khởi tạo module DUT
    uart_string_loopback dut (
        .clk(clk),
        .rst_n(rst_n),
        .rx(rx),
        .tx(tx)
    );

    // Tạo xung nhịp
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    // Tác vụ gửi 1 byte qua UART RX
    task send_uart_byte;
        input [7:0] data_byte;
        begin
            rx = 0; // Bit bắt đầu
            #BIT_PERIOD;
            for (integer i = 0; i < 8; i++) begin
                rx = data_byte[i];
                #BIT_PERIOD;
            end
            rx = 1; // Bit dừng
            #BIT_PERIOD;
        end
    endtask

    // Tác vụ nhận 1 byte từ UART TX
    task receive_uart_byte;
        output reg [7:0] data_byte;
        integer i;
        begin
            data_byte = 8'b0;
            @(negedge tx);
            #(BIT_PERIOD/2);
            for (i = 0; i < 8; i++) begin
                #BIT_PERIOD;
                data_byte[i] = tx;
            end
            #BIT_PERIOD;
            if (tx !== 1) $display("LỖI: Bit dừng không ở mức cao tại thời điểm %t", $time);
        end
    endtask

    // Kịch bản kiểm tra
    initial begin
        reg [7:0] received_byte;
        rst_n = 0;
        rx = 1;
        #100;

        rst_n = 1;
        #100;

        $display("dang gui plaintext qua RX...");
        for (integer i = 0; i < 16; i++) begin
            $display("Gui byte %0d: %h", i, 8'h11 + i);
            send_uart_byte(8'h11 + i);
        end
		   
		  repeat (50) @(posedge clk);
		 
        

        $display("dang nhan ciphertext tu TX...");
        for (integer i = 0; i < 16; i++) begin
            receive_uart_byte(received_byte);
            $display("Nhan byte %0d: %h tai thoi diem %t", i, received_byte, $time);
        end

        #10000;
        $display("Hoàn thành kiểm tra tại thời điểm %t", $time);
        $finish;
    end

    // In plaintext và ciphertext khi AES hoàn tất
    always @(posedge dut.aes_valid_out) begin
        $display("[%0t] AES done!", $time);
        $display("Plaintext  : %032h", dut.last_plaintext);
        $display("Ciphertext : %032h", dut.last_ciphertext);
    end

    // Theo dõi tín hiệu TX
    initial begin
        $monitor("Thời gian=%t, TX=%b", $time, tx);
    end

endmodule