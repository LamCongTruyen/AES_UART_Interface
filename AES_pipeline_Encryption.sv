module AES_pipeline_Encryption (
    input  logic        clk,
    input  logic        reset,        // reset đồng bộ toàn mạch
    input  logic [127:0] plaintext,
    input  logic [127:0] key,
    output logic [127:0] cypher
);

  // ==========================
  // Round keys 0..10
  // ==========================
  logic [127:0] round [0:10];

  // Key expansion (combinational/static)
  KeyExp u_keyexp (
      .key(key),
      .round(round)
  );

  // ==========================
  // Initial AddRoundKey
  // ==========================
  logic [127:0] s0;
  AES0 r0 (.clk(clk), .reset(reset), .plaintext(plaintext), .key(round[0]), .state_out(s0));
  // ==========================
  // Wires giữa các round
  // ==========================
  logic [127:0] s1, s2, s3, s4, s5, s6, s7, s8, s9;

  // ==========================
  // AES Round pipeline
  // ==========================
  AES1 r1 (.clk(clk), .reset(reset), .plaintext(s0),    .key(round[1]), .cypher(s1));
  AES1 r2 (.clk(clk), .reset(reset), .plaintext(s1),    .key(round[2]), .cypher(s2));
  AES1 r3 (.clk(clk), .reset(reset), .plaintext(s2),    .key(round[3]), .cypher(s3));
  AES1 r4 (.clk(clk), .reset(reset), .plaintext(s3),    .key(round[4]), .cypher(s4));
  AES1 r5 (.clk(clk), .reset(reset), .plaintext(s4),    .key(round[5]), .cypher(s5));
  AES1 r6 (.clk(clk), .reset(reset), .plaintext(s5),    .key(round[6]), .cypher(s6));
  AES1 r7 (.clk(clk), .reset(reset), .plaintext(s6),    .key(round[7]), .cypher(s7));
  AES1 r8 (.clk(clk), .reset(reset), .plaintext(s7),    .key(round[8]), .cypher(s8));
  AES1 r9 (.clk(clk), .reset(reset), .plaintext(s8),    .key(round[9]), .cypher(s9));

  // --- Last round (no MixColumns)
  AES_lastround rlast (
      .clk(clk),
      .reset(reset),
      .plaintext(s9),
      .key(round[10]),
      .cypher(cypher)
  );

endmodule
