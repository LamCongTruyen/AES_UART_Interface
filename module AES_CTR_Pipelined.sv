module AES_CTR_pipelined (
    input  logic         clk,
    input  logic         reset,       // reset pipeline & counter
    input  logic [127:0] key,         // AES key
    input  logic [127:0] nonce,       // IV / nonce
    input  logic [127:0] plaintext,   // block input
    output logic [127:0] ciphertext
);

    // -----------------------------
    // Counter register
    // -----------------------------
    logic [127:0] counter;
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            counter <= nonce;
        else
            counter <= counter + 1;  // tăng counter mỗi block
    end

    // -----------------------------
    // AES pipeline: encrypt counter
    // -----------------------------
    logic [127:0] keystream;
    AES_pipeline_Encryption u_aes (
        .clk(clk),
        .reset(reset),
        .plaintext(counter),  // input là counter
        .key(key),
        .cypher(keystream)
    );

    // -----------------------------
    // XOR plaintext với keystream
    // -----------------------------
    assign ciphertext = plaintext ^ keystream;

endmodule
