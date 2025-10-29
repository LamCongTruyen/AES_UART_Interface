module top_aes_pipeline (
    input  logic clk,
    input  logic rs,
    output logic [127:0] cypher_out
);

  logic [127:0] plaintext = 128'h0123456789abcdeffedcba9876543210;
  logic [127:0] key = 128'h0f1571c947d9e8590cb7add6af7f6798;
  logic [127:0] cypher;

  AES_pipeline_Encryption u1 (
      .clk(clk),
      .reset(rs),
      .plaintext(plaintext),
      .key(key),
      .cypher(cypher)
  );

  assign cypher_out = cypher; // Kết nối ra ngoài

endmodule
