`timescale 1ns/1ps

module uart_tx_tb;

    // Tín hiệu testbench
    logic clk;
    logic rst_n;
    logic tx;
	 logic trigger;
    logic [7:0] data_in;
	 logic busy;

    // Tham số UART
    parameter CLK_PERIOD = 20;       // 50 MHz -> 20 ns chu kỳ f=1/t >> t= 20ns
    parameter BAUD_DIV = 434;        // từ module chính
    parameter BIT_PERIOD = BAUD_DIV * CLK_PERIOD;  // thời gian 1 bit UART = 8680 ns

    // Khởi tạo module uart_rx
    uart_tx uut (
		 . clk(clk),
		 . rst_n(rst_n),
		 . trigger(trigger),
		 . data_in(data_in),
		 . tx(tx),
		 . busy(busy)
	 );

    // Tạo xung clock 50 MHz
    always #(CLK_PERIOD/2) clk = ~clk;

    // Task gửi 1 byte UART (start + 8 data + stop)
    task uart_send_byte;
        input [7:0] data;
        begin
            // Start bit
				@(posedge clk);
				data_in = data;
            trigger = 1;
				#(BIT_PERIOD);
				
           

            // 8 bit data (LSB trước)
            

            // Stop bit
				@(posedge clk);
            trigger = 0;
            #(10 * BIT_PERIOD);
        end
    endtask

    // Khối mô phỏng chính
    initial begin
        // Khởi tạo
        clk = 0;
        rst_n = 0;
		  trigger = 0;
        data_in = 8'h00;

        // Reset ngắn
        #100;
        rst_n = 1;

        // Gửi ký tự 'A' (0x41)
        #1000;
		  $display(">> Gửi ký tự A (0x41)");
        uart_send_byte(8'h41);

        // Gửi ký tự '5' (0x35)
        #2000;
        uart_send_byte(8'h35);

        // Dừng mô phỏng
        #4000;
        $stop;
    end

endmodule
