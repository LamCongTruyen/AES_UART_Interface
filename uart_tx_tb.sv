
    // ==============================
    //testbench của module UART-TX
    // ==============================

`timescale 1ns/1ps

module uart_tx_tb;
    
	 parameter CLK_PERIOD = 20;       
    parameter BAUD_DIV = 434;
    parameter BIT_PERIOD = BAUD_DIV * CLK_PERIOD;  

    logic clk;
    logic rst_n;
    logic tx;
	 logic trigger;
    logic [7:0] data_in;
	 logic busy;

    uart_tx uut (
		 . clk(clk),
		 . rst_n(rst_n),
		 . trigger(trigger),
		 . data_in(data_in),
		 . tx(tx),
		 . busy(busy)
	 );

    always #(CLK_PERIOD/2) clk = ~clk;

    task uart_send_byte;
        input [7:0] data;
        begin
            
				@(posedge clk);
				data_in = data;
            trigger = 1;
				#(BIT_PERIOD);

				@(posedge clk);
            trigger = 0;
            #(10 * BIT_PERIOD);
        end
    endtask

    initial begin
       
        clk = 0;
        rst_n = 0;
		  trigger = 0;
        data_in = 8'h00;

        #100;
        rst_n = 1;

        // Gửi ký tự 'A'
        #1000;
		  $display(">> Gửi ký tự A (0x41)");
        uart_send_byte(8'h41);

        // Gửi ký tự '5' 
        #2000;
        uart_send_byte(8'h35);

        #4000;
        $stop;
    end

endmodule
