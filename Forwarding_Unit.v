module Forwarding_Unit
  (
    input [4:0] ID_reg_out_dest,
    input [4:0] ID_reg_out_src1,
    input [4:0] ID_reg_out_src2,
    input EXE_reg_out_WBEN ,
    input [4:0] EXE_reg_out_DEST ,
    input [4:0] MEM_reg_out_DEST ,
    input MEM_reg_out_WBEN,
    
    input ID_reg_out_MEM_W, 
     
    output  [1:0]forward_a_select,
    output  [1:0]forward_b_select,
    output  [1:0]st_val_select
    );

  assign forward_a_select = ((ID_reg_out_src1 == EXE_reg_out_DEST) && EXE_reg_out_WBEN == 1'b1 && EXE_reg_out_DEST != 5'b0) ? 2'b01 :
      ((ID_reg_out_src1 == MEM_reg_out_DEST) && MEM_reg_out_WBEN == 1'b1 && MEM_reg_out_DEST != 5'b0) ? 2'b10 : 2'b00;

  assign forward_b_select = (!ID_reg_out_MEM_W && (ID_reg_out_src2 == EXE_reg_out_DEST) && EXE_reg_out_WBEN == 1'b1 && EXE_reg_out_DEST != 5'b0) ? 2'b01 :
      (!ID_reg_out_MEM_W && (ID_reg_out_src2 == MEM_reg_out_DEST) && MEM_reg_out_WBEN == 1'b1 && MEM_reg_out_DEST != 5'b0) ? 2'b10 : 2'b00;
      
  assign st_val_select = (MEM_reg_out_WBEN && (MEM_reg_out_DEST == ID_reg_out_dest) &&  MEM_reg_out_DEST != 5'b0)? 2'b10 : 
      (EXE_reg_out_WBEN && (EXE_reg_out_DEST == ID_reg_out_src2) &&  EXE_reg_out_DEST != 5'b0)? 2'b01 : 2'b00;
     

endmodule

