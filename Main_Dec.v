module main_dec
(
    input [6:0] opcode ,
    output reg [1:0] ImmSrc , ALUOP ,
    output reg RegWrite , ALUSrc , MemWrite , ResultSrc , Branch
);
    always@(*)
        case(opcode)
            7'b000_0011 : 
            begin
                ImmSrc = 2'b00;
                ALUOP = 2'b00;
                RegWrite = 1;
                ALUSrc = 1;
                MemWrite = 0;
                ResultSrc = 1;
                Branch = 0;
            end
            7'b010_0011 :
            begin
                ImmSrc = 2'b01;
                ALUOP = 2'b00;
                RegWrite = 0;
                ALUSrc = 1;
                MemWrite = 1;
                ResultSrc = 1'bx;
                Branch = 0;
            end
            7'b011_0011 : 
            begin
                ImmSrc = 2'bxx;
                ALUOP = 2'b10;
                RegWrite = 1;
                ALUSrc = 0;
                MemWrite = 0;
                ResultSrc = 0;
                Branch = 0;
            end
            7'b001_0011 :
            begin
                ImmSrc = 2'b00;
                ALUOP = 2'b10;
                RegWrite = 1;
                ALUSrc = 1;
                MemWrite = 0; 
                ResultSrc = 0; 
                Branch = 0;
            end
            7'b110_0011 : 
            begin
                ImmSrc = 2'b10;
                ALUOP = 2'b01;
                RegWrite = 0;
                ALUSrc = 0;
                MemWrite = 0;
                ResultSrc = 1'bx;
                Branch = 1;
            end
            default : 
            begin
                ImmSrc = 0;
                ALUOP = 0;
                RegWrite = 0; 
                ALUSrc = 0;
                MemWrite = 0;
                ResultSrc = 0;
                Branch = 0;
            end
    endcase
endmodule