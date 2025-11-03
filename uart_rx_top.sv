

    // ==============================
    //chương trình chính này nhận dữ liệu từ chân rx rồi xuất ra dataout 128bit(plaintext cấp cho AES)
	 //testbench  của nó là: tb_uart_rx_top
    // ==============================


module uart_rx_top #(
    parameter int BUFFER_SIZE = 256,
	 parameter int DATA_WIDTH = 8 
)(
    input  logic        clk,
    input  logic        rst_n,
    input  logic        rx,
    //input  logic        enable,         

    output logic [127:0] data_out_128,  //out 128bit
    output logic         data_valid  
);

    logic [7:0] data_rx_out;
    logic       rx_valid;
	 logic 	buffer_full;
	 logic   buffer_empty;
	 
    uart_rx u_rx (
        .clk(clk),
        .rst_n(rst_n),
        .rx(rx),
        .data_out(data_rx_out),//out 8bit
        .valid(rx_valid)
    );
	 
	 integer i;
    logic [DATA_WIDTH - 1 :0] buffer [0: BUFFER_SIZE - 1];
    logic [$clog2(BUFFER_SIZE) - 1:0] write_ptr;
    logic [$clog2(BUFFER_SIZE) - 1 :0] read_ptr;
    logic [3:0]  block_byte_count; 
    //logic [127:0] block_reg; 
		
	 function automatic logic [11:0] buffer_count;
        input [11:0] wptr, rptr;
        begin
            if (wptr >= rptr)
                buffer_count = wptr - rptr;
            else
                buffer_count = BUFFER_SIZE - (rptr - wptr);
        end
    endfunction
	 
	 assign buffer_full  = ((write_ptr + 1'b1) % BUFFER_SIZE == read_ptr);
    assign buffer_empty = (read_ptr  == write_ptr);
	 
//nhận dữ liệu vào sau khi đúng khung dữ liệu
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            write_ptr <= '0;
        end else if (rx_valid && !buffer_full) begin
            buffer[write_ptr] <= data_rx_out;
            write_ptr <= (write_ptr + 1) % BUFFER_SIZE;
        end
    end

//xuất dữ liệu ra nếu buffer chứa đủ nhiều
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            block_byte_count <= 128'd0;
            data_out_128     <= 128'd0;
            data_valid       <= 1'b0;
            read_ptr         <= '0;
        end else begin
            data_valid <= 1'b0;

            if (buffer_count(write_ptr, read_ptr) >= 16) begin
                for (i = 0; i < 16; i++) begin
                    data_out_128[127 - 8*i -: 8] <= buffer[(read_ptr + i) % BUFFER_SIZE];
					 end
                read_ptr   <= (read_ptr + 16) % BUFFER_SIZE;
                data_valid <= 1'b1;
            end
        end
    end

endmodule
