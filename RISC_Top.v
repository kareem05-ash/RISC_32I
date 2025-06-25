module risc_top
(
    input clk ,
    input areset
);
    //ALU Internal Signals
    wire [31:0] A , B;
    wire [2:0] ALUControl;
    wire Zero , Sign_Flag , load;
    wire [31:0] ALUResult;
    //Control Unit Internal Signals
    wire [2:0] funct3;
    wire [6:0] op , funct7;
    wire ResultSrc , MemWrite , ALUSrc , RegWrite , PCSrc;
    wire [1:0] ImmSrc;
    //Data Memory Internal Signals
    wire WE; 
    wire [31:0] Read_Data;
    wire [31:0] Result;
    //Instruction Memory Internal Signals
    wire [31:0] PC;
    wire [31:0] Instr;
    //PC Unit Internal Signals
    wire [31:0] ImmExt;//The rest are already declared 
    //Register File Internal Signals
    wire WE3; 
    wire [31:0] RD1 , RD2;
    //Sign Extension Internal Signals are already declared

    alu ALU(.A(A) ,    //ALU Instantiation
            .B(B) , 
            .ALUControl(ALUControl) ,
            .Zero(Zero) ,
            .Sign_Flag(Sign_Flag) ,
            .ALUResult(ALUResult));

    control_unit CU(.Zero(Zero) ,   //Control Unit Instantiation
                    .Sign_Flag(Sign_Flag) , 
                    .funct3(Instr[14:12]) ,
                    .op(Instr[6:0]) , 
                    .funct7(Instr[31:25]) ,
                    .A(A) , 
                    .B(B) ,
                    .ResultSrc(ResultSrc) ,
                    .MemWrite(MemWrite) ,
                    .ALUSrc(ALUSrc) , 
                    .RegWrite(RegWrite) ,
                    .PCSrc(PCSrc) , 
                    .ALUControl(ALUControl) ,
                    .ImmExt(ImmExt));

    data_mem DM(.clk(clk) ,  //Data Memory Instantition
                .WE(MemWrite) ,
                .A(ALUResult) , 
                .WD(RD2) , 
                .RD(Read_Data));

    instr_mem IM(.A(PC) ,   //Instruction Memory Instantiation
                 .RD(Instr));

    pc_unit PCU(.clk(clk) ,  //PC Unit Instantiation 
                .areset(areset) ,
                .load(1'b1) , 
                .PCSrc(PCSrc) , 
                .ImmExt(ImmExt) ,
                .PC(PC));

    reg_file RF(.clk(clk) ,  //Register File Instantiation
                .areset(areset) ,
                .WE3(RegWrite) , 
                .A1(Instr[19:15]) , 
                .A2(Instr[24:20]) , 
                .A3(Instr[11:7]) , 
                .WD3(Result) , 
                .RD1(RD1) , 
                .RD2(RD2));

    sign_extend SE(.Instr(Instr) , //Instruction Memory Instantiation
                   .ImmExt(ImmExt) , 
                   .ImmSrc(ImmSrc));
        
    assign B = ALUSrc? ImmExt : RD2;
    assign Result = ResultSrc? Read_Data : ALUResult;
endmodule
