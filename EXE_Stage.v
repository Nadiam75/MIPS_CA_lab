module EXE_Stage
	(
	   
		input clk,		
		input [3:0] EXE_CMD,
		input [31:0] val1,
		input [31:0] val2,
		input [31:0] PC,
		input [1:0] Br_type,

		//Forwarding Signals
		input [1:0] sel_A, sel_B, sel_ST,
		input [31:0] reg_2,
		input [31:0] MEM_ALU_result, 
		input [31:0] WB_ALU_result,

		output [31:0] ALU_result,
		output reg [31:0] Br_Addr,
		output Br_taken,
		output [31:0] Src2_Val
	);
	
	wire [31:0] in_A , in_B ;
	
	always @(PC or val2) begin
		Br_Addr <= PC + {val2[29:0], 2'd0};
	end
	Condition_Check condition_check (
		.Br_type 			(Br_type), 
		.Val1 				(in_A), 
		.Src2_Val 			(Src2_Val), 
		.Branch_Taken 		(Br_taken)
	);
	MUX3TO1 MUXA (
		.a 					(val1),
		.b 					(MEM_ALU_result),
		.c 					(WB_ALU_result), 
		.sel 				(sel_A),
    	.res 				(in_A)
	);
	MUX3TO1 MUXB (
    	.a 					(val2),
    	.b 					(MEM_ALU_result),
    	.c 					(WB_ALU_result), 
		.sel 				(sel_B),
		.res 				(in_B)
	);
	MUX3TO1 MUXST (
		.a 					(reg_2),
		.b 					(MEM_ALU_result),
		.c 					(WB_ALU_result), 
		.sel 				(sel_ST),
		.res 				(Src2_Val)
	);
	ALU alu (
		.in1 				(in_A), 
		.in2 				(in_B), 
		.cmd 				(EXE_CMD), 
		.result 			(ALU_result)
	);

endmodule