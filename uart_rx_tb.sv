`timescale 1ns/1ps

module uart_rx_tb;

    logic clk;
    logic rst_n;
    logic rx;
    logic [7:0] data_out;
    logic valid;

    // Tham số UART
    parameter CLK_PERIOD = 20;       // 50 MHz -> 20 ns chu kỳ f=1/t >> t= 20ns
    parameter BAUD_DIV = 434;        // từ module chính
    parameter BIT_PERIOD = BAUD_DIV * CLK_PERIOD;  // thời gian 1 bit UART = 8680 ns

    // Khởi tạo module uart_rx
    uart_rx uut (
        .clk(clk),
        .rst_n(rst_n),
        .rx(rx),
        .data_out(data_out),
        .valid(valid)
    );

    // Tạo xung clock 50 MHz
    always #(CLK_PERIOD/2) clk = ~clk;

    // Task gửi 1 byte UART (start + 8 data + stop)
    task uart_send_byte;
        input [7:0] data;
        integer i;
        begin
            // Start bit
            rx = 0;
            #(BIT_PERIOD);

            // 8 bit data (LSB trước)
            for (i = 0; i < 8; i = i + 1) begin
                rx = data[i];
                #(BIT_PERIOD);
            end

            // Stop bit
            rx = 1;
            #(BIT_PERIOD);
        end
    endtask

    // Khối mô phỏng chính
    initial begin
        // Khởi tạo
        clk = 0;
        rst_n = 0;
        rx = 1; // đường idle = 1

        // Reset ngắn
        #10;
        rst_n = 1;
        // Gửi ký tự 'A' (0x41)
        #20;
        uart_send_byte(8'h41);
		  @(posedge clk);
        // Gửi ký tự '5' (0x35)
		  
        uart_send_byte(8'h35);
		  @(posedge clk);
        // Dừng mô phỏng
        //#1000;
        $stop;
    end
	
	always @(posedge clk) begin
		 if (uut.valid)
			  $display("[%0t] VALID asserted, data_out = %h", $time, uut.data_out);
	end

endmodule
