module Data_Memory
	(
		input clk,
		input [31:0] Address,
		input [31:0] Write_data,
		input MEM_R_EN,
		input MEM_W_EN,
		output [31:0] Data
	);

	reg [31:0] memory [63:0]; 
	initial
	begin
  		//memory[32'd100] = 32'd255;
	end
	always @(posedge clk)
	begin
  		if(MEM_W_EN)
  			memory[Address] <= Write_data;
	end
	assign Data = (MEM_R_EN) && (Address < 32'd64) ? memory[Address] : 32'b0;

endmodule