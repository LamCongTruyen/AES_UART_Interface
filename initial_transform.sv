module initial_transform (
    input  logic [127:0] text ,
    input  logic [127:0] key ,
    output logic [127:0] out1);


assign     out1 = text ^ key;

endmodule
