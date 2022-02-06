
module Sign_Extend
	(
		input [15:0] in,
		output [31:0] out
	);
	assign out = {in[7], in[7], in[7], in[7], in[7], in[7], in[7], in[7], in[7], in[7], in[7], in[7], in[7], in[7], in[7], in[7], in[15:0]};
endmodule
