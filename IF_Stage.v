module IF_Stage
	(
		input clk, 
		input rst,
		input Br_taken,
		input hazard_freeze,
		input [31:0] Br_Addr,

		input freeze,

		output reg[31:0] PC,
		output [31:0] Instruction
	);
	
wire [31:0] PC_in;
	always @(posedge clk or posedge rst)
	begin
		if(rst)
			PC <= 32'b0;
		else if(freeze || hazard_freeze)
			PC <= PC_in;
		else
			PC <= PC_in + 32'd4;
	end
	MUX2TO1 pc_mux (
		.a				(Br_Addr),
		.b 				(PC),
		.sel 			(Br_taken),
		.res 			(PC_in)
	);
	Instruction_Memory inst_mem (
		.Address 		(PC_in),
		.Instruction 	(Instruction)
	);
endmodule