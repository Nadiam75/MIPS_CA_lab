module WB_Stage
	(
		input clk,
		input WB_en_in,
		//MEM Signals
		input MEM_R_EN,
		//memory Address
		input [31:0] ALU_result,
		
		input [31:0] Mem_read_value,
		input [4:0] Dest_in,

		output WB_en,
		output [31:0] Write_value,
		output [4:0] Dest
	);
	
	assign WB_en = WB_en_in;
	assign Dest = Dest_in;
	MUX2TO1 wb_mux (
		.a 				(Mem_read_value),
		.b 				(ALU_result),
		.sel 			(MEM_R_EN),
		.res 			(Write_value)
	);

endmodule