module next_pc_logic
(
    input [31:0] PC ,                           
    input [31:0] ImmExt , 
    input PCSrc , 
    output [31:0] PCNext
);
    assign PCNext = PCSrc? PC+ImmExt : PC+4;
endmodule