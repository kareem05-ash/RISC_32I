module sign_extend (
    input [31:0] In, //Instructions 
    input [1:0] ImmSrc,    
    output reg [31:0] ImmExt
);
    always @(*) begin
        case (ImmSrc)
            2'b00: ImmExt = {{20{In[31]}}, In[31:20]};
            2'b01: ImmExt = {{20{In[31]}}, In[31:25], In[11:7]};
            2'b10: ImmExt = {{20{In[31]}}, In[7], In[30:25], In[11:8], 1'b0};
            default: ImmExt = 32'bx;
        endcase
    end
endmodule