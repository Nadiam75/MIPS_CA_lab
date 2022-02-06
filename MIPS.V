// ============================================================================
// Copyright (c) 2012 by Terasic Technologies Inc.
// ============================================================================
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development
//   Kits made by Terasic.  Other use of this code, including the selling
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use
//   or functionality of this code.
//
// ============================================================================
//
//  Terasic Technologies Inc
//  9F., No.176, Sec.2, Gongdao 5th Rd, East Dist, Hsinchu City, 30070. Taiwan
//
//
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// ============================================================================
//
// Major Functions:	DE2 TOP LEVEL
//
// ============================================================================
//
// Revision History :
// ============================================================================
//   Ver  :| Author            :| Mod. Date :| Changes Made:
//   V1.0 :| Johnny Chen       :| 05/08/19  :|      Initial Revision
//   V1.1 :| Johnny Chen       :| 05/11/16  :|      Added FLASH Address FL_ADDR[21:20]
//   V1.2 :| Johnny Chen       :| 05/11/16  :|		Fixed ISP1362 INT/DREQ Pin Direction.
//   V1.3 :| Johnny Chen       :| 06/11/16  :|		Added the Dedicated TV Decoder Line-Locked-Clock Input
//													            for DE2 v2.X PCB.
//   V1.5 :| Eko    Yan        :| 12/01/30  :|      Update to version 11.1 sp1.
// ============================================================================

module MIPS
	(
		////////////////////	Clock Input	 	////////////////////
		CLOCK_27,						//	27 MHz
		CLOCK_50,						//	50 MHz
		EXT_CLOCK,						//	External Clock
		////////////////////	Push Button		////////////////////
		KEY,							//	Pushbutton[3:0]
		////////////////////	DPDT Switch		////////////////////
		SW,								//	Toggle Switch[17:0]
		////////////////////	7-SEG Dispaly	////////////////////
		HEX0,							//	Seven Segment Digit 0
		HEX1,							//	Seven Segment Digit 1
		HEX2,							//	Seven Segment Digit 2
		HEX3,							//	Seven Segment Digit 3
		HEX4,							//	Seven Segment Digit 4
		HEX5,							//	Seven Segment Digit 5
		HEX6,							//	Seven Segment Digit 6
		HEX7,							//	Seven Segment Digit 7
		////////////////////////	LED		////////////////////////
		LEDG,							//	LED Green[8:0]
		LEDR,							//	LED Red[17:0]
		////////////////////////	UART	////////////////////////
		//UART_TXD,						//	UART Transmitter
		//UART_RXD,						//	UART Receiver
		////////////////////////	IRDA	////////////////////////
		//IRDA_TXD,						//	IRDA Transmitter
		//IRDA_RXD,						//	IRDA Receiver
		/////////////////////	SDRAM Interface		////////////////
		DRAM_DQ,						//	SDRAM Data bus 16 Bits
		DRAM_ADDR,						//	SDRAM Address bus 12 Bits
		DRAM_LDQM,						//	SDRAM Low-byte Data Mask
		DRAM_UDQM,						//	SDRAM High-byte Data Mask
		DRAM_WE_N,						//	SDRAM Write Enable
		DRAM_CAS_N,						//	SDRAM Column Address Strobe
		DRAM_RAS_N,						//	SDRAM Row Address Strobe
		DRAM_CS_N,						//	SDRAM Chip Select
		DRAM_BA_0,						//	SDRAM Bank Address 0
		DRAM_BA_1,						//	SDRAM Bank Address 0
		DRAM_CLK,						//	SDRAM Clock
		DRAM_CKE,						//	SDRAM Clock Enable
		////////////////////	Flash Interface		////////////////
		FL_DQ,							//	FLASH Data bus 8 Bits
		FL_ADDR,						//	FLASH Address bus 22 Bits
		FL_WE_N,						//	FLASH Write Enable
		FL_RST_N,						//	FLASH Reset
		FL_OE_N,						//	FLASH Output Enable
		FL_CE_N,						//	FLASH Chip Enable
		////////////////////	SRAM Interface		////////////////
		SRAM_DQ,						//	SRAM Data bus 16 Bits
		SRAM_ADDR,						//	SRAM Address bus 18 Bits
		SRAM_UB_N,						//	SRAM High-byte Data Mask
		SRAM_LB_N,						//	SRAM Low-byte Data Mask
		SRAM_WE_N,						//	SRAM Write Enable
		SRAM_CE_N,						//	SRAM Chip Enable
		SRAM_OE_N,						//	SRAM Output Enable
		////////////////////	ISP1362 Interface	////////////////
		OTG_DATA,						//	ISP1362 Data bus 16 Bits
		OTG_ADDR,						//	ISP1362 Address 2 Bits
		OTG_CS_N,						//	ISP1362 Chip Select
		OTG_RD_N,						//	ISP1362 Write
		OTG_WR_N,						//	ISP1362 Read
		OTG_RST_N,						//	ISP1362 Reset
		OTG_FSPEED,						//	USB Full Speed,	0 = Enable, Z = Disable
		OTG_LSPEED,						//	USB Low Speed, 	0 = Enable, Z = Disable
		OTG_INT0,						//	ISP1362 Interrupt 0
		OTG_INT1,						//	ISP1362 Interrupt 1
		OTG_DREQ0,						//	ISP1362 DMA Request 0
		OTG_DREQ1,						//	ISP1362 DMA Request 1
		OTG_DACK0_N,					//	ISP1362 DMA Acknowledge 0
		OTG_DACK1_N,					//	ISP1362 DMA Acknowledge 1
		////////////////////	LCD Module 16X2		////////////////
		LCD_ON,							//	LCD Power ON/OFF
		LCD_BLON,						//	LCD Back Light ON/OFF
		LCD_RW,							//	LCD Read/Write Select, 0 = Write, 1 = Read
		LCD_EN,							//	LCD Enable
		LCD_RS,							//	LCD Command/Data Select, 0 = Command, 1 = Data
		LCD_DATA,						//	LCD Data bus 8 bits
		////////////////////	SD_Card Interface	////////////////
		//SD_DAT,							//	SD Card Data
		//SD_WP_N,						   //	SD Write protect
		//SD_CMD,							//	SD Card Command Signal
		//SD_CLK,							//	SD Card Clock
		////////////////////	USB JTAG link	////////////////////
		TDI,  							// CPLD -> FPGA (data in)
		TCK,  							// CPLD -> FPGA (clk)
		TCS,  							// CPLD -> FPGA (CS)
	   TDO,  							// FPGA -> CPLD (data out)
		////////////////////	I2C		////////////////////////////
		I2C_SDAT,						//	I2C Data
		I2C_SCLK,						//	I2C Clock
		////////////////////	PS2		////////////////////////////
		PS2_DAT,						//	PS2 Data
		PS2_CLK,						//	PS2 Clock
		////////////////////	VGA		////////////////////////////
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK,						//	VGA BLANK
		VGA_SYNC,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B,  						//	VGA Blue[9:0]
		////////////	Ethernet Interface	////////////////////////
		ENET_DATA,						//	DM9000A DATA bus 16Bits
		ENET_CMD,						//	DM9000A Command/Data Select, 0 = Command, 1 = Data
		ENET_CS_N,						//	DM9000A Chip Select
		ENET_WR_N,						//	DM9000A Write
		ENET_RD_N,						//	DM9000A Read
		ENET_RST_N,						//	DM9000A Reset
		ENET_INT,						//	DM9000A Interrupt
		ENET_CLK,						//	DM9000A Clock 25 MHz
		////////////////	Audio CODEC		////////////////////////
		AUD_ADCLRCK,					//	Audio CODEC ADC LR Clock
		AUD_ADCDAT,						//	Audio CODEC ADC Data
		AUD_DACLRCK,					//	Audio CODEC DAC LR Clock
		AUD_DACDAT,						//	Audio CODEC DAC Data
		AUD_BCLK,						//	Audio CODEC Bit-Stream Clock
		AUD_XCK,						//	Audio CODEC Chip Clock
		////////////////	TV Decoder		////////////////////////
		TD_DATA,    					//	TV Decoder Data bus 8 bits
		TD_HS,							//	TV Decoder H_SYNC
		TD_VS,							//	TV Decoder V_SYNC
		TD_RESET,						//	TV Decoder Reset
		TD_CLK27,                  //	TV Decoder 27MHz CLK
		////////////////////	GPIO	////////////////////////////
		GPIO_0,							//	GPIO Connection 0
		GPIO_1							//	GPIO Connection 1
	);

////////////////////////	Clock Input	 	////////////////////////
input		   	CLOCK_27;				//	27 MHz
input		   	CLOCK_50;				//	50 MHz
input			   EXT_CLOCK;				//	External Clock
////////////////////////	Push Button		////////////////////////
input	   [3:0]	KEY;					//	Pushbutton[3:0]
////////////////////////	DPDT Switch		////////////////////////
input	  [17:0]	SW;						//	Toggle Switch[17:0]
////////////////////////	7-SEG Dispaly	////////////////////////
output	[6:0]	HEX0;					//	Seven Segment Digit 0
output	[6:0]	HEX1;					//	Seven Segment Digit 1
output	[6:0]	HEX2;					//	Seven Segment Digit 2
output	[6:0]	HEX3;					//	Seven Segment Digit 3
output	[6:0]	HEX4;					//	Seven Segment Digit 4
output	[6:0]	HEX5;					//	Seven Segment Digit 5
output	[6:0]	HEX6;					//	Seven Segment Digit 6
output	[6:0]	HEX7;					//	Seven Segment Digit 7
////////////////////////////	LED		////////////////////////////
output	[8:0]	LEDG;					//	LED Green[8:0]
output  [17:0]	LEDR;					//	LED Red[17:0]
////////////////////////////	UART	////////////////////////////
//output			UART_TXD;				//	UART Transmitter
//input			   UART_RXD;				//	UART Receiver
////////////////////////////	IRDA	////////////////////////////
//output			IRDA_TXD;				//	IRDA Transmitter
//input			   IRDA_RXD;				//	IRDA Receiver
///////////////////////		SDRAM Interface	////////////////////////
inout	  [15:0]	DRAM_DQ;				//	SDRAM Data bus 16 Bits
output  [11:0]	DRAM_ADDR;				//	SDRAM Address bus 12 Bits
output			DRAM_LDQM;				//	SDRAM Low-byte Data Mask
output			DRAM_UDQM;				//	SDRAM High-byte Data Mask
output			DRAM_WE_N;				//	SDRAM Write Enable
output			DRAM_CAS_N;				//	SDRAM Column Address Strobe
output			DRAM_RAS_N;				//	SDRAM Row Address Strobe
output			DRAM_CS_N;				//	SDRAM Chip Select
output			DRAM_BA_0;				//	SDRAM Bank Address 0
output			DRAM_BA_1;				//	SDRAM Bank Address 0
output			DRAM_CLK;				//	SDRAM Clock
output			DRAM_CKE;				//	SDRAM Clock Enable
////////////////////////	Flash Interface	////////////////////////
inout	  [7:0]	FL_DQ;					//	FLASH Data bus 8 Bits
output [21:0]	FL_ADDR;				//	FLASH Address bus 22 Bits
output			FL_WE_N;				//	FLASH Write Enable
output			FL_RST_N;				//	FLASH Reset
output			FL_OE_N;				//	FLASH Output Enable
output			FL_CE_N;				//	FLASH Chip Enable
////////////////////////	SRAM Interface	////////////////////////
inout	 [15:0]	SRAM_DQ;				//	SRAM Data bus 16 Bits
output [17:0]	SRAM_ADDR;				//	SRAM Address bus 18 Bits
output			SRAM_UB_N;				//	SRAM High-byte Data Mask
output			SRAM_LB_N;				//	SRAM Low-byte Data Mask
output			SRAM_WE_N;				//	SRAM Write Enable
output			SRAM_CE_N;				//	SRAM Chip Enable
output			SRAM_OE_N;				//	SRAM Output Enable
////////////////////	ISP1362 Interface	////////////////////////
inout	 [15:0]	OTG_DATA;				//	ISP1362 Data bus 16 Bits
output  [1:0]	OTG_ADDR;				//	ISP1362 Address 2 Bits
output			OTG_CS_N;				//	ISP1362 Chip Select
output			OTG_RD_N;				//	ISP1362 Write
output			OTG_WR_N;				//	ISP1362 Read
output			OTG_RST_N;				//	ISP1362 Reset
output			OTG_FSPEED;				//	USB Full Speed,	0 = Enable, Z = Disable
output			OTG_LSPEED;				//	USB Low Speed, 	0 = Enable, Z = Disable
input			   OTG_INT0;				//	ISP1362 Interrupt 0
input			   OTG_INT1;				//	ISP1362 Interrupt 1
input			   OTG_DREQ0;				//	ISP1362 DMA Request 0
input			   OTG_DREQ1;				//	ISP1362 DMA Request 1
output			OTG_DACK0_N;			//	ISP1362 DMA Acknowledge 0
output			OTG_DACK1_N;			//	ISP1362 DMA Acknowledge 1
////////////////////	LCD Module 16X2	////////////////////////////
inout	  [7:0]	LCD_DATA;				//	LCD Data bus 8 bits
output			LCD_ON;					//	LCD Power ON/OFF
output			LCD_BLON;				//	LCD Back Light ON/OFF
output			LCD_RW;					//	LCD Read/Write Select, 0 = Write, 1 = Read
output			LCD_EN;					//	LCD Enable
output			LCD_RS;					//	LCD Command/Data Select, 0 = Command, 1 = Data
////////////////////	SD Card Interface	////////////////////////
//inout	 [3:0]	SD_DAT;					//	SD Card Data
//input			   SD_WP_N;				   //	SD write protect
//inout			   SD_CMD;					//	SD Card Command Signal
//output			SD_CLK;					//	SD Card Clock
////////////////////////	I2C		////////////////////////////////
inout			   I2C_SDAT;				//	I2C Data
output			I2C_SCLK;				//	I2C Clock
////////////////////////	PS2		////////////////////////////////
input		 	   PS2_DAT;				//	PS2 Data
input			   PS2_CLK;				//	PS2 Clock
////////////////////	USB JTAG link	////////////////////////////
input  			TDI;					// CPLD -> FPGA (data in)
input  			TCK;					// CPLD -> FPGA (clk)
input  			TCS;					// CPLD -> FPGA (CS)
output 			TDO;					// FPGA -> CPLD (data out)
////////////////////////	VGA			////////////////////////////
output			VGA_CLK;   				//	VGA Clock
output			VGA_HS;					//	VGA H_SYNC
output			VGA_VS;					//	VGA V_SYNC
output			VGA_BLANK;				//	VGA BLANK
output			VGA_SYNC;				//	VGA SYNC
output	[9:0]	VGA_R;   				//	VGA Red[9:0]
output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
////////////////	Ethernet Interface	////////////////////////////
inout	[15:0]	ENET_DATA;				//	DM9000A DATA bus 16Bits
output			ENET_CMD;				//	DM9000A Command/Data Select, 0 = Command, 1 = Data
output			ENET_CS_N;				//	DM9000A Chip Select
output			ENET_WR_N;				//	DM9000A Write
output			ENET_RD_N;				//	DM9000A Read
output			ENET_RST_N;				//	DM9000A Reset
input			   ENET_INT;				//	DM9000A Interrupt
output			ENET_CLK;				//	DM9000A Clock 25 MHz
////////////////////	Audio CODEC		////////////////////////////
inout			   AUD_ADCLRCK;			//	Audio CODEC ADC LR Clock
input			   AUD_ADCDAT;				//	Audio CODEC ADC Data
inout			   AUD_DACLRCK;			//	Audio CODEC DAC LR Clock
output			AUD_DACDAT;				//	Audio CODEC DAC Data
inout			   AUD_BCLK;				//	Audio CODEC Bit-Stream Clock
output			AUD_XCK;				//	Audio CODEC Chip Clock
////////////////////	TV Devoder		////////////////////////////
input	 [7:0]	TD_DATA;    			//	TV Decoder Data bus 8 bits
input			   TD_HS;					//	TV Decoder H_SYNC
input			   TD_VS;					//	TV Decoder V_SYNC
output			TD_RESET;				//	TV Decoder Reset
input          TD_CLK27;            //	TV Decoder 27MHz CLK
////////////////////////	GPIO	////////////////////////////////
inout	[35:0]	GPIO_0;					//	GPIO Connection 0
inout	[35:0]	GPIO_1;					//	GPIO Connection 1

/*
assign HEX0 = dispfetch;
assign HEX1 = dispdec;
assign HEX2 = dispex;
assign HEX3 = dispmem;
assign HEX4 = dispwb;
assign LEDR[3:0] = instruction[24:21];
*/

wire [31:0] PC, BrAddress, instruction, PCf, instruction_out, Result_WB_Value, val1_ID, val2_ID, Reg2_ID, Reg2, val1, val2, PC_ID_OUT;
wire [31:0] ALU_res_MEM, ALU_result_toReg, BrAddress_EXE, ST_Val, Data, ALU_Result_WBin, memreadval;
 
wire MEM_W_EN_EXE, MEM_R_EN_EXE, WB_EN_EXE, WB_EN_MEM, MEM_R_EN_MEM, MEM_W_EN_MEM, MEM_R_EN_WB;
wire Br_taken_IF, WB_EN, WB_en_output, WB_EN_input, Br_taken, MEM_R_EN_ID, MEM_W_EN_ID, WB_EN_ID;
wire [4:0] Dest_WB, Dest_ID, Dest_MEM, Dest_out, WBdestAddress;
wire [1:0] Br_type_ID, Br_type;
wire [3:0 ] EXE_CMD_Sig, EXECMD;
wire hazard_freeze, freeze , wb_out;

wire [1:0] frwA , frwB , stSelect ;
wire [4:0] src1 , src2 ;
wire [31:0] st_val_out ,st_val_in ;

wire clk, rst, isFrw;
assign clk = CLOCK_50;
assign rst = SW[0];
assign isFrw = SW[1];

IF_Stage if_stage (
	.clk 					(clk),
	.rst 					(rst),
	.PC 					(PC),
	.hazard_freeze			(hazard_freeze),
	.freeze 				(freeze),
	.Br_taken 				(Br_taken_IF),
	.Br_Addr 				(BrAddress_EXE),
	.Instruction 			(instruction)
);
IF_Stage_reg if_stage_reg (
	.clk 					(clk),
	.rst 					(rst),
	.PC_in 					(PC),
	.hazard_freeze			(hazard_freeze),
	.freeze 				(freeze),
	.Instruction_in 		(instruction),
	.flush 					(Br_taken_IF),
	.PC 					(PCf),
	.Instruction 			(instruction_out)
);
wire [4:0] source1, source2;
ID_Stage id_stage (
	
	.is_forward 			(isFrw),
	.clk 					(clk),
	.rst 					(rst),
	.Instruction 			(instruction_out),
	.WB_Data 				(Result_WB_Value),
	.WB_Dest 				(Dest_WB),
	.WB_Write_Enable 		(WB_en_output),
  	.MEM_R_EN_regout 		(MEM_R_EN_EXE),
	.EXE_Dest				(Dest_MEM),
	.Exe_WB_EN				(WB_EN_EXE),
	.MEM_Dest				(Dest_out),
	.MEM_WB_EN				(WB_EN_MEM),
	.Val1 					(val1_ID), 
	.Val2 					(val2_ID),
	.Reg2 					(Reg2_ID), 
	.Dest 					(Dest_ID), 
	.Branch_Type 			(Br_type_ID), //why
	.Br_Taken 				(Br_taken), 
	.EXE_CMD 				(EXE_CMD_Sig),
	.MEM_R_EN 				(MEM_R_EN_ID),
	.MEM_W_EN 				(MEM_W_EN_ID),
	.WB_EN 					(WB_EN_ID),
	.Hazard_Detected_Signal	(hazard_freeze),
	.src1 					(source1),
	.src2 					(source2)
);
ID_Stage_reg id_stage_reg	(
	.clk 					(clk),
	.rst 					(rst),
	.freeze 				(freeze),
	.flush 					(Br_taken_IF),
	.src1_in  				(source1),
	.src2_in  				(source2),
	.Dest_in 				(Dest_ID),
	.Reg2_in 				(Reg2_ID),
	.Val2_in 				(val2_ID),
	.Val1_in				(val1_ID),
	.PC_in 					(PCf),
	.Br_type_in				(Br_type_ID),
	.EXE_CMD_in 			(EXE_CMD_Sig),
	.MEM_R_EN_in 			(MEM_R_EN_ID),
	.MEM_W_EN_in 			(MEM_W_EN_ID),
    .WB_EN_in 				(WB_EN_ID),
    .Dest 					(Dest_MEM),
	.Reg2 					(Reg2),
	.Val2 					(val2),
	.Val1 					(val1),
	.PC_out 				(PC_ID_OUT),
	.Br_type 				(Br_type),
	.EXE_CMD 				(EXECMD),
	.MEM_R_EN 				(MEM_R_EN_EXE),
	.MEM_W_EN 				(MEM_W_EN_EXE),
	.WB_EN 					(WB_EN_EXE),
	.src1_out  				(src1),
	.src2_out  				(src2)
);
Forwarding_Unit forwardingUnit(
    .ID_reg_out_dest 		(Dest_MEM),
    .ID_reg_out_src1 		(src1),
    .ID_reg_out_src2 		(src2),
    .EXE_reg_out_WBEN 		(WB_EN_MEM),
    .EXE_reg_out_DEST 		(Dest_out),
    .MEM_reg_out_DEST 		(WBdestAddress),
    .MEM_reg_out_WBEN  		(WB_EN_input),
  	.ID_reg_out_MEM_W  		(MEM_W_EN_EXE),
    .forward_a_select 		(frwA),
    .forward_b_select  		(frwB),
    .st_val_select 			(stSelect)
);
EXE_Stage exe_stage (
    .clk 					(clk),
    .sel_A   				(frwA),
    .sel_B   				(frwB),
    .sel_ST 				(stSelect),
    .reg_2  				(Reg2),
	.EXE_CMD 				(EXECMD),
	.val1 					(val1),
	.val2 					(val2),
	.PC 					(PC_ID_OUT),
	.Br_type 				(Br_type),
	.MEM_ALU_result		 	(ALU_res_MEM),
	.WB_ALU_result 			(Result_WB_Value),
	.ALU_result 			(ALU_result_toReg),
	.Br_Addr 				(BrAddress_EXE),
	.Br_taken 				(Br_taken_IF),
	.Src2_Val 				(st_val_in)	
);
EXE_Stage_reg exe_stage_reg (
	.clk 					(clk),
	.rst 					(rst),
	.freeze 				(freeze),
	.WB_en_in 				(WB_EN_EXE),
	.MEM_R_EN_in 			(MEM_R_EN_EXE),
	.MEM_W_EN_in 			(MEM_W_EN_EXE),
	.ALU_result_in 			(ALU_result_toReg),
	.ST_val_in 				(st_val_in),
	.Dest_in 				(Dest_MEM),
	.WB_en 					(WB_EN_MEM),
	.MEM_R_EN 				(MEM_R_EN_MEM),
	.MEM_W_EN 				(MEM_W_EN_MEM),
	.ALU_result 			(ALU_res_MEM),
	.ST_Val 				(st_val_out),
	.Dest 					(Dest_out)
);	
MEM_Stage mem_stage (
	.clk 					(clk),
	.rst 					(rst),
	.MEM_R_EN_in 			(MEM_R_EN_MEM),
	.MEM_W_EN_in 			(MEM_W_EN_MEM),
	.ALU_result_in 			(ALU_res_MEM),
	.ST_val 				(st_val_out),
	.MEM_read_value 		(Data),
	.SRAM_DQ				(SRAM_DQ),		
	.SRAM_ADDR				(SRAM_ADDR),	
	.SRAM_UB_N 				(SRAM_UB_N),			
	.SRAM_LB_N				(SRAM_LB_N),
	.SRAM_WE_N 				(SRAM_WE_N),			
	.SRAM_CE_N				(SRAM_CE_N),			
	.SRAM_OE_N 				(SRAM_OE_N),
	.wb_en_mem_in			(WB_EN_MEM),
	.MEM_WB_EN_MUX  		(wb_out),
	.freeze 				(freeze)
);
MEM_Stage_reg mem_stage_reg (
	.clk 					(clk),
	.rst 					(rst),
	.freeze 				(freeze),
	.WB_en_in 				(wb_out),
	.MEM_R_EN_in 			(MEM_R_EN_MEM),
	.ALU_result_in 			(ALU_res_MEM),
	.Mem_read_value_in 		(Data),
	.Dest_in 				(Dest_out),
	.WB_en 					(WB_EN_input),
	.MEM_R_EN 				(MEM_R_EN_WB),
	.ALU_result 			(ALU_Result_WBin),
	.Mem_read_value 		(memreadval),
	.Dest 					(WBdestAddress)
);
WB_Stage wb_stage (
	.clk 					(clk),
	.WB_en_in 				(WB_EN_input),
	.MEM_R_EN 				(MEM_R_EN_WB),
	.ALU_result 			(ALU_Result_WBin),
	.Mem_read_value 		(memreadval),
	.Dest_in 				(WBdestAddress),
	.WB_en 					(WB_en_output),
    .Write_value			(Result_WB_Value),
    .Dest 					(Dest_WB)
);

endmodule