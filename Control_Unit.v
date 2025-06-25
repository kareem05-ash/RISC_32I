module control_unit
(
    input Sign_Flag , Zero ,
    input [2:0] funct3 , 
    input [6:0] op , 
    input [6:0] funct7 ,
    input [31:0] A , B ,
    output ResultSrc , MemWrite , ALUSrc , RegWrite ,
    output reg PCSrc ,
    output [2:0] ALUControl ,
    output [1:0] ImmSrc
);
    wire Branch;
    wire [1:0] ALUOP;
    //alu to track zero , sign_flag
    alu DUT_ALU(.A(A) ,
                .B(B) ,
                .ALUControl(ALUControl) , 
                .Zero(Zero) , 
                .Sign_Flag(Sign_Flag) , 
                .ALUResult());
    //alu decoder
    alu_dec DUT_ALU_Dec(.op5(op[5]) , 
                    .funct7(funct7) , 
                    .ALUOP(ALUOP) ,
                    .funct3(funct3) ,
                    .ALUControl(ALUControl));
    //main decoder 
    main_dec DUT_Main(.op(op) ,
                      .ImmSrc(ImmSrc) , 
                      .ALUOP(ALUOP) ,
                      .ResultSrc(ResultSrc) , 
                      .MemWrite(MemWrite) , 
                      .ALUSrc(ALUSrc) ,
                      .RegWrite(RegWrite) , 
                      .Branch(Branch));
    always@(*)
        case(funct3)
            3'b000 : PCSrc = Branch & Zero;
            3'b001 : PCSrc = Branch & ~Zero;
            3'b100 : PCSrc = Branch & Sign_Flag;
            default : PCSrc = 0;
        endcase
endmodule