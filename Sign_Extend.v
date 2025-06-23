module sign_extend
(
input [31:7]Instr;
input [1:0]ImmSrc;
output reg [31:0] ImmExt;

)

case (ImmSrc)
begin
    2'b00: assign ImmExt={{20Instr[31]},Instr[31:20]};
    2'b01: assign ImmExt={{20Instr[31]},Instr[31:25],Instr[11:7]};
    2'b10: assign ImmExt={{20Instr[31]},Instr[7],Instr[30:25],Instr[11:8],i'b0};
    default:  assign ImmExt=32'b0;
end

endcase
endmodule