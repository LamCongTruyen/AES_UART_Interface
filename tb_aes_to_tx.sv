`timescale 1ns/1ps
module tb_aes_to_tx;
    // =====================================
    localparam CLK_FREQ   = 50_000_000;       // 50 MHz
    localparam BAUD_RATE  = 115200;           // UART baud rate
    localparam BIT_PERIOD = 8680; // ns per bit (~8680ns)
    logic clk;
    logic reset;
    logic start;
    logic [127:0] ciphertext;
    logic tx;
    logic done;

    // Clock 50 MHz
    initial clk = 0;
    always #10 clk = ~clk; // T = 20ns -> 50MHz

    // Instantiate DUT
    aes_to_tx_top dut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .ciphertext(ciphertext),
        .tx(tx),
        .done(done)
    );

    // UART stub (simple model)
    logic uart_busy;
    

    initial begin
        reset = 1;
        start = 0;
        uart_busy = 0;
        ciphertext = 128'hd30216c83d902e5090291c9d378ffc08;
        #100;
        reset = 0;

        // Gửi 1 block
        #50;
        start = 1;
		  #20;
		  start = 0;

			//@(20*BIT_PERIOD);
        #2000000;
        $stop;
    end

    // Monitor
    initial begin
        $monitor("[%0t] wr_ptr=%0d rd_ptr=%0d buffer_empty=%b buffer_full=%b done=%b tx=%b",
                 $time, dut.wr_ptr, dut.rd_ptr, dut.buffer_empty, dut.buffer_full, done, tx);
    end
	 always @(posedge clk) begin
        if (dut.uart_trigger)
            $display("[%0t] UART trigger -> gui byte %0d = 0x%02h", $time, dut.rd_ptr, dut.uart_data_in);
    end
endmodule
