module instr_mem
(
    input [31:0] A ,
    output [31:0] RD
);
    reg [31:0] ROM [0:63];
    initial
        $readmemh("program.txt" , ROM);     
    assign RD = ROM [A[31:2]];
endmodule