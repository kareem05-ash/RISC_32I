module pc_unit
(
    input clk ,
    input areset , 
    input load ,
    input PCSrc , 
    input[31:0] ImmExt ,
    output [31:0] PC
);
    wire [31:0] PCNext;
    next_pc_logic NPCL(.PC(PC) ,
                       .ImmExt(ImmExt) ,
                       .PCSrc(PCSrc) , 
                       .PCNext(PCNext));
    pc_reg PCR(.clk(clk) , 
                .areset(areset) ,
                .load(load) , 
                .PCNext(PCNext) ,
                .PC(PC));
endmodule