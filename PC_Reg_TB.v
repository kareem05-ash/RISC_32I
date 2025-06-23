module pc_reg_tb();
    reg clk;
    reg areset;
    reg load;
    reg [31:0] NextPC; 
    wire [31:0] PC;
    pc_reg DUT(.clk(clk) ,
               .areset(areset) ,
               .load(load) ,
               .NextPC(NextPC) ,
               .PC(PC));
    initial //clk generatoin
    begin
      clk = 0;
      forever #5 clk = ~clk;
    end
    initial
    begin
        areset = 0; load = 0; NextPC = 0; #20;
        @(negedge clk);
        if(PC == 0)
            $display("Pass : areset = %d , PC = %h" , areset , PC);
        else
            $display("Error : areset = %d , PC = %h" , areset , PC);
        @(negedge clk);
        areset = 1; load = 1; NextPC = $random;
        @(negedge clk);
        if(PC == NextPC)
            $display("Pass : load = %d , NextPC = %h , PC = %h" , load , NextPC , PC);
        else
            $display("Error : load = %d , NextPC = %h , PC = %h" , load , NextPC , PC);
        @(negedge clk);
        areset = 1; load = 1; NextPC = 50;
        @(negedge clk); //Now PC = NextPC = 50 
        areset = 1; load = 0; NextPC = 60;
        @(negedge clk); //Now PC != NextPC
        if(PC == 50)
            $display("Pass : areset = %d , load = %d , PC = %h , NextPC = %h" , areset , load , PC , NextPC);
        else
            $display("Error : areset = %d , load = %d , PC = %h , NextPC = %h" , areset , load , PC , NextPC);
        #20;$stop;
    end
endmodule