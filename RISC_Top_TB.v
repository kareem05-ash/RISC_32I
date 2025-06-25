module risc_top_tb();
    reg clk;
    reg areset; 
    reg load;
    wire [31:0] PC;
    wire [31:0] Instr; 
    wire [31:0] Result;//WD3
    wire [31:0] ALUResult; 
    wire [31:0] Read_Data;  
    //Internal Signals
    reg PCSrc , ImmExt;
    reg ResultSrc;
    reg [2:0] ALUControl;
    reg ALUSrc;
    reg [31:0] A , B;
    reg [31:0] RD2;
    wire MemWrite;
    //DUT Instantiation
    risc_top DUT(.clk(clk) , 
                 .areset(areset) ,
                 .load(load) , 
                 .PC(PC) , 
                 .Instr(Instr) , 
                 .Result(Result) ,
                 .ALUResult(ALUResult) ,
                 .Read_Data(Read_Data));
    initial begin
        $dumpfile("risc_waveform.vcd");  
        $dumpvars(0, risc_top_tb);    
    end
    initial begin //clk generation
      clk = 0;
      forever #5 clk = ~clk;
    end
    initial begin
        $monitor("time = %t , PC = %h , Instr = %h , Result = %h , ALUResult = %h , Read_Data = %h" ,
                 $time , PC , Instr , Result , ALUResult , Read_Data);
    end
    initial 
        begin
            areset = 0; load = 0; #30;
            areset = 1; 
            @(negedge clk);@(negedge clk);
            //PC Assertion
            load = 1; ImmExt = $random; PCSrc = $random; @(negedge clk);
            if(PCSrc && PC == (ImmExt + 0 /*PC after areset = 0;*/))
                $display("Pass : PC Logic");
            else if(!PCSrc && PC == (ImmExt + 4))
                $display("Pass : PC Logic");
            else
                $display("Error : PC Logic");
            @(negedge clk);
            //Instruction Assertion
            if(PC == Instr)
                $display("Pass : Instr Read");
            else
                $display("Error : Instr Read");
            //Result Assertion
            ResultSrc = $random; #20;
            if(ResultSrc && Result == Read_Data)
                $display("Pass : Result");
            else if(!ResultSrc && Result == ALUResult)
                $display("Pass : Result");
            else
                $display("Error : Result");
            //ALUResult Assertion
            ALUControl = $random; A = 23423; B = 93832; #30;
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
            //ALUSrc Assertion
            ALUSrc = $random; RD2 = $random; ImmExt = $random; #20;
            if(ALUSrc && B == ImmExt)
                $display("Pass : ALUSrc");
            else if(!ALUSrc && B == RD2)
                $display("Pass : ALUSrc");
            else
                $display("Error : ALUSrc");
            #100;$stop;
        end
endmodule