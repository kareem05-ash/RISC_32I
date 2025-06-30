module data_mem
(
    input clk ,                          //clock
    input WE ,                           //MemWrite
    input [31:0] A ,                     //ALUResult
    input [31:0] WD ,                    //Write Data , RD2 to be written in the address A of the ram
    output [31:0] RD                     //ReadData
);
    reg [31:0] ram [63:0];
    assign RD = ram[A[31:2]];            //Word Alligned => the least significant 2 bits are ignored
    always@(posedge clk) 
        begin
            if(WE)
                ram [A[31:2]] <= WD;     //sycronous write to the ram (with the posedge of clk)
        end
endmodule