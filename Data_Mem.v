module data_mem
(
    input clk ,
    input WE ,
    input [31:0] A ,
    input [31:0] WD ,
    output [31:0] RD
);
    reg [31:0] mem [0:63];
    assign RD = mem[A];
    always@(posedge clk)
        begin
            if(WE)
                mem[A] <= WD;
        end
endmodule