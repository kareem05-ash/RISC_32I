module alu
(
    input [31:0] A, //SrcA
    input [31:0] B, //SrcB
    input [2:0] ALUControl,
    output Zero,
    output Sign_Flag,
    output reg [31:0] ALUResult
);
    always @(*) begin
        case(ALUControl)
            3'b000 : ALUResult = A + B;     //add
            3'b001 : ALUResult = A << B;    //shift to left
            3'b010 : ALUResult = A - B;     //sub
            3'b100 : ALUResult = A ^ B;     //reduction XOR
            3'b101 : ALUResult = A >> B;    //shift to right 
            3'b110 : ALUResult = A | B;     //reduction OR
            3'b111 : ALUResult = A & B;     //reduction AND
            default: ALUResult = 32'b0;     //default set to zero
        endcase
    end
    assign Zero = (ALUResult == 32'b0);     //active if ALUResult is 32'b0
    assign Sign_Flag = ALUResult[31];       //MSB of ALUResult
endmodule