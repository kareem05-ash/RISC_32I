module risc_top_tb();
    reg clk, areset;
    risc_top dut(.clk(clk), 
                 .areset(areset));
    //clk generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    integer i;
    //stimuls
    initial
    begin
        areset = 0; #10;
        areset = 1; #2000; //release areset 200 cycles
        for(i=0; i<64; i=i+1)
            $display("ram[%d] = %d", i, dut.dm.ram[i]);
        $stop;
    end
endmodule