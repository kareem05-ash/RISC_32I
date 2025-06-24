module alu_dec_tb();
    reg op5 , funct7;
    reg [1:0] ALUOP;
    reg [2:0] funct3;
    wire [2:0] ALUControl;
    alu_dec DUT(.op5(op5) ,
                .funct7(funct7) ,
                .ALUOP(ALUOP) , 
                .funct3(funct3) , 
                .ALUControl(ALUControl));
    initial
        begin
            op5 = 0; funct7 = 0; ALUOP = 0; funct3 = 0; #10;
            repeat(100)
            begin
                op5 = $random; funct7 = $random; ALUOP = $random; funct3 = $random;#10;
                case(ALUOP)
                    0 : if(ALUControl == 3'b000) $display("Pass");
                        else $display("Error : ALUOP = %b , ALUControl = %b" , ALUOP , ALUControl);
                    1 : if(ALUControl == 3'b010) $display("Pass");
                        else $display("Error : ALUOP = %b , ALUControl = %b" , ALUOP , ALUControl);
                    2 : 
                        case(funct3)
                            3'b000 : if(({op5 , funct7} == 2'b11) && (ALUControl == 3'b010)) $display("Pass");
                                     else if(ALUControl == 3'b000) $display("Pass");
                                     else $display("Error : ALUOP = %b , funct3 = %b , op5 = %d , funct7 = %d -> ALUControl = %b" 
                                                   , ALUOP , funct3 , op5 , funct7 , ALUControl);
                            3'b001 : if(ALUControl == 3'b001) $display("Pass");
                                     else $display("Error : ALUOP = %b , funct3 = %b , op5 = %d , funct7 = %d -> ALUControl = %b" 
                                                   , ALUOP , funct3 , op5 , funct7 , ALUControl);
                            3'b100 : if(ALUControl == 3'b100) $display("Pass");
                                     else $display("Error : ALUOP = %b , funct3 = %b , op5 = %d , funct7 = %d -> ALUControl = %b" 
                                                   , ALUOP , funct3 , op5 , funct7 , ALUControl);
                            3'b101 : if(ALUControl == 3'b101) $display("Pass");
                                     else $display("Error : ALUOP = %b , funct3 = %b , op5 = %d , funct7 = %d -> ALUControl = %b" 
                                                   , ALUOP , funct3 , op5 , funct7 , ALUControl);
                            3'b110 : if(ALUControl == 3'b110) $display("Pass");
                                     else $display("Error : ALUOP = %b , funct3 = %b , op5 = %d , funct7 = %d -> ALUControl = %b" 
                                                   , ALUOP , funct3 , op5 , funct7 , ALUControl);
                            3'b111 : if(ALUControl == 3'b111) $display("Pass");
                                     else $display("Error : ALUOP = %b , funct3 = %b , op5 = %d , funct7 = %d -> ALUControl = %b" 
                                                   , ALUOP , funct3 , op5 , funct7 , ALUControl);
                            default : if(ALUControl == 3'b000) $display("Pass");
                                     else $display("Error : ALUOP = %b , funct3 = %b , op5 = %d , funct7 = %d -> ALUControl = %b" 
                                                   , ALUOP , funct3 , op5 , funct7 , ALUControl);
                        endcase
                    default : if(ALUControl == 3'b000) $display("Pass");
                              else $display("Error : ALUOP = %b , ALUControl = %b" , ALUOP , ALUControl);
                endcase
            end
            #30; $stop;
        end
endmodule