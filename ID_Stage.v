module ID_Stage
	(
		input clk, 
		input rst,
		//From IF
		input [31:0] Instruction,
		//From WB Stage
		input [31:0] WB_Data,
		input [4:0] WB_Dest,
		input WB_Write_Enable,
		//From EXE Stage for hazard detect
		input [4:0] EXE_Dest,
		input Exe_WB_EN,
		//from MEM for hazard detect
		input [4:0] MEM_Dest,
		input MEM_WB_EN,
		//for forwarding hazard detect
		input is_forward,
		input MEM_R_EN_regout,
		//to stage registers
		output [31:0]Val1, Val2, Reg2, 
		output [4:0] Dest, 
		output [1:0] Branch_Type,
		output Br_Taken, //why
		output  [3:0] EXE_CMD,
		//MEM Signals
		output  MEM_R_EN,
		output  MEM_W_EN,
		//Write Back Enable
		output  WB_EN,
		//these outputs
		output Hazard_Detected_Signal,
		output [4:0] src1,
		output [4:0] src2  
		
	);
	
	wire [31:0] signed_out;
	wire MEM_R_EN_ctrl, MEM_W_EN_ctrl, WB_EN_ctrl, is_Imm_ctrl;
	wire [3:0] EXE_CMD_ctrl;
	wire [1:0] Branch_Type_ctrl;
	wire is_Imm, single_src;

	Registers_File registers_file (
		.clk 				(clk),
		.rst 				(rst),
		.src1				(Instruction[25:21]),
		.src2 				(Instruction[20:16]),
		.dest 				(WB_Dest), 
		.Write_Val 			(WB_Data), 
		.Write_EN 			(WB_Write_Enable), 
		.reg1 				(Val1), 
		.reg2 				(Reg2)
	);
	Sign_Extend sign_extend (
		.in 				(Instruction[15:0]), 
		.out 				(signed_out)
	);
	MUX2TO1 mux_reg2 (
		.a 					(signed_out), 
		.b 					(Reg2), 
		.sel 				(is_Imm), 
		.res 				(Val2)
	);
	MUX5 mux_dest (
		.a 					(Instruction[20:16]), 
		.b 					(Instruction[15:11]), 
		.sel 				(is_Imm), 
		.res 				(Dest)
	);
	Hazard_Detection_Unit hazard_detection (
		.is_forward 		(is_forward),
		.single_source 		(single_src),
		.src1 				(Instruction[25:21]),
		.src2 				(Instruction[20:16]),
	 	.Exe_Dest			(EXE_Dest),
		.Exe_WB_EN 			(Exe_WB_EN),
		.Mem_Dest			(MEM_Dest),
		.Mem_WB_EN 			(MEM_WB_EN),
		.Exe_RD_EN 			(MEM_R_EN_regout),
		.Hazard_Detected 	(Hazard_Detected_Signal)
	);
	MUX5 hazard_mux1 (
		.a 					(5'b0),
		.b 					({MEM_R_EN_ctrl, MEM_W_EN_ctrl, WB_EN_ctrl, Branch_Type_ctrl}),
		.sel 				(Hazard_Detected_Signal),
		.res 				({MEM_R_EN, MEM_W_EN, WB_EN, Branch_Type})
	);
	MUX5 hazard_mux2 (
		.a 					(5'b0),
		.b 					({EXE_CMD_ctrl, is_Imm_ctrl}),
		.sel 				(Hazard_Detected_Signal),
		.res 				({EXE_CMD, is_Imm})
	);
	Control_Unit controller (
		.opcode 			(Instruction[31:26]), 
		.alu_command 		(EXE_CMD_ctrl), 
		.mem_read 			(MEM_R_EN_ctrl), 
		.mem_write 			(MEM_W_EN_ctrl), 
		.wb_enable 			(WB_EN_ctrl), 
		.is_immediate 		(is_Imm_ctrl), 
		.branch 			(Branch_Type_ctrl),
		.is_single_source	(single_src)
	);
	

	assign Br_Taken = (Instruction[31:29] == 3'b101)? 1'b1 : 1'b0;
	assign src1 = Instruction[25:21];
  	assign src2 = Instruction[20:16];
endmodule