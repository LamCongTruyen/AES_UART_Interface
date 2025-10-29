module initial_transform_last (
    input  logic [7:0] text [0:15],
    input  logic [7:0] key [0:15],
    output logic [7:0] out1 [0:15]
);

always_comb begin
    for (int i = 0; i < 16; i++)
        out1[i] = text[i] ^ key[i];
end
endmodule
