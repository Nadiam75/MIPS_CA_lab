module MUX3TO1
	(
		input[31:0] a, b,c , 
		input [1:0]sel,
		output [31:0] res
	);
	assign res = (sel== 2'b00) ? a : (sel == 2'b01) ? b : (sel == 2'b10) ? c  : 2'bz ;
endmodule