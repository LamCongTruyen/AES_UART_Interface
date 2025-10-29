`timescale 1ns / 1ps

module tb_aes_uart_rx;
	 localparam CLK_PERIOD = 20;           // 50 MHz → 20ns
    localparam BAUD_DIV   = 434;          // 50M / 115200 ≈ 434
    localparam TICK_DIV   = 27;           // 16x oversampling
    localparam BIT_TIME   = BAUD_DIV * CLK_PERIOD; // ~8680 ns
    logic clk;
    logic reset;
    logic rx;
    logic tx;
    logic done;
    //logic validdata_out;

    // Tạo instance DUT
    aes_uart_rx_top uut (
        .clk(clk),
        .reset(reset),
        .rx(rx),
        .tx(tx),
        .done(done)
    );

    // Clock 10ns (100 MHz)
    always #5 clk = ~clk;

    // UART gửi dữ liệu (9600 baud ~104us mỗi bit)
    task uart_send_byte(input [7:0] data);
        integer i;
        begin
            // start bit
            rx = 1'b0; 
            #(BIT_TIME); 
            // 8 data bits (LSB first)
            for (i = 0; i < 8; i++) begin
                rx = data[i];
                #(BIT_TIME);
            end
            // stop bit
            rx = 1'b1;
            #(BIT_TIME);
        end
    endtask

    // Tạo stimulus
    initial begin
        clk = 0;
        rx = 1;
        reset = 1;
        #(100);
        reset = 0;

        $display("\n=== BẮT ĐẦU GỬI DỮ LIỆU UART ===");

        // Gửi 80 byte dữ liệu ngẫu nhiên
        for (int i = 0; i < 80; i++) begin
            uart_send_byte(i);
        end

        $display("\n=== ĐÃ GỬI XONG 80 BYTE ===");

        // Đợi done
        wait(done);
        $display("\n=== QUÁ TRÌNH MÃ HÓA HOÀN THÀNH ===");
        #(1000);
        $stop;
    end

endmodule
