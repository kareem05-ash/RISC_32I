module next_pc_logic
(
    input [31:0] PC , 
    input [31:0] ImmExt , 
    input PCSrc , 
    output [31:0] NextPC
);
    assign NextPC = PCSrc? PC+ImmExt : PC+4;
endmodule