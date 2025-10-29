`timescale 1ns/1ps

module tb_uart_rx_top;

    // =====================================
    // Thông số UART và clock
    // =====================================
    localparam CLK_FREQ   = 50_000_000;       // 50 MHz
    localparam BAUD_RATE  = 115200;           // UART baud rate
    localparam BIT_PERIOD = 1_000_000_000 / BAUD_RATE; // ns per bit (~8680ns)

    // =====================================
    // Tín hiệu kết nối
    // =====================================
    logic clk;
    logic rst_n;
    logic rx;
    logic enable;

    wire [127:0] data_out_128;
    wire data_valid;
    wire buffer_full;
    wire buffer_empty;

    // =====================================
    // Khởi tạo DUT
    // =====================================
    uart_rx_top dut (
        .clk(clk),
        .rst_n(rst_n),
        .rx(rx),
        .enable(enable),
        .data_out_128(data_out_128),
        .data_valid(data_valid),
        .buffer_full(buffer_full),
        .buffer_empty(buffer_empty)
    );

    // =====================================
    // Tạo clock 50MHz
    // =====================================
    initial clk = 0;
    always #10 clk = ~clk; // 20ns -> 50MHz

    // =====================================
    // Nhiệm vụ gửi 1 byte qua UART RX
    // =====================================
    task send_uart_byte(input [7:0] data);
        integer i;
        begin
            // Start bit (low)
            rx = 0;
            #(BIT_PERIOD);
            // Gửi 8 bit dữ liệu (LSB trước)
            for (i = 0; i < 8; i = i + 1) begin
                rx = data[i];
                #(BIT_PERIOD);
            end
            // Stop bit (high)
            rx = 1;
            #(BIT_PERIOD);
        end
    endtask

    // =====================================
    // Chuỗi gửi dữ liệu UART
    // =====================================
    integer k;
    initial begin
        // Khởi tạo
        rx      = 1;
        rst_n   = 0;
        enable  = 0;

        #(200);
        rst_n = 1;
        $display("[%0t ns] Bắt đầu gửi UART...", $time);

        // Gửi 32 byte (2 khối 128-bit)
        for (int i = 0; i < 16; i= i + 1) begin
            send_uart_byte(i);  // gửi dữ liệu mẫu: 00,01,02,...,0F
        end

        $display("[%0t ns] Đã gửi xong 32 byte UART.", $time);

        // Đợi cho RX nhận hết
        //#(BIT_PERIOD * 20);

        // Bật enable để đọc block đầu tiên
        enable = 1;
        @(posedge clk);
        enable = 0;
/*
         Đợi một chút rồi đọc block thứ 2
        #(5000);
        enable = 1;
        @(posedge clk);
        enable = 0;
			#(5000);
        enable = 1;
        @(posedge clk);
        enable = 0;
		  #(5000);
        enable = 1;
        @(posedge clk);
        enable = 0;
		  #(5000);
        enable = 1;
        @(posedge clk);
        enable = 0;
		  #(5000);
        enable = 1;
        @(posedge clk);
        enable = 0;
		  */
        // Đợi vài chu kỳ để hiển thị
        #(1000000);
        $stop;
    end

    // =====================================
    // Giám sát dữ liệu đầu ra
    // =====================================
    always @(posedge clk) begin
        if (data_valid)
            $display("[%0t ns] ✅ DATA 128-bit = %032h", $time, data_out_128);
    end

endmodule
