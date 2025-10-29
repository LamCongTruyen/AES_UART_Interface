module uart_tx_sim #(
    parameter int CLK_FREQ = 50_000_000,
    parameter int BAUD_RATE = 115_200
)(
    input  logic clk,
    input  logic rst_n,
    output logic tx
);
    localparam int BAUD_DIV = CLK_FREQ / BAUD_RATE;  // ~434

    logic [7:0] tx_data [0:15];
    initial begin
        tx_data[0]  = 8'h11;
        tx_data[1]  = 8'h22;
        tx_data[2]  = 8'h33;
        tx_data[3]  = 8'h44;
        tx_data[4]  = 8'h55;
        tx_data[5]  = 8'h66;
        tx_data[6]  = 8'h77;
        tx_data[7]  = 8'h88;
        tx_data[8]  = 8'h99;
        tx_data[9]  = 8'haa;
        tx_data[10] = 8'hbb;
        tx_data[11] = 8'hcc;
        tx_data[12] = 8'hdd;
        tx_data[13] = 8'hee;
        tx_data[14] = 8'hff;
        tx_data[15] = 8'h00;
    end

    logic [3:0] byte_idx;
    logic [9:0] shift_reg;
    logic [15:0] baud_cnt;
    logic [3:0] bit_cnt;
    logic sending;

    assign tx = shift_reg[0];

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            byte_idx <= 0;
            baud_cnt <= 0;
            bit_cnt  <= 0;
            sending  <= 0;
            shift_reg <= 10'h3FF;
        end else begin
            if (!sending) begin
                if (byte_idx < 16) begin
                    // tạo frame: 1 start (0) + 8 data + 1 stop (1)
                    shift_reg <= {1'b1, tx_data[byte_idx], 1'b0};
                    byte_idx <= byte_idx + 1;
                    sending <= 1;
                    baud_cnt <= 0;
                    bit_cnt <= 0;
                end
            end else begin
                if (baud_cnt == BAUD_DIV-1) begin
                    baud_cnt <= 0;
                    shift_reg <= {1'b1, shift_reg[9:1]};
                    bit_cnt <= bit_cnt + 1;
                    if (bit_cnt == 9)
                        sending <= 0;
                end else
                    baud_cnt <= baud_cnt + 1;
            end
        end
    end
endmodule