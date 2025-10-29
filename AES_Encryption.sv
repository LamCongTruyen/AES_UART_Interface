module AES_Encryption (
    input  logic        clk,
    input  logic        reset, 	 // chỉ reset ở top
	 input  logic enable,
    input  logic [127:0] plaintext,
    input  logic [127:0] key,
    output logic [127:0] cypher
);

  // Round data
  logic [127:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9;

  // Round keys
  logic [127:0] key0, key1, key2, key3, key4;
  logic [127:0] key5, key6, key7, key8, key9, key10;

  // Control
  logic done;
  logic start_enc;

  // ========= Key Expansion =========
  KeyExp u3 (
      .clk(clk),
      .rst(reset),     // reset cho key expansion
      .enable(enable),
      .key(key),
      .round0(key0), .round1(key1), .round2(key2), .round3(key3), .round4(key4),
      .round5(key5), .round6(key6), .round7(key7), .round8(key8), .round9(key9), .round10(key10),
      .done(done)
  );

  // ========= Control FSM =========
  always_ff @(posedge clk or posedge reset) begin
    if (reset)
      start_enc <= 1'b0;
    else if (done)
      start_enc <= 1'b1;   // cho phép mã hóa khi key expansion xong
  end

  // ========= AES rounds (không reset bên trong) =========
  AES1 u4  (.clk(clk), .plaintext(plaintext), .key(key0), .cypher(r0));
  AES1 u5  (.clk(clk), .plaintext(r0), .key(key1), .cypher(r1));
  AES1 u6  (.clk(clk), .plaintext(r1), .key(key2), .cypher(r2));
  AES1 u7  (.clk(clk), .plaintext(r2), .key(key3), .cypher(r3));
  AES1 u8  (.clk(clk), .plaintext(r3), .key(key4), .cypher(r4));
  AES1 u9  (.clk(clk), .plaintext(r4), .key(key5), .cypher(r5));
  AES1 u10 (.clk(clk), .plaintext(r5), .key(key6), .cypher(r6));
  AES1 u11 (.clk(clk), .plaintext(r6), .key(key7), .cypher(r7));
  AES1 u12 (.clk(clk), .plaintext(r7), .key(key8), .cypher(r8));

  AES_lastround u13 (.clk(clk), .enable(start_enc), .plaintext(r8), .key(key9), .cypher(r9));

  // ========= Final XOR + reset =========
  always_ff @(posedge clk or posedge reset) begin
    if (reset)
      cypher <= 128'b0;
    else if (start_enc)
      cypher <= r9 ^ key10;
  end

endmodule