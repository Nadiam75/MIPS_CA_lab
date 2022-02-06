module Condition_Check
	(
		input [1:0] Br_type,
		input [31:0] Val1,
		input [31:0] Src2_Val,
		output Branch_Taken
	);
	assign Branch_Taken = ((Br_type == 2'b01) && (Val1 == 32'b0))? 1 :
						((Br_type == 2'b10) && (Val1 != Src2_Val))? 1 :
						(Br_type == 2'b11)? 1 :
						(Br_type == 2'b00)? 0 : 0;
endmodule