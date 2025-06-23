module reg_file 
( 
    input clk,rst,WE;
    input [4:0]A1,A2,A3;
     input [31:0] WD3;
   output reg [31:0] RD1,RD2;
    
)

reg [31:0] register[31:0];
interer i;

always@(posedge clk)
begin 
    if (!rst)
        for(i=0;i<32;i=i+1)
        register[i]<=32'b0;
    
    else if(WE)
    registor[A3]<=WD3;


end
assign RD1=register[A1];
assign RD2=register[A2];

endmodule