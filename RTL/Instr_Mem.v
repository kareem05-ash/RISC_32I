module instr_mem
(
    input [31:0] A ,                    //PC, the program counter output
    output [31:0] RD                    //Instr, the instruction to be excuted
);
    reg [31:0] ROM [63:0];              //Read Only Memory
    initial
    begin
        $readmemh("program.txt" , ROM); //assigning the FIBONACCI code to the ROM
    end  
    assign RD = ROM [A[31:2]];          //Asyncronous Read operation
endmodule