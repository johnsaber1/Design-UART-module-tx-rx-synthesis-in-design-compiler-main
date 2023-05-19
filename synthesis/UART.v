/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06
// Date      : Sat Aug 13 15:42:01 2022
/////////////////////////////////////////////////////////////


module uart_tx_fsm ( CLK, RST, Data_Valid, ser_done, parity_enable, Ser_enable, 
        mux_sel, busy );
  output [1:0] mux_sel;
  input CLK, RST, Data_Valid, ser_done, parity_enable;
  output Ser_enable, busy;
  wire   busy_c, n1, n2, n3, n4, n5, n6, n7, n8, n9;
  wire   [2:0] current_state;
  wire   [2:0] next_state;

  DFFRQX2M \current_state_reg[1]  ( .D(next_state[1]), .CK(CLK), .RN(RST), .Q(
        current_state[1]) );
  DFFRQX1M busy_reg ( .D(busy_c), .CK(CLK), .RN(RST), .Q(busy) );
  DFFRQX4M \current_state_reg[2]  ( .D(next_state[2]), .CK(CLK), .RN(RST), .Q(
        current_state[2]) );
  DFFRQX4M \current_state_reg[0]  ( .D(next_state[0]), .CK(CLK), .RN(RST), .Q(
        current_state[0]) );
  INVX2M U3 ( .A(n9), .Y(n2) );
  AOI21X2M U4 ( .A0(n6), .A1(n7), .B0(current_state[2]), .Y(next_state[0]) );
  NAND2BX2M U5 ( .AN(ser_done), .B(current_state[0]), .Y(n6) );
  OAI21X2M U6 ( .A0(Data_Valid), .A1(current_state[0]), .B0(n1), .Y(n7) );
  NOR3X2M U7 ( .A(n1), .B(current_state[2]), .C(n4), .Y(next_state[2]) );
  AOI2B1X1M U8 ( .A1N(parity_enable), .A0(ser_done), .B0(n3), .Y(n4) );
  NOR3X4M U9 ( .A(n5), .B(ser_done), .C(current_state[2]), .Y(Ser_enable) );
  INVX2M U10 ( .A(current_state[0]), .Y(n3) );
  OAI21X4M U11 ( .A0(current_state[1]), .A1(n3), .B0(n8), .Y(n9) );
  NAND2X2M U12 ( .A(current_state[1]), .B(n3), .Y(n8) );
  NAND2X2M U13 ( .A(n2), .B(current_state[0]), .Y(n5) );
  OAI2B2X4M U14 ( .A1N(current_state[2]), .A0(n8), .B0(current_state[2]), .B1(
        n9), .Y(mux_sel[0]) );
  OAI21X2M U15 ( .A0(current_state[2]), .A1(current_state[0]), .B0(n8), .Y(
        mux_sel[1]) );
  AOI21X1M U16 ( .A0(n2), .A1(n5), .B0(current_state[2]), .Y(next_state[1]) );
  OAI21X1M U17 ( .A0(current_state[2]), .A1(n3), .B0(n8), .Y(busy_c) );
  INVX2M U18 ( .A(current_state[1]), .Y(n1) );
endmodule


module Serializer ( CLK, RST, DATA, Enable, Busy, Data_Valid, ser_out, 
        ser_done );
  input [7:0] DATA;
  input CLK, RST, Enable, Busy, Data_Valid;
  output ser_out, ser_done;
  wire   N23, N24, N25, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13,
         n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25;
  wire   [7:1] DATA_V;
  wire   [2:0] ser_count;

  NOR2X12M U20 ( .A(n3), .B(n25), .Y(n6) );
  DFFRQX2M \DATA_V_reg[0]  ( .D(n17), .CK(CLK), .RN(RST), .Q(ser_out) );
  DFFRQX2M \DATA_V_reg[6]  ( .D(n19), .CK(CLK), .RN(RST), .Q(DATA_V[6]) );
  DFFRQX2M \DATA_V_reg[5]  ( .D(n20), .CK(CLK), .RN(RST), .Q(DATA_V[5]) );
  DFFRQX2M \DATA_V_reg[4]  ( .D(n21), .CK(CLK), .RN(RST), .Q(DATA_V[4]) );
  DFFRQX2M \DATA_V_reg[3]  ( .D(n22), .CK(CLK), .RN(RST), .Q(DATA_V[3]) );
  DFFRQX2M \DATA_V_reg[2]  ( .D(n23), .CK(CLK), .RN(RST), .Q(DATA_V[2]) );
  DFFRQX2M \DATA_V_reg[1]  ( .D(n24), .CK(CLK), .RN(RST), .Q(DATA_V[1]) );
  DFFRQX2M \DATA_V_reg[7]  ( .D(n18), .CK(CLK), .RN(RST), .Q(DATA_V[7]) );
  DFFRQX2M \ser_count_reg[2]  ( .D(N25), .CK(CLK), .RN(RST), .Q(ser_count[2])
         );
  DFFRQX2M \ser_count_reg[1]  ( .D(N24), .CK(CLK), .RN(RST), .Q(ser_count[1])
         );
  DFFRQX2M \ser_count_reg[0]  ( .D(N23), .CK(CLK), .RN(RST), .Q(ser_count[0])
         );
  NOR2X8M U3 ( .A(n25), .B(n6), .Y(n4) );
  INVX2M U4 ( .A(Enable), .Y(n3) );
  CLKBUFX6M U5 ( .A(n7), .Y(n25) );
  NOR2BX2M U6 ( .AN(Data_Valid), .B(Busy), .Y(n7) );
  OAI2BB1X2M U7 ( .A0N(ser_out), .A1N(n4), .B0(n5), .Y(n17) );
  AOI22X1M U8 ( .A0(DATA_V[1]), .A1(n6), .B0(DATA[0]), .B1(n25), .Y(n5) );
  OAI2BB1X2M U9 ( .A0N(DATA_V[1]), .A1N(n4), .B0(n13), .Y(n24) );
  AOI22X1M U10 ( .A0(DATA_V[2]), .A1(n6), .B0(DATA[1]), .B1(n25), .Y(n13) );
  OAI2BB1X2M U11 ( .A0N(n4), .A1N(DATA_V[2]), .B0(n12), .Y(n23) );
  AOI22X1M U12 ( .A0(DATA_V[3]), .A1(n6), .B0(DATA[2]), .B1(n25), .Y(n12) );
  OAI2BB1X2M U13 ( .A0N(n4), .A1N(DATA_V[3]), .B0(n11), .Y(n22) );
  AOI22X1M U14 ( .A0(DATA_V[4]), .A1(n6), .B0(DATA[3]), .B1(n25), .Y(n11) );
  OAI2BB1X2M U15 ( .A0N(n4), .A1N(DATA_V[4]), .B0(n10), .Y(n21) );
  AOI22X1M U16 ( .A0(DATA_V[5]), .A1(n6), .B0(DATA[4]), .B1(n25), .Y(n10) );
  OAI2BB1X2M U17 ( .A0N(n4), .A1N(DATA_V[5]), .B0(n9), .Y(n20) );
  AOI22X1M U18 ( .A0(DATA_V[6]), .A1(n6), .B0(DATA[5]), .B1(n25), .Y(n9) );
  OAI2BB1X2M U19 ( .A0N(n4), .A1N(DATA_V[6]), .B0(n8), .Y(n19) );
  AOI22X1M U21 ( .A0(DATA_V[7]), .A1(n6), .B0(DATA[6]), .B1(n25), .Y(n8) );
  AO22X1M U22 ( .A0(n4), .A1(DATA_V[7]), .B0(DATA[7]), .B1(n25), .Y(n18) );
  OAI32X2M U23 ( .A0(n14), .A1(n2), .A2(n3), .B0(n15), .B1(n1), .Y(N25) );
  NAND2X2M U24 ( .A(ser_count[0]), .B(n1), .Y(n14) );
  AOI21X2M U25 ( .A0(Enable), .A1(n2), .B0(N23), .Y(n15) );
  INVX2M U26 ( .A(ser_count[2]), .Y(n1) );
  NOR2X2M U27 ( .A(n3), .B(ser_count[0]), .Y(N23) );
  NOR2X2M U28 ( .A(n16), .B(n3), .Y(N24) );
  CLKXOR2X2M U29 ( .A(ser_count[0]), .B(n2), .Y(n16) );
  AND3X2M U30 ( .A(ser_count[0]), .B(ser_count[2]), .C(ser_count[1]), .Y(
        ser_done) );
  INVX2M U31 ( .A(ser_count[1]), .Y(n2) );
endmodule


module mux ( CLK, RST, IN_0, IN_1, IN_2, IN_3, SEL, OUT );
  input [1:0] SEL;
  input CLK, RST, IN_0, IN_1, IN_2, IN_3;
  output OUT;
  wire   mux_out, n1, n2, n3;

  DFFRQX2M OUT_reg ( .D(mux_out), .CK(CLK), .RN(RST), .Q(OUT) );
  INVX2M U3 ( .A(SEL[0]), .Y(n1) );
  OAI2B2X1M U4 ( .A1N(SEL[1]), .A0(n2), .B0(SEL[1]), .B1(n3), .Y(mux_out) );
  AOI22X1M U5 ( .A0(IN_0), .A1(n1), .B0(SEL[0]), .B1(IN_1), .Y(n3) );
  AOI22X1M U6 ( .A0(IN_2), .A1(n1), .B0(IN_3), .B1(SEL[0]), .Y(n2) );
endmodule


module parity_calc ( CLK, RST, parity_enable, parity_type, DATA, Data_Valid, 
        parity );
  input [7:0] DATA;
  input CLK, RST, parity_enable, parity_type, Data_Valid;
  output parity;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16
;
  wire   [7:0] DATA_V;

  OAI2BB2X1M U2 ( .B0(n1), .B1(n2), .A0N(parity), .A1N(n2), .Y(n7) );
  CLKINVX1M U3 ( .A(parity_enable), .Y(n2) );
  XOR3XLM U4 ( .A(n3), .B(parity_type), .C(n4), .Y(n1) );
  XOR3XLM U5 ( .A(DATA_V[1]), .B(DATA_V[0]), .C(n5), .Y(n4) );
  XNOR2X1M U6 ( .A(DATA_V[2]), .B(DATA_V[3]), .Y(n5) );
  XOR3XLM U7 ( .A(DATA_V[5]), .B(DATA_V[4]), .C(n6), .Y(n3) );
  CLKXOR2X2M U8 ( .A(DATA_V[7]), .B(DATA_V[6]), .Y(n6) );
  AO2B2X1M U9 ( .B0(n16), .B1(DATA[0]), .A0(DATA_V[0]), .A1N(n16), .Y(n8) );
  AO2B2X1M U10 ( .B0(DATA[1]), .B1(n16), .A0(DATA_V[1]), .A1N(n16), .Y(n9) );
  AO2B2X1M U11 ( .B0(DATA[2]), .B1(n16), .A0(DATA_V[2]), .A1N(n16), .Y(n10) );
  AO2B2X1M U12 ( .B0(DATA[3]), .B1(n16), .A0(DATA_V[3]), .A1N(n16), .Y(n11) );
  AO2B2X1M U13 ( .B0(DATA[4]), .B1(n16), .A0(DATA_V[4]), .A1N(n16), .Y(n12) );
  AO2B2X1M U14 ( .B0(DATA[5]), .B1(n16), .A0(DATA_V[5]), .A1N(n16), .Y(n13) );
  AO2B2X1M U15 ( .B0(DATA[6]), .B1(n16), .A0(DATA_V[6]), .A1N(n16), .Y(n14) );
  AO2B2X1M U16 ( .B0(DATA[7]), .B1(n16), .A0(DATA_V[7]), .A1N(n16), .Y(n15) );
  DFFRQX2M \DATA_V_reg[2]  ( .D(n10), .CK(CLK), .RN(RST), .Q(DATA_V[2]) );
  DFFRQX2M \DATA_V_reg[3]  ( .D(n11), .CK(CLK), .RN(RST), .Q(DATA_V[3]) );
  DFFRQX2M \DATA_V_reg[5]  ( .D(n13), .CK(CLK), .RN(RST), .Q(DATA_V[5]) );
  DFFRQX2M \DATA_V_reg[1]  ( .D(n9), .CK(CLK), .RN(RST), .Q(DATA_V[1]) );
  DFFRQX2M \DATA_V_reg[4]  ( .D(n12), .CK(CLK), .RN(RST), .Q(DATA_V[4]) );
  DFFRQX2M \DATA_V_reg[0]  ( .D(n8), .CK(CLK), .RN(RST), .Q(DATA_V[0]) );
  DFFRQX2M \DATA_V_reg[6]  ( .D(n14), .CK(CLK), .RN(RST), .Q(DATA_V[6]) );
  DFFRQX2M \DATA_V_reg[7]  ( .D(n15), .CK(CLK), .RN(RST), .Q(DATA_V[7]) );
  DFFRQX2M parity_reg ( .D(n7), .CK(CLK), .RN(RST), .Q(parity) );
  CLKBUFX8M U17 ( .A(Data_Valid), .Y(n16) );
endmodule


module UART_TX ( CLK, RST, P_DATA, Data_Valid, parity_enable, parity_type, 
        TX_OUT, busy );
  input [7:0] P_DATA;
  input CLK, RST, Data_Valid, parity_enable, parity_type;
  output TX_OUT, busy;
  wire   n3, seriz_en, seriz_done, ser_data, parity, n1;
  wire   [1:0] mux_sel;

  uart_tx_fsm U0_fsm ( .CLK(CLK), .RST(RST), .Data_Valid(Data_Valid), 
        .ser_done(seriz_done), .parity_enable(parity_enable), .Ser_enable(
        seriz_en), .mux_sel(mux_sel), .busy(n3) );
  Serializer U0_Serializer ( .CLK(CLK), .RST(RST), .DATA(P_DATA), .Enable(
        seriz_en), .Busy(n3), .Data_Valid(Data_Valid), .ser_out(ser_data), 
        .ser_done(seriz_done) );
  mux U0_mux ( .CLK(CLK), .RST(RST), .IN_0(1'b0), .IN_1(ser_data), .IN_2(
        parity), .IN_3(1'b1), .SEL(mux_sel), .OUT(TX_OUT) );
  parity_calc U0_parity_calc ( .CLK(CLK), .RST(RST), .parity_enable(
        parity_enable), .parity_type(parity_type), .DATA(P_DATA), .Data_Valid(
        Data_Valid), .parity(parity) );
  CLKINVX1M U1 ( .A(n3), .Y(n1) );
  CLKINVX40M U2 ( .A(n1), .Y(busy) );
endmodule


module uart_rx_fsm ( CLK, RST, S_DATA, parity_enable, bit_count, edge_count, 
        par_err, stp_err, strt_glitch, strt_chk_en, edge_bit_en, deser_en, 
        par_chk_en, stp_chk_en, dat_samp_en, data_valid );
  input [3:0] bit_count;
  input [2:0] edge_count;
  input CLK, RST, S_DATA, parity_enable, par_err, stp_err, strt_glitch;
  output strt_chk_en, edge_bit_en, deser_en, par_chk_en, stp_chk_en,
         dat_samp_en, data_valid;
  wire   n19, n1, n2, n3, n4, n5, n7, n8, n9, n10, n11, n12, n13, n14, n15,
         n16, n17, n18, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37;
  wire   [2:0] current_state;
  wire   [2:0] next_state;

  DFFRHQX8M \current_state_reg[2]  ( .D(next_state[2]), .CK(CLK), .RN(RST), 
        .Q(current_state[2]) );
  DFFRX4M \current_state_reg[1]  ( .D(next_state[1]), .CK(CLK), .RN(RST), .Q(
        current_state[1]), .QN(n7) );
  DFFRQX4M \current_state_reg[0]  ( .D(next_state[0]), .CK(CLK), .RN(RST), .Q(
        current_state[0]) );
  AND2X2M U3 ( .A(n4), .B(n5), .Y(n1) );
  OR3X2M U4 ( .A(n19), .B(n20), .C(bit_count[1]), .Y(n21) );
  OR3X2M U5 ( .A(bit_count[0]), .B(strt_glitch), .C(bit_count[3]), .Y(n2) );
  INVXLM U6 ( .A(n31), .Y(data_valid) );
  CLKNAND2X2M U7 ( .A(n3), .B(n1), .Y(n8) );
  NAND2XLM U8 ( .A(n7), .B(n21), .Y(n4) );
  NAND2XLM U9 ( .A(n7), .B(n23), .Y(n5) );
  NAND2XLM U10 ( .A(n7), .B(n2), .Y(n3) );
  OR3X12M U11 ( .A(n23), .B(n34), .C(current_state[1]), .Y(n31) );
  NAND3BX1M U12 ( .AN(bit_count[2]), .B(edge_count[0]), .C(edge_count[2]), .Y(
        n19) );
  CLKAND2X2M U13 ( .A(n37), .B(n34), .Y(par_chk_en) );
  CLKAND2X16M U14 ( .A(n7), .B(n32), .Y(strt_chk_en) );
  NAND2BX8M U15 ( .AN(n32), .B(n7), .Y(dat_samp_en) );
  INVX20M U16 ( .A(n36), .Y(n32) );
  INVX20M U17 ( .A(current_state[2]), .Y(n34) );
  AO21X8M U18 ( .A0(S_DATA), .A1(n23), .B0(current_state[2]), .Y(n36) );
  OAI211X1M U19 ( .A0(S_DATA), .A1(n31), .B0(n30), .C0(n29), .Y(next_state[0])
         );
  INVX14M U20 ( .A(current_state[0]), .Y(n23) );
  OR3X1M U21 ( .A(n23), .B(n22), .C(n21), .Y(n24) );
  NAND2BX12M U22 ( .AN(n37), .B(n36), .Y(edge_bit_en) );
  OAI211X8M U23 ( .A0(parity_enable), .A1(n12), .B0(n11), .C0(n10), .Y(
        next_state[2]) );
  INVX2M U24 ( .A(n21), .Y(n9) );
  INVX2M U25 ( .A(n33), .Y(n37) );
  AND3X2M U26 ( .A(n20), .B(n18), .C(n17), .Y(n26) );
  INVX2M U27 ( .A(n19), .Y(n17) );
  INVX2M U28 ( .A(n16), .Y(stp_chk_en) );
  INVX2M U29 ( .A(n15), .Y(n28) );
  AND2X2M U30 ( .A(n15), .B(n16), .Y(n11) );
  AO21XLM U31 ( .A0(n14), .A1(n18), .B0(n35), .Y(n30) );
  AOI222X2M U32 ( .A0(n28), .A1(current_state[0]), .B0(n27), .B1(n26), .C0(
        strt_chk_en), .C1(n25), .Y(n29) );
  INVX2M U33 ( .A(n13), .Y(n14) );
  INVX2M U34 ( .A(n35), .Y(deser_en) );
  NAND2BX2M U35 ( .AN(current_state[0]), .B(current_state[1]), .Y(n33) );
  INVX2M U36 ( .A(edge_count[1]), .Y(n20) );
  NAND2X2M U37 ( .A(bit_count[3]), .B(n9), .Y(n13) );
  INVX2M U38 ( .A(strt_glitch), .Y(n22) );
  INVX2M U39 ( .A(bit_count[0]), .Y(n18) );
  NAND2BX1M U40 ( .AN(n33), .B(current_state[2]), .Y(n16) );
  OAI2B1X1M U41 ( .A1N(n34), .A0(n8), .B0(n33), .Y(next_state[1]) );
  AND3X2M U42 ( .A(bit_count[1]), .B(bit_count[3]), .C(stp_chk_en), .Y(n27) );
  OR4X1M U43 ( .A(n7), .B(n34), .C(par_err), .D(stp_err), .Y(n15) );
  OR3X2M U44 ( .A(n7), .B(n23), .C(current_state[2]), .Y(n35) );
  OR3X2M U45 ( .A(bit_count[0]), .B(n35), .C(n13), .Y(n12) );
  OR3X2M U46 ( .A(n33), .B(n18), .C(n13), .Y(n10) );
  OR3X2M U47 ( .A(bit_count[0]), .B(bit_count[3]), .C(n24), .Y(n25) );
endmodule


module edge_bit_counter ( CLK, RST, Enable, bit_count, edge_count );
  output [3:0] bit_count;
  output [2:0] edge_count;
  input CLK, RST, Enable;
  wire   N13, N14, n1, n3, n4, n18, n19, n20, n2, n5, n6, n7, n8, n9, n10, n11,
         n12, n13, n14, n15, n16, n17, n21, n22, n23, n24, n25, n26;

  DFFRX4M \bit_count_reg[3]  ( .D(n18), .CK(CLK), .RN(RST), .Q(bit_count[3]), 
        .QN(n4) );
  DFFRQX2M \bit_count_reg[2]  ( .D(n3), .CK(CLK), .RN(RST), .Q(bit_count[2])
         );
  DFFRHQX8M \bit_count_reg[0]  ( .D(n20), .CK(CLK), .RN(RST), .Q(bit_count[0])
         );
  DFFRHQX8M \edge_count_reg[2]  ( .D(n1), .CK(CLK), .RN(RST), .Q(edge_count[2]) );
  DFFRHQX8M \edge_count_reg[1]  ( .D(N14), .CK(CLK), .RN(RST), .Q(
        edge_count[1]) );
  DFFRHQX4M \bit_count_reg[1]  ( .D(n19), .CK(CLK), .RN(RST), .Q(bit_count[1])
         );
  DFFRHQX8M \edge_count_reg[0]  ( .D(N13), .CK(CLK), .RN(RST), .Q(
        edge_count[0]) );
  CLKXOR2X2M U3 ( .A(edge_count[1]), .B(edge_count[0]), .Y(n13) );
  NAND3X3M U4 ( .A(bit_count[1]), .B(n8), .C(bit_count[2]), .Y(n25) );
  CLKAND2X4M U5 ( .A(n8), .B(bit_count[1]), .Y(n10) );
  NAND2X12M U6 ( .A(n16), .B(n2), .Y(n5) );
  NAND2X2M U7 ( .A(bit_count[0]), .B(n11), .Y(n6) );
  NAND2X12M U8 ( .A(n5), .B(n6), .Y(n20) );
  INVX3M U9 ( .A(n11), .Y(n2) );
  INVX4M U10 ( .A(n21), .Y(n16) );
  NAND2BX2M U11 ( .AN(bit_count[0]), .B(Enable), .Y(n21) );
  CLKINVX32M U12 ( .A(n7), .Y(n11) );
  INVX20M U13 ( .A(Enable), .Y(n17) );
  AND3X4M U14 ( .A(n9), .B(bit_count[0]), .C(n7), .Y(n8) );
  AO21X8M U15 ( .A0(edge_count[2]), .A1(n14), .B0(n17), .Y(n7) );
  MX2X8M U16 ( .A(n10), .B(n24), .S0(bit_count[2]), .Y(n3) );
  NAND2BX8M U17 ( .AN(n11), .B(n21), .Y(n22) );
  INVX2M U18 ( .A(n17), .Y(n9) );
  AND2X2M U19 ( .A(n11), .B(n15), .Y(N13) );
  MXI2X8M U20 ( .A(n26), .B(n25), .S0(n4), .Y(n18) );
  INVX2M U21 ( .A(bit_count[1]), .Y(n23) );
  MX2XLM U22 ( .A(n8), .B(n22), .S0(bit_count[1]), .Y(n19) );
  OA21X1M U23 ( .A0(edge_count[2]), .A1(n14), .B0(n11), .Y(n1) );
  AND2X1M U24 ( .A(n11), .B(n13), .Y(N14) );
  INVX2M U25 ( .A(edge_count[0]), .Y(n15) );
  INVX2M U26 ( .A(n12), .Y(n14) );
  NAND2BX2M U27 ( .AN(n15), .B(edge_count[1]), .Y(n12) );
  AO21X4M U28 ( .A0(Enable), .A1(n23), .B0(n22), .Y(n24) );
  AOI2B1X8M U29 ( .A1N(bit_count[2]), .A0(Enable), .B0(n24), .Y(n26) );
endmodule


module data_sampling ( CLK, RST, S_DATA, Prescale, edge_count, Enable, 
        sampled_bit );
  input [4:0] Prescale;
  input [2:0] edge_count;
  input CLK, RST, S_DATA, Enable;
  output sampled_bit;
  wire   N58, n38, n39, n40, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12,
         n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26,
         n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n41, n42, n43,
         n44, n45, n46, n47, n48;
  wire   [2:0] Samples;

  DFFRQX2M \Samples_reg[2]  ( .D(n40), .CK(CLK), .RN(RST), .Q(Samples[2]) );
  DFFRQX2M \Samples_reg[1]  ( .D(n39), .CK(CLK), .RN(RST), .Q(Samples[1]) );
  DFFRQX2M \Samples_reg[0]  ( .D(n38), .CK(CLK), .RN(RST), .Q(Samples[0]) );
  DFFRHQX8M sampled_bit_reg ( .D(N58), .CK(CLK), .RN(RST), .Q(sampled_bit) );
  CLKNAND2X12M U3 ( .A(n15), .B(n9), .Y(n16) );
  NAND2X4M U4 ( .A(n35), .B(edge_count[2]), .Y(n18) );
  INVX2M U5 ( .A(n17), .Y(n35) );
  XOR2X4M U6 ( .A(n33), .B(edge_count[2]), .Y(n29) );
  CLKNAND2X12M U7 ( .A(n5), .B(n6), .Y(n33) );
  XOR2X4M U8 ( .A(n14), .B(edge_count[0]), .Y(n30) );
  XOR2X3M U9 ( .A(n23), .B(edge_count[1]), .Y(n26) );
  MXI2X6M U10 ( .A(edge_count[2]), .B(n35), .S0(n34), .Y(n12) );
  CLKAND2X2M U11 ( .A(Prescale[2]), .B(Prescale[1]), .Y(n1) );
  OR2X6M U12 ( .A(n1), .B(n2), .Y(n23) );
  NAND2BX12M U13 ( .AN(Prescale[1]), .B(n23), .Y(n15) );
  INVX6M U14 ( .A(n23), .Y(n13) );
  INVX20M U15 ( .A(n2), .Y(n7) );
  NAND2BX8M U16 ( .AN(Prescale[3]), .B(n2), .Y(n11) );
  NAND2X4M U17 ( .A(n29), .B(n17), .Y(n24) );
  CLKNAND2X16M U18 ( .A(n3), .B(Prescale[3]), .Y(n6) );
  CLKNAND2X4M U19 ( .A(n7), .B(n4), .Y(n5) );
  NAND2BX2M U20 ( .AN(n14), .B(n13), .Y(n31) );
  INVX10M U21 ( .A(Prescale[3]), .Y(n4) );
  MXI2X1M U22 ( .A(n12), .B(n24), .S0(n15), .Y(n20) );
  NAND2BX1M U23 ( .AN(n14), .B(n13), .Y(n10) );
  INVX1M U24 ( .A(n33), .Y(n34) );
  NAND2BX4M U25 ( .AN(n14), .B(n13), .Y(n9) );
  NOR2BX1M U26 ( .AN(n30), .B(n8), .Y(n19) );
  CLKINVX2M U27 ( .A(Prescale[1]), .Y(n14) );
  OR2X1M U28 ( .A(n30), .B(n24), .Y(n25) );
  INVX6M U29 ( .A(n7), .Y(n3) );
  NOR2X12M U30 ( .A(Prescale[2]), .B(Prescale[1]), .Y(n2) );
  NAND2XLM U31 ( .A(n30), .B(n8), .Y(n42) );
  MXI2X6M U32 ( .A(n28), .B(n45), .S0(n27), .Y(n39) );
  NAND2X1M U33 ( .A(Enable), .B(Samples[1]), .Y(n28) );
  NOR2X12M U34 ( .A(n26), .B(n25), .Y(n27) );
  NOR3X8M U35 ( .A(n43), .B(n42), .C(n41), .Y(n44) );
  NOR2BX2M U36 ( .AN(n10), .B(n29), .Y(n43) );
  OAI21X2M U37 ( .A0(n33), .A1(edge_count[2]), .B0(n32), .Y(n37) );
  MXI2X6M U38 ( .A(n46), .B(n45), .S0(n44), .Y(n38) );
  NAND2X1M U39 ( .A(Enable), .B(Samples[0]), .Y(n46) );
  XNOR2X8M U40 ( .A(n16), .B(edge_count[1]), .Y(n8) );
  AOI21BX1M U41 ( .A0(n48), .A1(n47), .B0N(Enable), .Y(N58) );
  NAND2X2M U42 ( .A(Enable), .B(S_DATA), .Y(n45) );
  MXI2X1M U43 ( .A(n22), .B(n45), .S0(n21), .Y(n40) );
  NAND2XLM U44 ( .A(Enable), .B(Samples[2]), .Y(n22) );
  AND3X2M U45 ( .A(n20), .B(n19), .C(n18), .Y(n21) );
  MXI2X1M U46 ( .A(n37), .B(n36), .S0(n35), .Y(n41) );
  NOR2BX1M U47 ( .AN(edge_count[2]), .B(n34), .Y(n36) );
  INVXLM U48 ( .A(n31), .Y(n32) );
  OAI21X2M U49 ( .A0(Samples[0]), .A1(Samples[1]), .B0(Samples[2]), .Y(n47) );
  NAND2X2M U50 ( .A(Samples[1]), .B(Samples[0]), .Y(n48) );
  XOR2X4M U51 ( .A(n11), .B(Prescale[4]), .Y(n17) );
endmodule


module deserializer ( CLK, RST, sampled_bit, Enable, edge_count, P_DATA );
  input [2:0] edge_count;
  output [7:0] P_DATA;
  input CLK, RST, sampled_bit, Enable;
  wire   n1, n2, n3, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n4, n18, n19, n20, n21, n22, n23, n24, n25, n29, n31, n33;

  OAI22X1M U3 ( .A0(n3), .A1(n2), .B0(n33), .B1(n29), .Y(n11) );
  OAI22X1M U5 ( .A0(n3), .A1(n29), .B0(n33), .B1(n5), .Y(n12) );
  DFFRQX2M \P_DATA_reg[2]  ( .D(n12), .CK(CLK), .RN(RST), .Q(P_DATA[2]) );
  DFFRX4M \P_DATA_reg[0]  ( .D(n10), .CK(CLK), .RN(RST), .Q(n25), .QN(n31) );
  DFFRX4M \P_DATA_reg[1]  ( .D(n11), .CK(CLK), .RN(RST), .Q(n4), .QN(n2) );
  DFFRX4M \P_DATA_reg[4]  ( .D(n23), .CK(CLK), .RN(RST), .QN(n6) );
  DFFRX4M \P_DATA_reg[7]  ( .D(n17), .CK(CLK), .RN(RST), .Q(n18), .QN(n9) );
  DFFRX4M \P_DATA_reg[5]  ( .D(n24), .CK(CLK), .RN(RST), .QN(n7) );
  DFFRHQX4M \P_DATA_reg[3]  ( .D(n13), .CK(CLK), .RN(RST), .Q(P_DATA[3]) );
  DFFRHQX8M \P_DATA_reg[6]  ( .D(n16), .CK(CLK), .RN(RST), .Q(P_DATA[6]) );
  CLKINVX16M U2 ( .A(n9), .Y(P_DATA[7]) );
  BUFX4M U4 ( .A(n1), .Y(n33) );
  CLKINVX1M U6 ( .A(P_DATA[3]), .Y(n5) );
  CLKINVX1M U7 ( .A(P_DATA[2]), .Y(n29) );
  CLKINVX1M U8 ( .A(P_DATA[6]), .Y(n8) );
  CLKNAND2X2M U9 ( .A(n19), .B(n20), .Y(n10) );
  CLKNAND2X2M U10 ( .A(n25), .B(n33), .Y(n19) );
  CLKNAND2X2M U11 ( .A(n4), .B(n3), .Y(n20) );
  CLKNAND2X2M U12 ( .A(n21), .B(n22), .Y(n17) );
  CLKNAND2X2M U13 ( .A(sampled_bit), .B(n3), .Y(n21) );
  CLKNAND2X2M U14 ( .A(n18), .B(n1), .Y(n22) );
  OA22XLM U15 ( .A0(n3), .A1(n6), .B0(n33), .B1(n7), .Y(n14) );
  INVXLM U16 ( .A(n14), .Y(n23) );
  OAI22X1M U17 ( .A0(n3), .A1(n8), .B0(n33), .B1(n9), .Y(n16) );
  OAI22X1M U18 ( .A0(n3), .A1(n5), .B0(n33), .B1(n6), .Y(n13) );
  OA22XLM U19 ( .A0(n3), .A1(n7), .B0(n33), .B1(n8), .Y(n15) );
  INVXLM U20 ( .A(n15), .Y(n24) );
  CLKINVX24M U21 ( .A(n7), .Y(P_DATA[5]) );
  CLKINVX24M U22 ( .A(n6), .Y(P_DATA[4]) );
  NAND4X2M U23 ( .A(edge_count[2]), .B(edge_count[1]), .C(edge_count[0]), .D(
        Enable), .Y(n1) );
  INVX4M U24 ( .A(n33), .Y(n3) );
  CLKINVX40M U25 ( .A(n2), .Y(P_DATA[1]) );
  CLKINVX40M U26 ( .A(n31), .Y(P_DATA[0]) );
endmodule


module strt_chk ( CLK, RST, sampled_bit, Enable, strt_glitch );
  input CLK, RST, sampled_bit, Enable;
  output strt_glitch;
  wire   n1;

  DFFRQX2M strt_glitch_reg ( .D(n1), .CK(CLK), .RN(RST), .Q(strt_glitch) );
  MX2XLM U2 ( .A(strt_glitch), .B(sampled_bit), .S0(Enable), .Y(n1) );
endmodule


module par_chk ( CLK, RST, parity_type, sampled_bit, Enable, P_DATA, par_err
 );
  input [7:0] P_DATA;
  input CLK, RST, parity_type, sampled_bit, Enable;
  output par_err;
  wire   n8, n1, n2, n3, n4, n5, n6, n7, n9, n10, n11;

  DFFRHQX8M par_err_reg ( .D(n8), .CK(CLK), .RN(RST), .Q(par_err) );
  INVX2M U2 ( .A(Enable), .Y(n3) );
  AOI21BX8M U3 ( .A0(n3), .A1(par_err), .B0N(n11), .Y(n1) );
  INVX6M U4 ( .A(n2), .Y(n10) );
  AND3X6M U5 ( .A(parity_type), .B(Enable), .C(n9), .Y(n2) );
  OR3X12M U6 ( .A(parity_type), .B(n3), .C(n9), .Y(n11) );
  XNOR3XLM U7 ( .A(P_DATA[7]), .B(sampled_bit), .C(P_DATA[6]), .Y(n4) );
  XOR3XLM U8 ( .A(P_DATA[4]), .B(P_DATA[5]), .C(n4), .Y(n5) );
  CLKXOR2X2M U9 ( .A(P_DATA[0]), .B(P_DATA[1]), .Y(n6) );
  CLKXOR2X2M U10 ( .A(P_DATA[2]), .B(P_DATA[3]), .Y(n7) );
  NAND2X12M U11 ( .A(n1), .B(n10), .Y(n8) );
  XOR3X2M U12 ( .A(n7), .B(n6), .C(n5), .Y(n9) );
endmodule


module stp_chk ( CLK, RST, sampled_bit, Enable, stp_err );
  input CLK, RST, sampled_bit, Enable;
  output stp_err;
  wire   n1, n2;

  OAI2BB2X1M U2 ( .B0(sampled_bit), .B1(n1), .A0N(stp_err), .A1N(n1), .Y(n2)
         );
  CLKINVX1M U3 ( .A(Enable), .Y(n1) );
  DFFRQX2M stp_err_reg ( .D(n2), .CK(CLK), .RN(RST), .Q(stp_err) );
endmodule


module UART_RX ( CLK, RST, RX_IN, Prescale, parity_enable, parity_type, P_DATA, 
        data_valid );
  input [4:0] Prescale;
  output [7:0] P_DATA;
  input CLK, RST, RX_IN, parity_enable, parity_type;
  output data_valid;
  wire   n15, n16, n17, n18, n19, strt_glitch, par_err, stp_err, strt_chk_en,
         edge_bit_en, deser_en, par_chk_en, stp_chk_en, dat_samp_en,
         sampled_bit, n1, n3, n4, n6, n7, n9, n10, n12, n13;
  wire   [3:0] bit_count;
  wire   [2:0] edge_count;

  uart_rx_fsm U0_uart_fsm ( .CLK(CLK), .RST(RST), .S_DATA(RX_IN), 
        .parity_enable(parity_enable), .bit_count(bit_count), .edge_count(
        edge_count), .par_err(par_err), .stp_err(stp_err), .strt_glitch(
        strt_glitch), .strt_chk_en(strt_chk_en), .edge_bit_en(edge_bit_en), 
        .deser_en(deser_en), .par_chk_en(par_chk_en), .stp_chk_en(stp_chk_en), 
        .dat_samp_en(dat_samp_en), .data_valid(n19) );
  edge_bit_counter U0_edge_bit_counter ( .CLK(CLK), .RST(RST), .Enable(
        edge_bit_en), .bit_count(bit_count), .edge_count(edge_count) );
  data_sampling U0_data_sampling ( .CLK(CLK), .RST(RST), .S_DATA(RX_IN), 
        .Prescale(Prescale), .edge_count(edge_count), .Enable(dat_samp_en), 
        .sampled_bit(sampled_bit) );
  deserializer U0_deserializer ( .CLK(CLK), .RST(RST), .sampled_bit(
        sampled_bit), .Enable(deser_en), .edge_count(edge_count), .P_DATA({
        P_DATA[7:4], n15, n16, n17, n18}) );
  strt_chk U0_strt_chk ( .CLK(CLK), .RST(RST), .sampled_bit(sampled_bit), 
        .Enable(strt_chk_en), .strt_glitch(strt_glitch) );
  par_chk U0_par_chk ( .CLK(CLK), .RST(RST), .parity_type(parity_type), 
        .sampled_bit(sampled_bit), .Enable(par_chk_en), .P_DATA({P_DATA[7:4], 
        n7, n13, n4, n10}), .par_err(par_err) );
  stp_chk U0_stp_chk ( .CLK(CLK), .RST(RST), .sampled_bit(sampled_bit), 
        .Enable(stp_chk_en), .stp_err(stp_err) );
  INVXLM U1 ( .A(n12), .Y(n13) );
  INVXLM U2 ( .A(n6), .Y(n7) );
  INVXLM U3 ( .A(n3), .Y(n4) );
  INVXLM U4 ( .A(n9), .Y(n10) );
  CLKINVX1M U5 ( .A(n19), .Y(n1) );
  CLKINVX40M U6 ( .A(n1), .Y(data_valid) );
  CLKINVX2M U7 ( .A(n17), .Y(n3) );
  CLKINVX40M U8 ( .A(n3), .Y(P_DATA[1]) );
  CLKINVX2M U9 ( .A(n15), .Y(n6) );
  CLKINVX40M U10 ( .A(n6), .Y(P_DATA[3]) );
  CLKINVX2M U11 ( .A(n18), .Y(n9) );
  CLKINVX40M U12 ( .A(n9), .Y(P_DATA[0]) );
  CLKINVX2M U13 ( .A(n16), .Y(n12) );
  CLKINVX40M U14 ( .A(n12), .Y(P_DATA[2]) );
endmodule


module UART ( RST, TX_CLK, RX_CLK, RX_IN_S, RX_OUT_P, RX_OUT_V, TX_IN_P, 
        TX_IN_V, TX_OUT_S, TX_OUT_V, Prescale, parity_enable, parity_type );
  output [7:0] RX_OUT_P;
  input [7:0] TX_IN_P;
  input [4:0] Prescale;
  input RST, TX_CLK, RX_CLK, RX_IN_S, TX_IN_V, parity_enable, parity_type;
  output RX_OUT_V, TX_OUT_S, TX_OUT_V;
  wire   n19, n20, n21, n22, n23, n1, n2, n3, n4, n6, n8, n10, n12, n14, n15,
         n16, n17, n18;

  UART_TX U0_UART_TX ( .CLK(TX_CLK), .RST(RST), .P_DATA(TX_IN_P), .Data_Valid(
        n17), .parity_enable(n1), .parity_type(n3), .TX_OUT(n23), .busy(
        TX_OUT_V) );
  UART_RX U0_UART_RX ( .CLK(RX_CLK), .RST(RST), .RX_IN(n18), .Prescale({
        Prescale[4:2], n16, Prescale[0]}), .parity_enable(n15), .parity_type(
        n14), .P_DATA({n19, n20, n21, n22, RX_OUT_P[3:0]}), .data_valid(
        RX_OUT_V) );
  DLY1X1M U1 ( .A(n15), .Y(n1) );
  BUFX14M U2 ( .A(parity_enable), .Y(n15) );
  INVXLM U3 ( .A(n14), .Y(n2) );
  INVX2M U4 ( .A(n2), .Y(n3) );
  BUFX20M U5 ( .A(parity_type), .Y(n14) );
  CLKINVX1M U6 ( .A(n19), .Y(n4) );
  CLKINVX40M U7 ( .A(n4), .Y(RX_OUT_P[7]) );
  CLKINVX1M U8 ( .A(n21), .Y(n6) );
  CLKINVX40M U9 ( .A(n6), .Y(RX_OUT_P[5]) );
  CLKINVX1M U10 ( .A(n20), .Y(n8) );
  CLKINVX40M U11 ( .A(n8), .Y(RX_OUT_P[6]) );
  CLKINVX1M U12 ( .A(n22), .Y(n10) );
  CLKINVX40M U13 ( .A(n10), .Y(RX_OUT_P[4]) );
  BUFX16M U14 ( .A(RX_IN_S), .Y(n18) );
  BUFX20M U15 ( .A(Prescale[1]), .Y(n16) );
  BUFX2M U16 ( .A(TX_IN_V), .Y(n17) );
  CLKINVX1M U17 ( .A(n23), .Y(n12) );
  CLKINVX40M U18 ( .A(n12), .Y(TX_OUT_S) );
endmodule

