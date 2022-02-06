module SRAM_Controller
  (
    input clk,
    input rst,
    //From Memory Stage
    input wr_en,
    input rd_en,
    input [31:0] address,
    input [31:0] writeData,
    //To Next Stage
    output [31:0] readData,
    //For freeze Other Stage
    output ready,
    inout [15:0] SRAM_DQ,
    output reg [17:0] SRAM_ADDR,
    output SRAM_UB_N,
    output SRAM_LB_N,
    output reg SRAM_WE_N,
    output SRAM_CE_N,
    output SRAM_OE_N
  );

  assign SRAM_UB_N = 0;
  assign SRAM_LB_N = 0;
  assign SRAM_CE_N = 0;
  assign SRAM_OE_N = 0;

  reg[2:0] count;
  reg[15:0] Data1, Data2;
  reg[15:0] wr_data;

  always@(posedge clk)
  begin
    if(rst)
    begin
      count <= 0;
      SRAM_WE_N <= 1; 
    end
    else 
    begin
      if(wr_en)
      begin
        count = count + 1;
        case(count)
          3'd1:
            begin
               SRAM_ADDR <= {address[17:2], 2'd0};
               wr_data <= writeData[15:0];
               SRAM_WE_N <= 0;
            end
          3'd2:
            begin
              SRAM_ADDR <= {address[17:2], 2'd1};
              wr_data <= writeData[31:16];
              SRAM_WE_N <= 0;
            end
          3'd3:
            begin
              SRAM_WE_N <= 1;
            end
          3'd4:
            begin
            end
          3'd5:
            begin
            end
          3'd6: 
            begin 
              count <= 3'd0;
            end
        endcase
      end 
      else if(rd_en) 
      begin
      SRAM_WE_N <= 1;
        count = count + 1;
        case(count)
          3'd1:
            begin
              SRAM_ADDR <= {address[17:2], 2'd0};
            end
          3'd2:
            begin
              SRAM_ADDR <= {address[17:2], 2'd1};
              Data1 <= SRAM_DQ;
            end
          3'd3:
            begin
              Data2 <= SRAM_DQ;
            end
          3'd4:
            begin
            end
          3'd5:
            begin
            end
          3'd6: 
            begin
              count <= 0;
            end
       endcase
      end
    end
  end
  assign ready = (!(rd_en || wr_en) || (count == 5))? 1 : 0;
  assign SRAM_DQ = ~SRAM_WE_N? wr_data : 16'bz;
  assign readData = {Data2, Data1};
endmodule