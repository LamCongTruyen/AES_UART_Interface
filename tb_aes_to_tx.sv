`timescale 1ns/1ps
module tb_aes_to_tx;
    localparam CLK_FREQ   = 50000000;    
    localparam BAUD_RATE  = 115200;        
    localparam BIT_PERIOD = 8680; 
    logic clk;
    logic reset;
    logic start;
    logic [127:0] ciphertext;
    logic tx;
    logic done;
	 
	 logic valid;
	 logic [7:0] data_out;
	 logic [9:0] wr_ptr;     
    logic [9:0] rd_ptr;
	 
    initial clk = 0;
    always #10 clk = ~clk;

    aes_to_tx_top dut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .ciphertext(ciphertext),
        .tx(tx),
        .done(done)
    );
	 uart_rx uut (
        .clk(clk),
        .rst_n(reset),
        .rx(tx),
        .data_out(data_out),
        .valid(valid)
    );

    logic uart_busy;
    logic [7:0] received_byte;
    int bit_count;
    event uart_byte_received;
	 
	assign rd_ptr = dut.rd_ptr;
	assign wr_ptr = dut.wr_ptr;
	 
    initial begin
        reset = 0;
        start = 0;
        #(100);
		  //rx = 1;
        reset = 1;
        #(100);

        for (int i = 0; i < 5; i++) begin
            ciphertext = 128'hAABBCCDDEEFF00112233445566778899 + i;
            $display("\n=== Block %0d gửi ciphertext: %h ===", i, ciphertext);
            start = 1;
            @(posedge clk);
            start = 0;
            @(posedge clk); 
        end

        #(10000000);
        $display("=== KẾT THÚC MÔ PHỎNG ===");
        $stop;
    end

    initial begin
        $monitor("[%0t] wr_ptr=%0d rd_ptr=%0d buffer_empty=%b buffer_full=%b done=%b tx=%b",
                 $time, dut.wr_ptr, dut.rd_ptr, dut.buffer_empty, dut.buffer_full, done, tx);
    end
	 always @(posedge clk) begin
        if (dut.uart_trigger) begin
            $display("[%0t] UART trigger -> gui byte %0d = 0x%02h", $time, dut.rd_ptr, dut.uart_data_in);
			end
			if (valid) begin
            $display("UART RX nhận byte: %02h", data_out);
			end
    end
endmodule
