module Address_Mapping
	(
		input [31:0] ALU_result,
		output [31:0] Data_memory_address
	);

	assign Data_memory_address = (ALU_result - 32'd1024)>>2;

endmodule