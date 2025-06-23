module reg_file_tb();
    reg clk , areset , WE3;
    reg [4:0] A1 , A2 ,A3;
    reg [31:0] WD3;
    wire [31:0] RD1 , RD2;
    reg_file DUT(.clk(clk) ,
                 .areset(areset) , 
                 .WE3(WE3) , 
                 .A1(A1) ,
                 .A2(A2) ,
                 .A3(A3) ,
                 .WD3(WD3) ,
                 .RD1(RD1) ,
                 .RD2(RD2));
    initial
    begin
      clk = 0;
      forever #5 clk = ~clk;
    end
    integer i;
    initial
    begin
        areset = 0; WE3 = 0; A1 = 0; A2 = 0; A3 = 0; WD3 = 0; #20;
        for(i=0 ; i<32 ; i=i+1)
            if(DUT.register[i] == 0)
                $display("Pass ");
            else
                $display("Error ");
        areset = 1;#20;
        @(negedge clk);
        A3 = $random; WD3 = $random; WE3 = 1;
        @(negedge clk);
        if(DUT.register[A3] == WD3)
            $display("Pass : Write : areset = %d , A3 = %d , WD3 = %d , DUT.register[%d] = %d" , areset , A3 , WD3 , A3 , DUT.register[A3]);
        else
            $display("Error : Write : areset = %d , A3 = %d , WD3 = %d , DUT.register[%d] = %d" , areset , A3 , WD3 , A3 , DUT.register[A3]);
        A1 = A3; A2 = A3;
        #5;
        if(RD1 == WD3)
            $display("Pass : RD1");
        else
            $display("Error : RD1");
        if(RD2 == WD3)
            $display("Pass : RD2");
        else
            $display("Error : RD2");
        #30;$stop;
    end
endmodule