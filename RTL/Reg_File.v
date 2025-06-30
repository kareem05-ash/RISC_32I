module reg_file 
( 
    input clk, 
    input areset,  // Active low areset
    input WE3,
    input [4:0] A1, A2, A3,
    input [31:0] WD3,
    output [31:0] RD1, RD2  
);
    reg [31:0] regs [31:1]; //x0 is excluded (word alligned)
    integer i;
    always @(posedge clk or negedge areset) 
        begin  
            if (!areset)                              
                for(i=1; i<32; i=i+1)  // starting from i=1 , this ignores x0, register
                    regs[i] <= 32'b0;
            else if (WE3)
                regs[A3] <= WD3;
        end
    //forcing x0 to be 0
    assign RD1 = (A1 == 5'b0)? 32'b0 : regs[A1]; 
    assign RD2 = (A2 == 5'b0)? 32'b0 : regs[A2];
endmodule