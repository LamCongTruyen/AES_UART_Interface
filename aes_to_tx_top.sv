
module aes_to_tx_top #(
    parameter CLK_FREQ   = 50000000,   // 50 MHz
    parameter BAUD_RATE  = 115200,
	 parameter BUFFER_SIZE   = 1024 
)(
    input  logic         clk,
    input  logic         reset,

    // AES interface
    input  logic         start,
    input  logic [127:0] ciphertext,

    // UART interface
    output logic         tx,
    output logic         done
);
    // =============================
    // UART cấu hình
    // =============================
    localparam integer BAUD_DIV = CLK_FREQ / BAUD_RATE;
    // =============================
    // UART tín hiệu
    // =============================
    logic        uart_trigger;
    logic [7:0]  uart_data_in;
    logic        uart_busy;
    // =============================
    // Bộ nhớ đệm
    // =============================
    logic [7:0] buffer [0:BUFFER_SIZE-1];
	 logic [9:0] wr_ptr;     
    logic [9:0] rd_ptr;
	 logic [10:0] data_count;
    logic [4:0] byte_idx;
	 logic        buffer_full, buffer_empty;
	 
	 function automatic logic [11:0] buffer_count;
        input [11:0] wptr, rptr;
        begin
            if (wptr >= rptr)
                buffer_count = wptr - rptr;
            else
                buffer_count = BUFFER_SIZE - (rptr - wptr);
        end
    endfunction
	 
	 assign buffer_full  = ((wr_ptr + 1) % BUFFER_SIZE == rd_ptr);
    assign buffer_empty = (rd_ptr  == wr_ptr);
    // =============================
    // Trạng thái FSM
    // =============================
    typedef enum logic [1:0] {
        ST_IDLE = 2'd0,
        ST_SEND = 2'd1,
        ST_WAIT = 2'd2,
        ST_DONE = 2'd3
    } state_t;

    state_t state;
    // =============================
    // UART TX module
    // =============================
    uart_tx uart_tx_inst (
        .clk(clk),
        .rst_n(!reset),
        .trigger(uart_trigger),
        .data_in(uart_data_in),
        .tx(tx),
        .busy(uart_busy)
    );
	 
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            wr_ptr <= 0;
        end else if (start && !buffer_full) begin
            for (int i=0; i<16; i++) begin
					buffer[(wr_ptr + i) % BUFFER_SIZE] <= ciphertext[127 - 8*i -: 8];
			   end
			   wr_ptr <= (wr_ptr + 16) % BUFFER_SIZE;
        end
    end
	 
	always_ff @(posedge clk or posedge reset) begin
		 if (reset) begin
			  rd_ptr <= 0;
			  uart_trigger <= 0;
			  done <= 0;
		 end else begin
			  done <= 0;

			  if (!buffer_empty && !uart_busy && !uart_trigger) begin
					uart_data_in <= buffer[rd_ptr];
					uart_trigger <= 1;
					rd_ptr <= (rd_ptr + 1) % BUFFER_SIZE;
			  end else begin
					uart_trigger <= 0;
					
			  end

			  if (buffer_empty && !uart_busy && !uart_trigger)begin
					done <= 1;
			  end
		 end
	end
	

endmodule
