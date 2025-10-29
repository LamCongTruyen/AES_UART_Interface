module AES_CTR_pipelined (
    input  logic         clk,
    input  logic         reset,
    input  logic         enable,        // cho phép xử lý dòng plaintext
    input  logic [127:0] key,
    input  logic [127:0] nonce,
    input  logic [127:0] plaintext,
    output logic [127:0] ciphertext,
    output logic         valid_out
   // output logic [127:0] counter_debug
);

    // --------------------------------
    // Tham số
    // --------------------------------
    localparam int LATENCY = 11;

    // --------------------------------
    // Tín hiệu nội bộ
    // --------------------------------
    logic [127:0] counter;      // counter gửi vào AES
    logic [127:0] keystream;    // đầu ra AES (sau pipeline)
    logic [LATENCY:0] valid_pipe;
    logic [127:0] plaintext_delay [0:LATENCY];

    //assign counter_debug = counter;

    // --------------------------------
    // AES pipeline
    // --------------------------------
    AES_pipeline_Encryption u_aes (
        .clk(clk),
        .reset(reset),
        .plaintext(counter),
        .key(key),
        .cypher(keystream)
    );

    // --------------------------------
    // Counter logic
    // --------------------------------
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            counter <= 128'h0;
				//counter <= nonce;
        else if (enable)
            counter <= (counter == 128'h0) ? nonce : (counter + 1);
				//counter <= counter + 1;
    end

    // --------------------------------
    // Dịch valid qua pipeline
    // --------------------------------
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            valid_pipe <= '0;
        else begin
            valid_pipe[0] <= enable;
            for (int i = 1; i <= LATENCY; i++)
                valid_pipe[i] <= valid_pipe[i-1];
        end
    end

    assign valid_out = valid_pipe[LATENCY];

    // --------------------------------
    // Delay plaintext qua pipeline
    // --------------------------------
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            for (int i = 0; i <= LATENCY; i++)
                plaintext_delay[i] <= '0;
        end else begin
            plaintext_delay[0] <= plaintext;
            for (int i = 1; i <= LATENCY; i++)
                plaintext_delay[i] <= plaintext_delay[i-1];
        end
    end

    // --------------------------------
    // XOR plaintext và keystream
    // --------------------------------
    assign ciphertext = valid_out ? (plaintext_delay[LATENCY] ^ keystream) : 128'h0;

endmodule
