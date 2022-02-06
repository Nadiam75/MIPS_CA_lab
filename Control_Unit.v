module Control_Unit
	(
		input [5:0] opcode, 
		output reg [3:0] alu_command,
		output reg mem_read, 
		output reg mem_write, 
		output reg wb_enable, 
		output reg is_immediate,
		output reg [1:0] branch,
		output reg is_single_source
	);
	always@(*)
	begin
		mem_read = 1'b0;
		mem_write = 1'b0;
		wb_enable = 1'b0;
		is_immediate = 1'b0;
		branch = 2'b0;
		alu_command = 4'b0;
		is_single_source = 1'b0;
	case(opcode)
		6'd0 :
			begin
			mem_read = 1'b0;
			mem_write = 1'b0;
			wb_enable = 1'b0;
			is_immediate = 1'b0;
			branch = 2'b0;
			alu_command = 4'bx;
			is_single_source = 1'b0;
			end
		6'd1 :
			begin
			mem_read = 1'b0;
			mem_write = 1'b0;
			wb_enable = 1'b1;
			is_immediate = 1'b0;
			branch = 2'b0;
			alu_command = 4'b0;
			is_single_source = 1'b0;
			end
		6'd3 :
			begin
			mem_read = 1'b0;
			mem_write = 1'b0;
			wb_enable = 1'b1;
			is_immediate = 1'b0;
			branch = 2'b0;
			alu_command = 4'b0010;
			is_single_source = 1'b0;
			end
		6'd5 :
			begin
			mem_read = 1'b0;
			mem_write = 1'b0;
			wb_enable = 1'b1;
			is_immediate = 1'b0;
			branch = 2'b0;
			alu_command = 4'b0100;
			is_single_source = 1'b0;
			end
		6'd6 :
			begin
			mem_read = 1'b0;
			mem_write = 1'b0;
			wb_enable = 1'b1;
			is_immediate = 1'b0;
			branch = 2'b0;
			alu_command = 4'b0101;
			is_single_source = 1'b0;
			end
		6'd7 :
			begin
			mem_read = 1'b0;
			mem_write = 1'b0;
			wb_enable = 1'b1;
			is_immediate = 1'b0;
			branch = 2'b0;
			alu_command = 4'b0110;
			is_single_source = 1'b0;
			end
		6'd8 :
			begin
			mem_read = 1'b0;
			mem_write = 1'b0;
			wb_enable = 1'b1;
			is_immediate = 1'b0;
			branch = 2'b0;
			alu_command = 4'b0111;
			is_single_source = 1'b0;
			end
		6'd9 :
			begin
			mem_read = 1'b0;
			mem_write = 1'b0;
			wb_enable = 1'b1;
			is_immediate = 1'b0;
			branch = 2'b0;
			alu_command = 4'b1000;
			end
		6'd10 :
			begin
			mem_read = 1'b0;
			mem_write = 1'b0;
			wb_enable = 1'b1;
			is_immediate = 1'b0;
			branch = 2'b0;
			alu_command = 4'b1000;
			is_single_source = 1'b0;
			end
		6'd11 :
			begin
			mem_read = 1'b0;
			mem_write = 1'b0;
			wb_enable = 1'b1;
			is_immediate = 1'b0;
			branch = 2'b0;
			alu_command = 4'b1001;
			is_single_source = 1'b0;
			end
		6'd12 :
			begin
			mem_read = 1'b0;
			mem_write = 1'b0;
			wb_enable = 1'b1;
			is_immediate = 1'b0;
			branch = 2'b0;
			alu_command = 4'b1010;
			is_single_source = 1'b0;
			end
		6'd32 :
			begin
			mem_read = 1'b0;
			mem_write = 1'b0;
			wb_enable = 1'b1;
			is_immediate = 1'b1;
			branch = 2'b0;
			alu_command = 4'b0;
			is_single_source = 1'b1;
			end
		6'd33 :
			begin
			mem_read = 1'b0;
			mem_write = 1'b0;
			wb_enable = 1'b1;
			is_immediate = 1'b1;
			branch = 2'b0;
			alu_command = 4'b0010;
			is_single_source = 1'b1;
			end
		6'd36 :
			begin
			mem_read = 1'b1;
			mem_write = 1'b0;
			wb_enable = 1'b1;
			is_immediate = 1'b1;
			branch = 2'b0;
			alu_command = 4'b0000;
			is_single_source = 1'b1;
			end
		6'd37 :
			begin
			mem_read = 1'b0;
			mem_write = 1'b1;
			wb_enable = 1'b0;
			is_immediate = 1'b1;
			branch = 2'b0;
			alu_command = 4'b0000;
			is_single_source = 1'b0;
			end
		6'd40 :
			begin
			mem_read = 1'b0;
			mem_write = 1'b0;
			wb_enable = 1'b0;
			is_immediate = 1'b1;
			branch = 2'b01;
			alu_command = 4'bx;
			is_single_source = 1'b1;
			end
		6'd41 :
			begin
			mem_read = 1'b0;
			mem_write = 1'b0;
			wb_enable = 1'b0;
			is_immediate = 1'b1;
			branch = 2'b10;
			alu_command = 4'bx;
			is_single_source = 1'b0;
			end
		6'd42 :
			begin
			mem_read = 1'b0;
			mem_write = 1'b0;
			wb_enable = 1'b0;
			is_immediate = 1'b1;
			branch = 2'b11;
			alu_command = 4'bx;
			is_single_source = 1'b1;
			end
	endcase
end

endmodule