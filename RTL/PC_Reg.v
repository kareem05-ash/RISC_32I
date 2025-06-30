module pc_reg
(
    input clk,
    input areset, 
    input load, 
    input [31:0] PCNext, 
    output reg [31:0] PC
);
    always @(posedge clk or negedge areset) 
      begin
          if (!areset) 
            begin
                PC <= 0;
                $display("PC: Reset to 0");
            end
          else if (load) 
            begin
                PC <= PCNext;
                $display("PC: %h → %h", PC, PCNext);
            end
      end
endmodule