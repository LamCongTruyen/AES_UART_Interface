`timescale 1ns/1ps

module uart_rx_top #(
    parameter int BAUD_DIV = 434,
    parameter int TICK_DIV = 27,
    parameter int BUFFER_SIZE = 2048   // 2048 bytes = 2KB
)(
    input  logic        clk,
    input  logic        rst_n,
    input  logic        rx,
    input  logic        enable,         // cho phép đọc khối 128bit ra

    output logic [127:0] data_out_128,  // dữ liệu gom 128 bit (16 byte)
    output logic         data_valid,    // báo có dữ liệu 128bit hợp lệ
    output logic         buffer_full,   // báo bộ đệm đầy
    output logic         buffer_empty   // báo bộ đệm rỗng
);

    // =============================================
    // UART RX instance
    // =============================================
    logic [7:0] rx_byte;
    logic       rx_valid;

    uart_rx u_rx (
        .clk(clk),
        .rst_n(rst_n),
        .rx(rx),
        .data_out(rx_byte),
        .valid(rx_valid)
    );

    // =============================================
    // Buffer RAM (2048 byte)
    // =============================================
    logic [7:0] buffer [0:BUFFER_SIZE-1];
    logic [11:0] write_ptr =0;  // 2^11 = 2048
    logic [11:0] read_ptr =0;
    logic [3:0]  block_byte_count; // đếm 0–15 byte trong block 128bit
    logic [127:0] block_reg; // gom byte thành block 128bit
		
	 function automatic logic [11:0] buffer_count;
        input [11:0] wptr, rptr;
        begin
            if (wptr >= rptr)
                buffer_count = wptr - rptr;
            else
                buffer_count = BUFFER_SIZE - (rptr - wptr);
        end
    endfunction
	 assign buffer_full  = ((write_ptr + 1) % BUFFER_SIZE == read_ptr);
    assign buffer_empty = (read_ptr  == write_ptr);
    // =============================================
    // Ghi dữ liệu UART vào buffer
    // =============================================
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            write_ptr <= 0;
        end else if (rx_valid && !buffer_full) begin
            buffer[write_ptr] <= rx_byte;
            write_ptr <= (write_ptr + 1) % BUFFER_SIZE;
        end
    end

    // =============================================
    // Báo trạng thái buffer
    // =============================================
    

    // =============================================
    // Gom dữ liệu 16 byte thành 128 bit
    // =============================================
	 integer i;
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            block_byte_count <= 0;
            data_out_128     <= 0;
            data_valid       <= 0;
            read_ptr         <= 0;
        end else begin
            data_valid <= 0;

            if (enable && buffer_count(write_ptr, read_ptr) >= 16) begin
                for (i = 0; i < 16; i++)
                    data_out_128[127 - 8*i -: 8] <= buffer[(read_ptr + i) % BUFFER_SIZE];
                read_ptr   <= (read_ptr + 16) % BUFFER_SIZE;
                data_valid <= 1'b1;
            end
        end
    end

endmodule
