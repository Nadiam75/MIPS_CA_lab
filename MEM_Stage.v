module MEM_Stage
	(
		
		input clk,
		input rst ,
		//MEM Signals
		input MEM_R_EN_in,
		input MEM_W_EN_in,

		input [31:0] ALU_result_in,
		input [31:0] ST_val,
    	input wb_en_mem_in ,

		//MEM Signals
		output [31:0] MEM_read_value,
		output MEM_WB_EN_MUX,  
		
		inout [15:0] SRAM_DQ,		// SRAM Data bus 16 Bits
		output [17:0] SRAM_ADDR,	// SRAM Address bus 18 Bits
		output SRAM_UB_N,			// SRAM High-byte Data Mask
		output SRAM_LB_N,			// SRAM Low-byte Data Mask
		output SRAM_WE_N,			// SRAM Write Enable
		output SRAM_CE_N,			// SRAM Chip Enable
		output SRAM_OE_N,			// SRAM Output Enable
				
		output freeze

	);
	
	wire [31:0] Address;
	wire ready;
	
	// Address_Mapping address_mapping (
	// 	.ALU_result 			(ALU_result_in),
	// 	.Data_memory_address 	(Address)
	// );
	// Data_Memory data_memory (
	// 	.clk 					(clk),
	// 	.Address 				(Address), 
	// 	.Write_data 			(ST_val),
	// 	.MEM_R_EN 				(MEM_R_EN_in), 
	// 	.MEM_W_EN 				(MEM_W_EN_in),
	// 	.Data 					(MEM_read_value)
	// );

	SRAM_Controller SRAM_Controller (
		.clk 					(clk),
		.rst  					(rst),
		//From Memory Stage
		.wr_en 					(MEM_W_EN_in),
		.rd_en 					(MEM_R_EN_in), 
		.address 				(ALU_result_in),
		.writeData 				(ST_val),
		
		//To Next Stage
   		.readData 				(MEM_read_value),

		//For freeze Other Stage
		.ready 					(ready),

		.SRAM_DQ  				(SRAM_DQ),
		.SRAM_ADDR 				(SRAM_ADDR),
		.SRAM_UB_N 				(SRAM_UB_N),
		.SRAM_LB_N 				(SRAM_LB_N),
		.SRAM_WE_N 				(SRAM_WE_N),
		.SRAM_CE_N 				(SRAM_CE_N),
		.SRAM_OE_N				(SRAM_OE_N)
	);
	
	assign MEM_WB_EN_MUX = ready? wb_en_mem_in : 0;
	assign freeze = ~ready;
	
endmodule