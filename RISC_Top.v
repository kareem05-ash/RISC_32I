module risc_top
(
    input clk,
    input areset  // Active low reset
);
    // alu Insternal Signals
    wire [31:0] SrcA;
    wire [31:0] SrcB;
    wire [2:0] ALUControl;
    wire [31:0] ALUResult;
    wire Zero;
    wire Sign_Flag;
    
    // pc_unit Internal Signals
    wire PCSrc;
    wire load = 1'b1;  // Always enabled
    wire [31:0] PC;
    wire [31:0] ImmExt;
    
    // instr_mem Internal Signals
    wire [31:0] Instr;
    
    // reg_file Internal Signals
    wire RegWrite;
    wire [31:0] Result;
    wire [31:0] RD2;
    
    // data_mem Internal Signals
    wire MemWrite;
    wire [31:0] ReadData;
    
    // control_unit Internal Signals
    wire ResultSrc;
    wire ALUSrc;
    wire [1:0] ImmSrc;

                                        /////// Module Instantiations ///////
    alu alu(
        .A(SrcA),
        .B(SrcB),
        .ALUControl(ALUControl),
        .Zero(Zero),
        .Sign_Flag(Sign_Flag),
        .ALUResult(ALUResult)
    );
    
    pc_unit pcu(
        .clk(clk),
        .areset(areset), 
        .load(load),
        .PCSrc(PCSrc),
        .ImmExt(ImmExt),
        .PC(PC)
    );
    
    instr_mem instr_mem(
        .A(PC),
        .RD(Instr)
    );
    
    reg_file rf(
        .clk(clk),
        .areset(areset),  
        .WE3(RegWrite),
        .A1(Instr[19:15]),
        .A2(Instr[24:20]),
        .A3(Instr[11:7]),
        .WD3(Result),
        .RD1(SrcA),
        .RD2(RD2)
    );
    
    data_mem dm(
        .clk(clk),
        .WE(MemWrite),
        .A(ALUResult),
        .WD(RD2),
        .RD(ReadData)
    );
    
    control_unit cu(
        .Sign_Flag(Sign_Flag),
        .Zero(Zero),
        .funct3(Instr[14:12]),
        .funct7(Instr[31:25]),
        .op(Instr[6:0]),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .PCSrc(PCSrc),
        .ALUControl(ALUControl),
        .ImmSrc(ImmSrc)
    );
    
    sign_extend s_ext(
        .In(Instr),
        .ImmSrc(ImmSrc),
        .ImmExt(ImmExt)
    );
    
    assign SrcB = ALUSrc ? ImmExt : RD2;
    assign Result = ResultSrc ? ReadData : ALUResult;
endmodule