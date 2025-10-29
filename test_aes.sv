module test_aes (
    input  logic        clk,        // clock
    input  logic        reset,      // reset
	 input logic enable,
	 input logic s
);

    // Khai báo plaintext và key
    logic [127:0] plaintext;
    logic [127:0] key;
    logic [127:0] cypher;
    logic [15:0] cypher_out;
    // Gán test vector
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
		  if(s) begin 
            plaintext <= 128'h1123456789abcdeffedcba9876543210;
				end
				else
				plaintext <= 128'h0123456789abcdeffedcba9876543210;
            key       <= 128'h0f1571c947d9e8590cb7add6af7f6798;
        end
    end

    // Gọi AES1
    AES_Encryption aes_inst (
        .clk       (clk),
		  .reset      (~reset),
		  .enable     (~enable),
        .plaintext (plaintext),
        .key       (key),
        .cypher    (cypher)
    );


endmodule
