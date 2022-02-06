module Registers_File
    (
        input clk,
        input rst,
        input [4:0] src1,
        input [4:0] src2,
        input [4:0] dest,
        input [31:0] Write_Val,
        input Write_EN,
        output [31:0] reg1,
        output [31:0] reg2
    );

    reg [31:0] Reg [0:31];
    integer i;
    //initial begin
    //  $readmemb("Regfile.txt", Reg);
    //end 
    always @(negedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 32; i = i + 1)
                Reg[i] <= 32'b0;
        end
        else if ((Write_EN) && (dest != 5'b0)) begin
            Reg[dest] <= Write_Val;
        end
    end
    assign reg1 = Reg[src1];
    assign reg2 = Reg[src2];

endmodule