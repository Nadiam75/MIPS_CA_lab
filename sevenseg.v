module sevenseg
	(
		input [3:0]num, 
		output reg [6:0]disp
	);
	always@(num)
	begin
		case(num)
			4'b0000 : disp <= 7'b1000000;
			4'b0001 : disp <= 7'b1111001;
			4'b0010 : disp <= 7'b0100100;
			4'b0011 : disp <= 7'b0110000;
			4'b0100 : disp <= 7'b0011001;
			4'b0101 : disp <= 7'b0010010;
			4'b0110 : disp <= 7'b0000010;
			4'b0111 : disp <= 7'b1111000;
			4'b1000 : disp <= 7'b0000000;
			4'b1001 : disp <= 7'b0010000;
			4'b1010 : disp <= 7'b0001000;
			4'b1011 : disp <= 7'b0000000;
			4'b1100 : disp <= 7'b1000110;
			4'b1101 : disp <= 7'b1000000;
			4'b1110 : disp <= 7'b0000110;
			4'b1111 : disp <= 7'b0001110;
		endcase
	end
endmodule