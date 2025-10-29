module inputstate(plaintext,s);
input logic [127:0] plaintext;
output logic [7:0] s [0:15];
always_comb begin
    for (int i = 0; i < 16; i++) begin
        s[i] = plaintext[127 - i*8 -: 8];
    end
end
endmodule
