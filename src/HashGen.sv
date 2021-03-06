// === HashGen.sv ===

`include "defines.sv"

module HashGen
  #(parameter ROUND_NUM = 7,
    parameter HASH_DELAY = 71)
  (
  // Clock
  input  Clk,
  // Inputs
  input Strt_I,
  input Clear_I,
  input EN_I,
  // block length in bytes
  input [31:0] BL_I,
  // chunk start
  input CS_flg_I,
  // chunk end
  input CE_flg_I,
  input ROOT_flg_I,
  input [7:0] [31:0] H_I,
  input [15:0] [31:0] Msg_I,
  
  // Outputs
  output Vld_O,
  
  output [$clog2(HASH_DELAY)-1:0] CNTR_O,
  
  // Outputs
  output [7:0] [31:0] H_O
  );
  
  localparam logic[31:0] IV [0:7] = {
    `IV_0, `IV_1, `IV_2, `IV_3,
    `IV_4, `IV_5, `IV_6, `IV_7
  };
  
  localparam integer perm_num [0:15] = {
    2, 6, 3, 10, 7, 0, 4, 13, 1, 11, 12, 5, 9, 14, 15, 8
  };

  
  
  logic [15:0][ROUND_NUM-1:0][31:0] MsgArray;
  logic [15:0][ROUND_NUM:0][31:0] VArray;
  
  logic [9:0][15:0][ROUND_NUM-2:0][31:0] MsgArrayShr;
  
  
  // set of domain separation bit flags
  logic parent = 0;
  logic keyed_hash = 0;
  logic derive_key_context = 0;
  logic derive_key_material = 0;
  
  logic vld_reg = 0;
  logic strt_flg = 0;
  
  shortint cntr_reg = 0;
  
  
  logic [15:0][31:0] hv;
  
  genvar k;
  // input chaining value h0-h7
  generate  
    for (k = 0; k < 8; k = k + 1)
    begin : chaining_value
      assign VArray[k][0] = H_I[k];
    end
  endgenerate

  
  //IV 0-3
  assign VArray[8][0] = IV[0];
  assign VArray[9][0] = IV[1];
  assign VArray[10][0] = IV[2];
  assign VArray[11][0] = IV[3];
  
  // counter
  assign VArray[12][0] = 0;
  // countershift
  assign VArray[13][0] = 0;
  // block length
  assign VArray[14][0] = BL_I;
  // flags
  assign VArray[15][0][31:7] = 0;
  assign VArray[15][0][6:0] = {
    derive_key_material,
    derive_key_context,
    keyed_hash, ROOT_flg_I, parent,
    CE_flg_I, CS_flg_I
  };
  
  
  genvar m;
  // message assigning
  generate  
    for (m = 0; m < 16; m = m + 1)
    begin : msg_assign
      assign MsgArray[m][0] = Msg_I[m];
    end
  endgenerate
  
  // delay of the valid signal
  always@(posedge Clk) 
  begin : delay_counter
    if(Strt_I) begin
      cntr_reg <= 0;
      strt_flg <= 1'b1;
    end
    else if(Clear_I)
      cntr_reg <= 0;
    else if((cntr_reg < HASH_DELAY) && EN_I)
      cntr_reg++;
    else
      cntr_reg <= cntr_reg;
  end
  
  assign CNTR_O = cntr_reg;
  
  // valid register
  always@(posedge Clk) 
  begin : valid_process
    vld_reg <= ((cntr_reg == HASH_DELAY) && strt_flg && !Strt_I);
  end
  
  assign Vld_O = vld_reg;
  
  
  genvar i;
  genvar j;
  
  generate  
    for (i = 1; i < (ROUND_NUM + 1); i = i + 1)
    begin : hasher
    
      if(i < ROUND_NUM) begin
        for (j = 0; j < 16; j = j + 1)
        begin
            always@(posedge Clk)
            begin : message_permutation
              MsgArrayShr[0][j][i-1] <= MsgArray[j][i-1];
              for (int k = 0; k < 9; k = k + 1) begin
                MsgArrayShr[k+1][j][i-1] <= MsgArrayShr[k][j][i-1];
              end
            end
          assign MsgArray[j][i] = MsgArrayShr[9][perm_num[j]][i-1];
        end
      end
      
      G_round G_round_i(
      .Clk(Clk),
      .V0_I(VArray[0][i-1]),
      .V1_I(VArray[1][i-1]),
      .V2_I(VArray[2][i-1]),
      .V3_I(VArray[3][i-1]),
      .V4_I(VArray[4][i-1]),
      .V5_I(VArray[5][i-1]),
      .V6_I(VArray[6][i-1]),
      .V7_I(VArray[7][i-1]),
      .V8_I(VArray[8][i-1]),
      .V9_I(VArray[9][i-1]),
      .V10_I(VArray[10][i-1]),
      .V11_I(VArray[11][i-1]),
      .V12_I(VArray[12][i-1]),
      .V13_I(VArray[13][i-1]),
      .V14_I(VArray[14][i-1]),
      .V15_I(VArray[15][i-1]),
      .M0_I(MsgArray[0][i-1]),
      .M1_I(MsgArray[1][i-1]),
      .M2_I(MsgArray[2][i-1]),
      .M3_I(MsgArray[3][i-1]),
      .M4_I(MsgArray[4][i-1]),
      .M5_I(MsgArray[5][i-1]),
      .M6_I(MsgArray[6][i-1]),
      .M7_I(MsgArray[7][i-1]),
      .M8_I(MsgArray[8][i-1]),
      .M9_I(MsgArray[9][i-1]),
      .M10_I(MsgArray[10][i-1]),
      .M11_I(MsgArray[11][i-1]),
      .M12_I(MsgArray[12][i-1]),
      .M13_I(MsgArray[13][i-1]),
      .M14_I(MsgArray[14][i-1]),
      .M15_I(MsgArray[15][i-1]),
      .V0_O(VArray[0][i]),
      .V1_O(VArray[1][i]),
      .V2_O(VArray[2][i]),
      .V3_O(VArray[3][i]),
      .V4_O(VArray[4][i]),
      .V5_O(VArray[5][i]),
      .V6_O(VArray[6][i]),
      .V7_O(VArray[7][i]),
      .V8_O(VArray[8][i]),
      .V9_O(VArray[9][i]),
      .V10_O(VArray[10][i]),
      .V11_O(VArray[11][i]),
      .V12_O(VArray[12][i]),
      .V13_O(VArray[13][i]),
      .V14_O(VArray[14][i]),
      .V15_O(VArray[15][i])  
      );
    end      
  endgenerate
  
  // compression function
  always@(posedge Clk) 
  begin : compress
    for(int l = 0; l < 8; l++) begin
      hv[l] <= VArray[l][ROUND_NUM] ^ VArray[l+8][ROUND_NUM];
      // chaining values
      hv[l+8] <= VArray[l+8][ROUND_NUM] ^ hv[l];
    end
  end
  
  assign H_O = hv[7:0];
  
endmodule