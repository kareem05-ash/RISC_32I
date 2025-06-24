module alu
(
    input [31:0] A , B ,
    input [2:0] ALUControl ,
    output reg Zero , Sign_Flag ,
    output reg [31:0] ALUResult
);
    always@(*)
        begin
            case(ALUControl)
                3'b000 : ALUResult = A + B;
                3'b001 : ALUResult = A <<B;
                3'b010 : ALUResult = A - B;
                3'b100 : ALUResult = A ^ B;
                3'b101 : ALUResult = A >>B;
                3'b110 : ALUResult = A | B;
                3'b111 : ALUResult = A & B;
                default : ALUResult = 0;
            endcase
            if(ALUResult == 0)
                Zero = 1;
            else 
                Zero = 0;
            Sign_Flag = ALUResult[31];
        end
endmodule