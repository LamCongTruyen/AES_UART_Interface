`timescale 1ns/1ps

module uart_rx_tb;
    
	 parameter CLK_PERIOD = 20;  
    parameter BAUD_DIV = 434;       
    parameter BIT_PERIOD = BAUD_DIV * CLK_PERIOD; 
	 
    logic clk;
    logic rst_n;
    logic rx;
    logic [7:0] data_out;
    logic valid;
	 
    uart_rx uut (
        .clk(clk),
        .rst_n(rst_n),
        .rx(rx),
        .data_out(data_out),
        .valid(valid)
    );

    always #(CLK_PERIOD/2) clk = ~clk;

    task uart_send_byte;
        input [7:0] data;
        integer i;
        begin
     
            rx = 0;
            #(BIT_PERIOD);

            for (i = 0; i < 8; i = i + 1) begin
                rx = data[i];
                #(BIT_PERIOD);
            end

            rx = 1;
            #(BIT_PERIOD);
        end
    endtask

    initial begin
        clk = 0;
        rst_n = 0;
        rx = 1;

        #10;
        rst_n = 1;
        // Gửi ký tự 'A' (0x41)
        #20;
        uart_send_byte(8'h41);
		  @(posedge clk);
        // Gửi ký tự '5' (0x35)
		  
        uart_send_byte(8'h35);
		  @(posedge clk);
        //#1000;
        $stop;
    end
	
	always @(posedge clk) begin
		 if (uut.valid)
			  $display("[%0t] VALID asserted, data_out = %h", $time, uut.data_out);
	end

endmodule
