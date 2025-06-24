module main_dec
(
    input [6:0] Opcode,
    output reg RegWrite,ALUsrc,MemWrite,ResultSrc,Branch,
    output reg [1:0]Immsrc,ALUOp
);

always@(*)
case(Opcode)
        7'b000_0011: begin RegWrite=1; Immsrc=2'b00; ALUsrc=1; MemWrite=0; ResultSrc=1; Branch=0; ALUOp=2'b00; end 
        7'b010_0011: begin RegWrite=0; Immsrc=2'b01; ALUsrc=1; MemWrite=1; ResultSrc='x; Branch=0; ALUOp=2'b00; end 
        7'b011_0011: begin RegWrite=1; Immsrc=2'bxx; ALUsrc=0; MemWrite=0; ResultSrc=0; Branch=0;ALUOp=2'b10; end 
        7'b001_0011: begin RegWrite=1; Immsrc=2'b00; ALUsrc=1; MemWrite=0; ResultSrc=0; Branch=0; ALUOp=2'b10; end 
        7'b110_0011: begin RegWrite=0; Immsrc=2'b10; ALUsrc=0; MemWrite=0; ResultSrc='x; Branch=1; ALUOp=2'b01; end 
        default:     begin RegWrite=0; Immsrc=2'b00; ALUsrc=0; MemWrite=0; ResultSrc=0; Branch=0; ALUOp=2'b00; end 

endcase

endmodule