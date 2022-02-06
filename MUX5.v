
module MUX5
(
	input[4:0] a, b, 
	input sel,
	output [4:0] res);
assign res = sel ? a : b ;
endmodule





