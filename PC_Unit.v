module pc_unit
(
    input clk ,
    input areset , 
    input load ,
    input PCSrc , 
    input[31:0] ImmExt ,
    output [31:0] PC
);
    wire [31:0] NextPC;
    next_pc_logic DUT0(.PC(PC) ,
                       .ImmExt(ImmExt) ,
                       .PCSrc(PCSrc) , 
                       .NextPC(NextPC));
    pc_reg DUT1(.clk(clk) , 
                .areset(areset) ,
                .load(load) , 
                .PC(PC) ,
                .NextPC(NextPC));

endmodule