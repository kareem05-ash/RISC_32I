module alu_tb();
    reg [31:0] A , B;
    reg [2:0] ALUControl;
    wire Zero , Sign_Flag;
    wire [31:0] ALUResult;
    alu DUT(.A(A) ,
            .B(B) , 
            .ALUControl(ALUControl) , 
            .Zero(Zero) , 
            .Sign_Flag(Sign_Flag) , 
            .ALUResult(ALUResult));
    integer i;
    initial
        begin
            A = 0; B = 0; #10;
            for(i=0 ; i<20 ; i=i+1)
                begin
                    A = 3*i; B = i+2; #10;
                    case(ALUControl)
                        3'b000 : if(ALUResult == A + B) $display("Pass");
                                 else $display("Error : ALUControl = %b , A = %d , B = %d , ALUResult = %d", ALUControl , A , B , ALUResult);
                        3'b001 : if(ALUResult == A <<B) $display("Pass");
                                 else $display("Error : ALUControl = %b , A = %d , B = %d , ALUResult = %d", ALUControl , A , B , ALUResult);
                        3'b010 : if(ALUResult == A - B) $display("Pass");
                                 else $display("Error : ALUControl = %b , A = %d , B = %d , ALUResult = %d", ALUControl , A , B , ALUResult);
                        3'b100 : if(ALUResult == A ^ B) $display("Pass");
                                 else $display("Error : ALUControl = %b , A = %d , B = %d , ALUResult = %d", ALUControl , A , B , ALUResult);
                        3'b101 : if(ALUResult == A >>B) $display("Pass");
                                 else $display("Error : ALUControl = %b , A = %d , B = %d , ALUResult = %d", ALUControl , A , B , ALUResult);
                        3'b110 : if(ALUResult == A | B) $display("Pass");
                                 else $display("Error : ALUControl = %b , A = %d , B = %d , ALUResult = %d", ALUControl , A , B , ALUResult);
                        3'b111 : if(ALUResult == A & B) $display("Pass");
                                 else $display("Error : ALUControl = %b , A = %d , B = %d , ALUResult = %d", ALUControl , A , B , ALUResult);
                        default : if(ALUResult == 0) $display("Pass");
                                 else $display("Error : ALUControl = %b , A = %d , B = %d , ALUResult = %d", ALUControl , A , B , ALUResult);
                    endcase
                end
            #10; A = $random;#10; B = A; ALUControl = 2; #10; //Subtraction
            if(Zero)
                $display("Pass : zero flag");
            else
                $display("Error : zero flag");
            #10; A = $random; B = $random; ALUControl = $random; #10;
            if(Sign_Flag == ALUResult[31])
                $display("Pass : sign flag");
            else 
                $display("Error : sign flag");
            #30;$stop;
        end
endmodule