module next_pc_logic_tb();
    reg [31:0] PC;
    reg [31:0] ImmExt; 
    reg PCSrc;
    wire [31:0] NextPC;
    next_pc_logic DUT(.PC(PC) ,
                      .ImmExt(ImmExt) ,
                      .PCSrc(PCSrc) ,
                      .NextPC(NextPC));
    initial
    begin
        PC = $random; ImmExt = $random; PCSrc = 0;
        #10;
        if(NextPC == PC+4)
            $display("Pass : PCSrc = %d , PC = %h , ImmExt = %h" , PCSrc , PC , ImmExt);
        else
            $display("Error : PCSrc = %d , PC = %h , ImmExt = %h" , PCSrc , PC , ImmExt);
        #10;
        PC = $random; ImmExt = $random; PCSrc = 1;
        #10;
        if(NextPC == PC+ImmExt)
            $display("Pass : PCSrc = %d , PC = %h , ImmExt = %h" , PCSrc , PC , ImmExt);
        else
            $display("Error : PCSrc = %d , PC = %h , ImmExt = %h" , PCSrc , PC , ImmExt);
    end
endmodule