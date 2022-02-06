module ALU 
  (
    input [31:0] in1,
    input [31:0] in2,
    input [3:0] cmd,
    output [31:0] result
  );

  reg [31:0] Y, var, x, g;
  
  always @(in1 or in2 or cmd)begin
    case (cmd)
      4'b0000:  Y = in1 + in2;
      4'b0010:  Y = in1 - in2;
      4'b0110:  Y = ~ (in1 | in2);
      4'b0100:  Y = in1 & in2;
      4'b0101:  Y = in1 | in2;
      4'b0111:  Y = in1 ^ in2;
      4'b1000:  Y = in1 << in2;
      4'b1010:  Y = in1 >> in2;
      4'b1001:  Y = $signed(in1) >>> in2;
    endcase       
  end

  assign result = Y;

endmodule