module AES_pipeline (
    input  logic        clk,
    input  logic [127:0] plaintext,
    input  logic [1407:0] all_keys, // 11 round keys (key0..key10)
    output logic [127:0] cypher
);
  logic [127:0] stage [0:10];

  // --- Initial AddRoundKey (round 0) ---
  assign stage[0] = plaintext ^ all_keys[1407 -: 128]; // key0

  // --- 9 rounds ---
  genvar i;
  generate
    for (i = 0; i < 9; i = i + 1) begin : aes_rounds
      AES1 round_inst (
        .clk(clk),
        .plaintext(stage[i]),
        .round_key(all_keys[1407 - (i+1)*128 -: 128]),
        .cypher(stage[i+1])
      );
    end
  endgenerate

  // --- Last round (no MixColumns) ---
  AES_lastround last_round (
      .clk(clk),
      .plaintext(stage[9]),
      .round_key(all_keys[1407 - (10)*128 -: 128]),
      .cypher(stage[10])
  );

  assign cypher = stage[10];
endmodule
