module led (
    input  logic [15:0] datain,
    output logic [6:0] hex0,
    output logic [6:0] hex1,
    output logic [6:0] hex2,
    output logic [6:0] hex3
);

    // hàm giải mã hex digit ra 7seg
    function automatic [6:0] seg_decode (input logic [3:0] nibble);
        case (nibble)
            4'h0: seg_decode = 7'b1000000; // 0
            4'h1: seg_decode = 7'b1111001; // 1
            4'h2: seg_decode = 7'b0100100; // 2
            4'h3: seg_decode = 7'b0110000; // 3
            4'h4: seg_decode = 7'b0011001; // 4
            4'h5: seg_decode = 7'b0010010; // 5
            4'h6: seg_decode = 7'b0000010; // 6
            4'h7: seg_decode = 7'b1111000; // 7
            4'h8: seg_decode = 7'b0000000; // 8
            4'h9: seg_decode = 7'b0010000; // 9
            4'hA: seg_decode = 7'b0001000; // A
            4'hB: seg_decode = 7'b0000011; // b
            4'hC: seg_decode = 7'b1000110; // C
            4'hD: seg_decode = 7'b0100001; // d
            4'hE: seg_decode = 7'b0000110; // E
            4'hF: seg_decode = 7'b0001110; // F
            default: seg_decode = 7'b1111111; // off
        endcase
    endfunction
    // gán cho 4 led 7seg
    always_comb begin
        hex0 = seg_decode(datain[3:0]);    // digit thấp nhất
        hex1 = seg_decode(datain[7:4]);
        hex2 = seg_decode(datain[11:8]);
        hex3 = seg_decode(datain[15:12]);  // digit cao nhất
    end

endmodule
