module pc_reg
(
    input clk ,
    input areset , 
    input load , 
    input [31:0] NextPC , 
    output reg [31:0] PC
);
always@(posedge clk or negedge areset)
    begin
      if(!areset)
        PC <= 0;
      else if(load)
        PC <= NextPC;
    end
endmodule