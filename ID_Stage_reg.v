module ID_Stage_reg
	(
		input clk,
		input rst,
		//from EXE Stage
		input flush,
		//to stage registers
		input [4:0] src1_in ,
		input [4:0] src2_in ,
		input [4:0] Dest_in,
		input [31:0] Reg2_in,
		input [31:0] Val2_in,
		input [31:0] Val1_in,
		input [31:0] PC_in,
		input [1:0] Br_type_in,
		input [3:0] EXE_CMD_in,
		input MEM_R_EN_in,
		input MEM_W_EN_in,
		input WB_EN_in,

		input freeze,

		//to stage registers
		output reg [4:0] Dest,
		output reg [31:0] Reg2,
		output reg [31:0] Val2,
		output reg [31:0] Val1,
		output reg [31:0] PC_out,
		output reg [1:0] Br_type,
		output reg [3:0] EXE_CMD,
		output reg MEM_R_EN,
		output reg MEM_W_EN,
		output reg WB_EN ,
		output reg [4:0] src1_out ,
		output reg [4:0] src2_out 
	);

//   always@(posedge clk or posedge rst or posedge flush)
	always@(posedge clk or posedge rst)
	begin
		if(rst )
		begin
			EXE_CMD <= 0;
			MEM_R_EN <= 0;
			MEM_W_EN <= 0;
			WB_EN <= 0; 
			PC_out <= 0;
			Br_type <= 0;
			Dest <= 0;
			Val1 <= 0;
			Val2 <= 0;
			Reg2 <= 0;
			src1_out <= 5'b0 ;
			src2_out <= 5'b0 ;
		end 
		else if (flush) begin
		  EXE_CMD <= 0;
			MEM_R_EN <= 0;
			MEM_W_EN <= 0;
			WB_EN <= 0; 
			PC_out <= 0;
			Br_type <= 0;
			Dest <= 0;
			Val1 <= 0;
			Val2 <= 0;
			Reg2 <= 0;
			src1_out <= 5'b0 ;
			src2_out <= 5'b0 ;
		  
		  end
		
		else if(!freeze) begin
			EXE_CMD <= EXE_CMD_in;
			MEM_R_EN <= MEM_R_EN_in;
			MEM_W_EN <= MEM_W_EN_in;
			WB_EN <= WB_EN_in; 
			PC_out <= PC_in;
			Br_type <= Br_type_in;
			Dest <= Dest_in;
			Val1 <= Val1_in;
			Val2 <= Val2_in;
			Reg2 <= Reg2_in;
			src1_out <= src1_in ;
			src2_out <= src2_in ;
		end
	end
endmodule