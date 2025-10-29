
module aes_uart_tx_top #(
    parameter CLK_FREQ  = 50000000,   // 50 MHz
    parameter BAUD_RATE = 115200
)(
    input  logic         clk,
    input  logic         reset,
	 input  logic 				rx,
	 input  logic [127:0]     key,
	 input  logic [127:0]    nonce, 
	 input  logic [127:0] plaintext,
	 input  logic         aes_enable,    
    output logic [127:0] outputplaintext,      
		
	 output logic [127:0] outputciphertext,
	 output logic 			 dataaes_valid,

    output logic          tx,       
    output logic          done
);

    logic [127:0] ciphertext;
    logic aes_done;
    logic uart_done;
    logic start_uart;
	 logic batdau;
	 logic [127:0] latched_ciphertext;
	 logic latched_valid; 
	 
	 //logic [127:0] plaintext;
	 
	 logic rst_n;
	 logic [7:0] uart_data_out;
    logic uart_valid;
	 logic [7:0] buffer [0:15];
    logic [3:0] count;
    logic buffer_full;
	 
	 //logic aes_enable = 0;
	 
    assign buffer_full = (count == 4'd16);
	 assign rst_n = ~reset;
	 /*
	 uart_rx #(
        .BAUD_DIV(434),
        .TICK_DIV(27)
    ) rx_to_aes_inst (
        .clk(clk),
        .rst_n(rst_n),
        .rx(rx),
        .data_out(uart_data_out),
        .valid(uart_valid)
    );
*/
    AES_CTR_pipelined aes_core (
        .clk       (clk),
        .reset     (reset),
        .enable    (batdau),
        .key       (key), 
        .nonce     (nonce),
        .plaintext (plaintext),
        .ciphertext(ciphertext),
        .valid_out (aes_done)
    );
	 
    aes_to_tx_top #(
        .CLK_FREQ(CLK_FREQ),
        .BAUD_RATE(BAUD_RATE)
    ) aes_to_tx_inst (
        .clk        (clk),
        .reset      (reset),
        .start      (start_uart),
        .ciphertext (latched_ciphertext),
        .tx         (tx),         
        .done       (uart_done)
    );
	 
    typedef enum logic [2:0] {
        ST_IDLE = 3'd0,
        ST_WAIT_AES = 3'd1,
		  ST_WAIT_DATAAES = 3'd2,
		  ST_SEND_UART = 3'd3,
        ST_DONE = 3'd4
    } state_t;
    state_t state;

//RX NHẬN DỮ LIỆU SAU ĐÓ ĐƯA VÀO BUFFER	
/*	
	 always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'd0;
            for (int i = 0; i < 16; i++) begin
                buffer[i] <= 8'h0;
            end
        end else begin
            if (uart_valid) begin
                if (count < 4'd16) begin
                    buffer[count] <= uart_data_out;
                    count <= count + 1'b1;
                end
            end
            if (buffer_full) begin
                count <= 4'd0; 
            end
        end
    end
	 
	 always_comb begin
        plaintext = 128'h0;
        if (buffer_full) begin
            for (int i = 0; i < 16; i++) begin
                plaintext[127 - i*8 -: 8] = buffer[i];
            end
        end
    end
	 
	 always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            aes_enable <= 1'b0;
        end else begin
            aes_enable <= buffer_full;
        end
    end
*/
//CIPHER TỪ AES ĐƯA RA TIN HIEU TX 
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state       <= ST_IDLE;
            start_uart  <= 0;
            done        <= 0;
				batdau <= 0;
			   latched_ciphertext <= 128'h0;
				latched_valid      <= 0;
        end else begin
            start_uart <= 0;
				batdau <= 0;
            done <= 0;
            case (state)
				
                ST_IDLE: begin
                    if (aes_enable) begin
                        state <= ST_WAIT_AES;
								batdau <= 1;			//ena AES		
								latched_valid <= 0;		
						  end
                end
					 
                ST_WAIT_AES: begin
						  batdau <= 0;
                    if (aes_done && !latched_valid) begin
								latched_ciphertext <= ciphertext;
                        latched_valid      <= 1;
								//batdau <= 0;
								//start_uart <= 1;  //ĐÃ SỬA Ở ĐÂY 10H48 
								//state <= ST_SEND_UART;
								state <= ST_WAIT_DATAAES;
                    end
                end
				    //
					 ST_WAIT_DATAAES: begin
							start_uart <= 1;
							state <= ST_SEND_UART;
					 end
					//
                ST_SEND_UART: begin
                    if (uart_done) begin
                        state <= ST_DONE;
						  end
                end

                ST_DONE: begin 
						  
                    done <= 1;
                    state <= ST_IDLE;
                end
					 
            endcase
        end
    end
		
	 assign outputplaintext = plaintext;
	 assign dataaes_valid = aes_done;
	 assign outputciphertext = ciphertext;
	 
endmodule
