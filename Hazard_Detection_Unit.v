module Hazard_Detection_Unit (
  	input is_forward ,
	input single_source,
	input [4:0] src1,
	input [4:0] src2,
	input [4:0] Exe_Dest,
	input Exe_WB_EN,
	input [4:0] Mem_Dest,
	input Mem_WB_EN,
	input Exe_RD_EN,
	output Hazard_Detected
);
 	wire Hazard_Detected_nf, Hazard_Detected_f;

	assign Hazard_Detected_nf = (single_source && Exe_Dest == src1 && Exe_WB_EN) ? 1 :
		 (single_source && src1 == Mem_Dest && Mem_WB_EN) ? 1 :
		 (!single_source && (Exe_Dest == src1 || Exe_Dest == src2) && Exe_WB_EN) ? 1 :
		 (!single_source && (src1 == Mem_Dest || src2 == Mem_Dest) && Mem_WB_EN) ? 1 : 0;

	assign Hazard_Detected_f = 
		((Exe_Dest == src1 || (Exe_Dest == src2 && !single_source)) && Exe_Dest != 5'b0 && Exe_RD_EN)? 1 : 0;

	assign  Hazard_Detected = is_forward ? Hazard_Detected_f : Hazard_Detected_nf;
endmodule