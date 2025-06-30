module control_unit
(
    input Zero,                     //(ALUResult == 0)
    input Sign_Flag,                //ALUResult [31] : sign bit
    input [2:0] funct3,             //Instr[14:12]
    input [6:0] op,                 //Instr[0:6]
    input [6:0] funct7,             //Instr[25:31]
    output ResultSrc,               //ALUResult vs ReadData => Result
    output MemWrite,                //write enable, WE for Data Memory
    output ALUSrc,                  //RD2 vs ImmExt => SrcB
    output RegWrite,                //write enable, WE3 for Register File
    output reg PCSrc,               //PC+4 vs PC+ImmExt => PCNext
    output [2:0] ALUControl,        //ALU opcode
    output [1:0] ImmSrc             //Sign_Extend opcode
);
    wire Branch;                    //for PCSrc Logic
    wire [1:0] ALUOP;               //Main_Dec opcode

    alu_dec ALU_Dec(
        .op5(op[5]),
        .funct7(funct7),
        .ALUOP(ALUOP),
        .funct3(funct3),
        .ALUControl(ALUControl)
    );

    main_dec Main(
        .op(op),
        .ImmSrc(ImmSrc),
        .ALUOP(ALUOP),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .Branch(Branch)
    );

    always @(*) 
    begin
        case (funct3)
            3'b000 : PCSrc = Branch & Zero;      // BEQ
            3'b001 : PCSrc = Branch & ~Zero;     // BNE
            3'b100 : PCSrc = Branch & Sign_Flag; // BLT
            default: PCSrc = 0;
        endcase
    end
endmodule