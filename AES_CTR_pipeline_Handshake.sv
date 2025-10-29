module AES_CTR_pipeline_Handshake (
    input  logic         clk,
    input  logic         reset,

    // Handshake đầu vào
    input  logic         valid_in,       // Có plaintext mới
    output logic         ready_in,       // Pipeline sẵn sàng nhận

    // AES input
    input  logic [127:0] key,
    input  logic [127:0] nonce,
    input  logic [127:0] plaintext,

    // Handshake đầu ra
    output logic         valid_out,      // Ciphertext hợp lệ
    output logic [127:0] ciphertext
);

    localparam int LATENCY_AES = 11;
    localparam int LATENCY_TOTAL = LATENCY_AES + 1;

    logic [127:0] counter;
    logic [127:0] keystream;
    logic [LATENCY_TOTAL:0] valid_pipe;
    logic [127:0] plaintext_delay [0:LATENCY_TOTAL];
    logic [127:0] xor_stage;

    // -----------------------------
    // AES pipeline (11-stage)
    // -----------------------------
    AES_pipeline_Encryption u_aes (
        .clk(clk),
        .reset(reset),
        .plaintext(counter),
        .key(key),
        .cypher(keystream)
    );

    // -----------------------------
    // Counter logic
    // -----------------------------
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            counter <= 128'h0;
        else if (valid_in && ready_in)
            counter <= (counter == 128'h0) ? nonce : (counter + 1);
    end

    // -----------------------------
    // Pipeline valid signal
    // -----------------------------
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            valid_pipe <= '0;
        else begin
            valid_pipe[0] <= valid_in && ready_in;
            for (int i = 1; i <= LATENCY_TOTAL; i++)
                valid_pipe[i] <= valid_pipe[i-1];
        end
    end

    assign valid_out = valid_pipe[LATENCY_TOTAL];

    // -----------------------------
    // Delay plaintext
    // -----------------------------
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            for (int i = 0; i <= LATENCY_TOTAL; i++)
                plaintext_delay[i] <= '0;
        end else begin
            if (valid_in && ready_in)
                plaintext_delay[0] <= plaintext;
            for (int i = 1; i <= LATENCY_TOTAL; i++)
                plaintext_delay[i] <= plaintext_delay[i-1];
        end
    end

    // -----------------------------
    // XOR stage (clk n+12)
    // -----------------------------
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            xor_stage <= '0;
        else
            xor_stage <= plaintext_delay[LATENCY_AES] ^ keystream;
    end

    assign ciphertext = valid_out ? xor_stage : 128'h0;
endmodule
