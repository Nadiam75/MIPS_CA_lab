module IF_Stage_reg
	(
		input clk, 
		input rst,
		input flush,
		input hazard_freeze,
		input [31:0] PC_in, 
		input [31:0] Instruction_in,

		input freeze,

		output reg [31:0] PC, 
		output reg [31:0] Instruction
	);
	
	always@(posedge clk or posedge rst)
	begin
		if(rst)
		begin
			PC <= 32'b0;
			Instruction <= 32'b0;
		end
		else if (flush)
		  begin
		    Instruction <=32'b0 ;
		    end
		else if(!hazard_freeze && !freeze) 
		begin
			Instruction <= Instruction_in;
			PC <= PC_in;
		end
	end
endmodule