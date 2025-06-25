module alu_dec
(
    input op5 , 
    input [1:0] ALUOP ,
    input [2:0] funct3 ,
    input [6:0] funct7 ,
    output reg [2:0] ALUControl
);
    always@(*)
        begin
            case(ALUOP)
                0 : ALUControl = 3'b000;
                1 : ALUControl = 3'b010;
                2 : 
                    case(funct3)
                        3'b000 : if({op5 , funct7[5]} == 2'b11) ALUControl = 3'b010;
                                 else ALUControl = 3'b000;
                        3'b001 : ALUControl = 3'b001;
                        3'b100 : ALUControl = 3'b100;
                        3'b101 : ALUControl = 3'b101;
                        3'b110 : ALUControl = 3'b110;
                        3'b111 : ALUControl = 3'b111;
                        default : ALUControl = 3'b000;
                    endcase
                default : ALUControl = 3'b000;
            endcase
        end
endmodule
