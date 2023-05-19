/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06
// Date      : Sat Aug 13 16:29:18 2022
/////////////////////////////////////////////////////////////


module uart_tx_fsm ( CLK, RST, Data_Valid, ser_done, parity_enable, Ser_enable, 
        mux_sel, busy );
  output [1:0] mux_sel;
  input CLK, RST, Data_Valid, ser_done, parity_enable;
  output Ser_enable, busy;
  wire   busy_c, n1, n2, n3, n4, n5, n6, n7, n8, n9;
  wire   [2:0] current_state;
  wire   [2:0] next_state;

  DFFRQX4M \current_state_reg[2]  ( .D(next_state[2]), .CK(CLK), .RN(RST), .Q(
        current_state[2]) );
  DFFRQX2M busy_reg ( .D(busy_c), .CK(CLK), .RN(RST), .Q(busy) );
  DFFRX1M \current_state_reg[1]  ( .D(next_state[1]), .CK(CLK), .RN(RST), .Q(
        current_state[1]), .QN(n1) );
  DFFRX2M \current_state_reg[0]  ( .D(next_state[0]), .CK(CLK), .RN(RST), .Q(
        current_state[0]), .QN(n3) );
  INVX2M U3 ( .A(n9), .Y(n2) );
  NOR3X2M U4 ( .A(n1), .B(current_state[2]), .C(n4), .Y(next_state[2]) );
  AOI2B1X1M U5 ( .A1N(parity_enable), .A0(ser_done), .B0(n3), .Y(n4) );
  AOI21X2M U6 ( .A0(n6), .A1(n7), .B0(current_state[2]), .Y(next_state[0]) );
  NAND2BX2M U7 ( .AN(ser_done), .B(current_state[0]), .Y(n6) );
  OAI21X2M U8 ( .A0(Data_Valid), .A1(current_state[0]), .B0(n1), .Y(n7) );
  NOR3X4M U9 ( .A(n5), .B(ser_done), .C(current_state[2]), .Y(Ser_enable) );
  OAI21X4M U10 ( .A0(current_state[1]), .A1(n3), .B0(n8), .Y(n9) );
  NAND2X2M U11 ( .A(current_state[1]), .B(n3), .Y(n8) );
  NAND2X2M U12 ( .A(n2), .B(current_state[0]), .Y(n5) );
  OAI2B2X4M U13 ( .A1N(current_state[2]), .A0(n8), .B0(current_state[2]), .B1(
        n9), .Y(mux_sel[0]) );
  OAI21X2M U14 ( .A0(current_state[2]), .A1(current_state[0]), .B0(n8), .Y(
        mux_sel[1]) );
  AOI21X1M U15 ( .A0(n2), .A1(n5), .B0(current_state[2]), .Y(next_state[1]) );
  OAI21X1M U16 ( .A0(current_state[2]), .A1(n3), .B0(n8), .Y(busy_c) );
endmodule


module Serializer ( CLK, RST, DATA, Enable, Busy, Data_Valid, ser_out, 
        ser_done );
  input [7:0] DATA;
  input CLK, RST, Enable, Busy, Data_Valid;
  output ser_out, ser_done;
  wire   N23, N24, N25, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13,
         n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24;
  wire   [7:1] DATA_V;
  wire   [2:0] ser_count;

  DFFRX1M \ser_count_reg[2]  ( .D(N25), .CK(CLK), .RN(RST), .Q(ser_count[2]), 
        .QN(n1) );
  DFFRX1M \DATA_V_reg[6]  ( .D(n19), .CK(CLK), .RN(RST), .Q(DATA_V[6]) );
  DFFRX1M \DATA_V_reg[5]  ( .D(n20), .CK(CLK), .RN(RST), .Q(DATA_V[5]) );
  DFFRX1M \DATA_V_reg[4]  ( .D(n21), .CK(CLK), .RN(RST), .Q(DATA_V[4]) );
  DFFRX1M \DATA_V_reg[3]  ( .D(n22), .CK(CLK), .RN(RST), .Q(DATA_V[3]) );
  DFFRX1M \DATA_V_reg[2]  ( .D(n23), .CK(CLK), .RN(RST), .Q(DATA_V[2]) );
  DFFRX1M \DATA_V_reg[1]  ( .D(n24), .CK(CLK), .RN(RST), .Q(DATA_V[1]) );
  DFFRX1M \DATA_V_reg[0]  ( .D(n17), .CK(CLK), .RN(RST), .Q(ser_out) );
  DFFRX1M \DATA_V_reg[7]  ( .D(n18), .CK(CLK), .RN(RST), .Q(DATA_V[7]) );
  DFFRX2M \ser_count_reg[1]  ( .D(N24), .CK(CLK), .RN(RST), .Q(ser_count[1]), 
        .QN(n2) );
  DFFRX2M \ser_count_reg[0]  ( .D(N23), .CK(CLK), .RN(RST), .Q(ser_count[0])
         );
  NOR2BX12M U3 ( .AN(Data_Valid), .B(Busy), .Y(n7) );
  CLKXOR2X2M U4 ( .A(ser_count[0]), .B(n2), .Y(n16) );
  NAND2XLM U5 ( .A(ser_count[0]), .B(n1), .Y(n14) );
  AO22XLM U6 ( .A0(n4), .A1(DATA_V[7]), .B0(DATA[7]), .B1(n7), .Y(n18) );
  NOR2X8M U7 ( .A(n3), .B(n7), .Y(n6) );
  NOR2X8M U8 ( .A(n7), .B(n6), .Y(n4) );
  INVX2M U9 ( .A(Enable), .Y(n3) );
  OAI2BB1X2M U10 ( .A0N(ser_out), .A1N(n4), .B0(n5), .Y(n17) );
  AOI22X1M U11 ( .A0(DATA_V[1]), .A1(n6), .B0(DATA[0]), .B1(n7), .Y(n5) );
  OAI2BB1X2M U12 ( .A0N(DATA_V[1]), .A1N(n4), .B0(n13), .Y(n24) );
  AOI22X1M U13 ( .A0(DATA_V[2]), .A1(n6), .B0(DATA[1]), .B1(n7), .Y(n13) );
  OAI2BB1X2M U14 ( .A0N(n4), .A1N(DATA_V[2]), .B0(n12), .Y(n23) );
  AOI22X1M U15 ( .A0(DATA_V[3]), .A1(n6), .B0(DATA[2]), .B1(n7), .Y(n12) );
  OAI2BB1X2M U16 ( .A0N(n4), .A1N(DATA_V[3]), .B0(n11), .Y(n22) );
  AOI22X1M U17 ( .A0(DATA_V[4]), .A1(n6), .B0(DATA[3]), .B1(n7), .Y(n11) );
  OAI2BB1X2M U18 ( .A0N(n4), .A1N(DATA_V[4]), .B0(n10), .Y(n21) );
  AOI22X1M U19 ( .A0(DATA_V[5]), .A1(n6), .B0(DATA[4]), .B1(n7), .Y(n10) );
  OAI2BB1X2M U20 ( .A0N(n4), .A1N(DATA_V[5]), .B0(n9), .Y(n20) );
  AOI22X1M U21 ( .A0(DATA_V[6]), .A1(n6), .B0(DATA[5]), .B1(n7), .Y(n9) );
  OAI2BB1X2M U22 ( .A0N(n4), .A1N(DATA_V[6]), .B0(n8), .Y(n19) );
  AOI22X1M U23 ( .A0(DATA_V[7]), .A1(n6), .B0(DATA[6]), .B1(n7), .Y(n8) );
  NOR2X2M U24 ( .A(n3), .B(ser_count[0]), .Y(N23) );
  OAI32X2M U25 ( .A0(n14), .A1(n2), .A2(n3), .B0(n15), .B1(n1), .Y(N25) );
  AOI21X2M U26 ( .A0(Enable), .A1(n2), .B0(N23), .Y(n15) );
  NOR2X2M U27 ( .A(n16), .B(n3), .Y(N24) );
  AND3X2M U28 ( .A(ser_count[0]), .B(ser_count[2]), .C(ser_count[1]), .Y(
        ser_done) );
endmodule


module mux ( CLK, RST, IN_0, IN_1, IN_2, IN_3, SEL, OUT );
  input [1:0] SEL;
  input CLK, RST, IN_0, IN_1, IN_2, IN_3;
  output OUT;
  wire   n6, mux_out, n1, n2, n3, n4;

  DFFRX1M OUT_reg ( .D(mux_out), .CK(CLK), .RN(RST), .Q(n6) );
  CLKINVX1M U3 ( .A(n6), .Y(n4) );
  CLKINVX40M U4 ( .A(n4), .Y(OUT) );
  INVX2M U5 ( .A(SEL[0]), .Y(n1) );
  OAI2B2X1M U6 ( .A1N(SEL[1]), .A0(n2), .B0(SEL[1]), .B1(n3), .Y(mux_out) );
  AOI22X1M U7 ( .A0(IN_0), .A1(n1), .B0(SEL[0]), .B1(IN_1), .Y(n3) );
  AOI22X1M U8 ( .A0(IN_2), .A1(n1), .B0(IN_3), .B1(SEL[0]), .Y(n2) );
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
  DFFRX1M \DATA_V_reg[7]  ( .D(n15), .CK(CLK), .RN(RST), .Q(DATA_V[7]) );
  DFFRX1M \DATA_V_reg[6]  ( .D(n14), .CK(CLK), .RN(RST), .Q(DATA_V[6]) );
  DFFRX1M \DATA_V_reg[5]  ( .D(n13), .CK(CLK), .RN(RST), .Q(DATA_V[5]) );
  DFFRX1M \DATA_V_reg[4]  ( .D(n12), .CK(CLK), .RN(RST), .Q(DATA_V[4]) );
  DFFRX1M \DATA_V_reg[3]  ( .D(n11), .CK(CLK), .RN(RST), .Q(DATA_V[3]) );
  DFFRX1M \DATA_V_reg[2]  ( .D(n10), .CK(CLK), .RN(RST), .Q(DATA_V[2]) );
  DFFRX1M \DATA_V_reg[1]  ( .D(n9), .CK(CLK), .RN(RST), .Q(DATA_V[1]) );
  DFFRX1M \DATA_V_reg[0]  ( .D(n8), .CK(CLK), .RN(RST), .Q(DATA_V[0]) );
  DFFRX1M parity_reg ( .D(n7), .CK(CLK), .RN(RST), .Q(parity) );
  CLKBUFX8M U17 ( .A(Data_Valid), .Y(n16) );
endmodule


module UART_TX ( CLK, RST, P_DATA, Data_Valid, parity_enable, parity_type, 
        TX_OUT, busy );
  input [7:0] P_DATA;
  input CLK, RST, Data_Valid, parity_enable, parity_type;
  output TX_OUT, busy;
  wire   n4, seriz_en, seriz_done, ser_data, parity, n1, n3;
  wire   [1:0] mux_sel;

  uart_tx_fsm U0_fsm ( .CLK(CLK), .RST(RST), .Data_Valid(Data_Valid), 
        .ser_done(seriz_done), .parity_enable(parity_enable), .Ser_enable(
        seriz_en), .mux_sel(mux_sel), .busy(n4) );
  Serializer U0_Serializer ( .CLK(CLK), .RST(RST), .DATA(P_DATA), .Enable(
        seriz_en), .Busy(n3), .Data_Valid(Data_Valid), .ser_out(ser_data), 
        .ser_done(seriz_done) );
  mux U0_mux ( .CLK(CLK), .RST(RST), .IN_0(1'b0), .IN_1(ser_data), .IN_2(
        parity), .IN_3(1'b1), .SEL(mux_sel), .OUT(TX_OUT) );
  parity_calc U0_parity_calc ( .CLK(CLK), .RST(RST), .parity_enable(
        parity_enable), .parity_type(parity_type), .DATA(P_DATA), .Data_Valid(
        Data_Valid), .parity(parity) );
  INVX2M U1 ( .A(n1), .Y(n3) );
  CLKINVX2M U2 ( .A(n4), .Y(n1) );
  CLKINVX40M U3 ( .A(n1), .Y(busy) );
endmodule


module uart_rx_fsm ( CLK, RST, S_DATA, parity_enable, bit_count, edge_count, 
        par_err, stp_err, strt_glitch, strt_chk_en, edge_bit_en, deser_en, 
        par_chk_en, stp_chk_en, dat_samp_en, data_valid );
  input [3:0] bit_count;
  input [2:0] edge_count;
  input CLK, RST, S_DATA, parity_enable, par_err, stp_err, strt_glitch;
  output strt_chk_en, edge_bit_en, deser_en, par_chk_en, stp_chk_en,
         dat_samp_en, data_valid;
  wire   n7, \current_state[0] , n9, n3, n4, n5, n6, n8, n10, n11, n12, n13,
         n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n1;
  wire   [2:0] next_state;

  DFFRX4M \current_state_reg[2]  ( .D(n26), .CK(CLK), .RN(RST), .Q(n9), .QN(n4) );
  DFFRX4M \current_state_reg[1]  ( .D(next_state[1]), .CK(CLK), .RN(RST), .Q(
        n7), .QN(n5) );
  DFFRQX2M \current_state_reg[0]  ( .D(next_state[0]), .CK(CLK), .RN(RST), .Q(
        \current_state[0] ) );
  OR3X2M U33 ( .A(n4), .B(n7), .C(n6), .Y(n1) );
  INVX2M U34 ( .A(n1), .Y(data_valid) );
  AOI2B1X1M U35 ( .A1N(strt_glitch), .A0(n13), .B0(n7), .Y(n12) );
  NOR4BX2M U36 ( .AN(edge_count[0]), .B(edge_count[1]), .C(bit_count[2]), .D(
        bit_count[0]), .Y(n18) );
  NOR2X2M U37 ( .A(bit_count[2]), .B(bit_count[1]), .Y(n25) );
  NAND3BXLM U38 ( .AN(n21), .B(n23), .C(bit_count[3]), .Y(n22) );
  NOR4X2M U39 ( .A(n6), .B(n21), .C(bit_count[0]), .D(bit_count[3]), .Y(n13)
         );
  AND4XLM U40 ( .A(edge_count[2]), .B(stp_chk_en), .C(bit_count[1]), .D(
        bit_count[3]), .Y(n17) );
  NAND4X2M U41 ( .A(edge_count[2]), .B(edge_count[1]), .C(n25), .D(
        edge_count[0]), .Y(n21) );
  NAND2X2M U42 ( .A(n20), .B(n11), .Y(edge_bit_en) );
  OAI2BB1X2M U43 ( .A0N(n6), .A1N(S_DATA), .B0(n4), .Y(n20) );
  NAND2X2M U44 ( .A(n5), .B(n20), .Y(dat_samp_en) );
  NOR2X4M U45 ( .A(n4), .B(n11), .Y(stp_chk_en) );
  NOR2X2M U46 ( .A(n9), .B(n11), .Y(par_chk_en) );
  INVX2M U47 ( .A(\current_state[0] ), .Y(n6) );
  OAI2B11X2M U48 ( .A1N(data_valid), .A0(S_DATA), .B0(n14), .C0(n15), .Y(
        next_state[0]) );
  OAI31X2M U49 ( .A0(n8), .A1(bit_count[0]), .A2(n21), .B0(deser_en), .Y(n14)
         );
  AOI221X2M U50 ( .A0(n16), .A1(\current_state[0] ), .B0(n17), .B1(n18), .C0(
        n19), .Y(n15) );
  INVX2M U51 ( .A(bit_count[3]), .Y(n8) );
  NOR2X4M U52 ( .A(n20), .B(n7), .Y(strt_chk_en) );
  AOI21BX2M U53 ( .A0(strt_glitch), .A1(n13), .B0N(strt_chk_en), .Y(n19) );
  NAND3BX2M U54 ( .AN(n16), .B(n22), .C(n3), .Y(n26) );
  INVX2M U55 ( .A(stp_chk_en), .Y(n3) );
  OAI32X2M U56 ( .A0(n24), .A1(parity_enable), .A2(bit_count[0]), .B0(n11), 
        .B1(n10), .Y(n23) );
  NAND2X4M U57 ( .A(n7), .B(n6), .Y(n11) );
  NAND3X2M U58 ( .A(n7), .B(n4), .C(\current_state[0] ), .Y(n24) );
  OAI21X2M U59 ( .A0(n9), .A1(n12), .B0(n11), .Y(next_state[1]) );
  INVX2M U60 ( .A(n24), .Y(deser_en) );
  NOR4X4M U61 ( .A(n5), .B(n4), .C(stp_err), .D(par_err), .Y(n16) );
  INVX2M U62 ( .A(bit_count[0]), .Y(n10) );
endmodule


module edge_bit_counter ( CLK, RST, Enable, bit_count, edge_count );
  output [3:0] bit_count;
  output [2:0] edge_count;
  input CLK, RST, Enable;
  wire   N13, N14, n4, n6, n7, n18, n19, n20, n22, n23, n24, n25, n9, n10, n11,
         n12, n15, n16, n17, n21, n26, n27, n28, n29, n30;

  DFFRX4M \bit_count_reg[0]  ( .D(n20), .CK(CLK), .RN(RST), .Q(bit_count[0]), 
        .QN(n7) );
  DFFRX4M \edge_count_reg[1]  ( .D(N14), .CK(CLK), .RN(RST), .Q(edge_count[1]), 
        .QN(n24) );
  DFFRX4M \bit_count_reg[1]  ( .D(n19), .CK(CLK), .RN(RST), .Q(bit_count[1]), 
        .QN(n6) );
  DFFRX2M \edge_count_reg[0]  ( .D(N13), .CK(CLK), .RN(RST), .Q(edge_count[0]), 
        .QN(n23) );
  DFFRX2M \bit_count_reg[3]  ( .D(n18), .CK(CLK), .RN(RST), .Q(bit_count[3]), 
        .QN(n4) );
  DFFRX2M \edge_count_reg[2]  ( .D(n25), .CK(CLK), .RN(RST), .Q(edge_count[2]), 
        .QN(n22) );
  DFFRX2M \bit_count_reg[2]  ( .D(n10), .CK(CLK), .RN(RST), .Q(bit_count[2]), 
        .QN(n9) );
  AOI32X1M U22 ( .A0(n9), .A1(bit_count[1]), .A2(n17), .B0(bit_count[2]), .B1(
        n21), .Y(n16) );
  NAND4X2M U23 ( .A(n4), .B(n17), .C(bit_count[1]), .D(bit_count[2]), .Y(n29)
         );
  AOI21X2M U24 ( .A0(Enable), .A1(n7), .B0(n11), .Y(n27) );
  NOR2X2M U25 ( .A(n23), .B(n24), .Y(n30) );
  INVX2M U26 ( .A(Enable), .Y(n15) );
  OAI21X2M U27 ( .A0(n15), .A1(bit_count[1]), .B0(n27), .Y(n21) );
  INVX2M U28 ( .A(n26), .Y(n11) );
  INVX2M U29 ( .A(n30), .Y(n12) );
  OAI21X6M U30 ( .A0(n22), .A1(n12), .B0(Enable), .Y(n26) );
  NOR3X6M U31 ( .A(n11), .B(n7), .C(n15), .Y(n17) );
  OAI32X2M U32 ( .A0(bit_count[0]), .A1(n11), .A2(n15), .B0(n7), .B1(n26), .Y(
        n20) );
  OAI2BB2X1M U33 ( .B0(n6), .B1(n27), .A0N(n17), .A1N(n6), .Y(n19) );
  OAI21X2M U34 ( .A0(n4), .A1(n28), .B0(n29), .Y(n18) );
  AOI21X2M U35 ( .A0(n9), .A1(Enable), .B0(n21), .Y(n28) );
  INVX2M U36 ( .A(n16), .Y(n10) );
  AOI211X2M U37 ( .A0(n24), .A1(n23), .B0(n26), .C0(n30), .Y(N14) );
  AOI21X2M U38 ( .A0(n22), .A1(n12), .B0(n26), .Y(n25) );
  AND2X2M U39 ( .A(n23), .B(n11), .Y(N13) );
endmodule


module data_sampling ( CLK, RST, S_DATA, Prescale, edge_count, Enable, 
        sampled_bit );
  input [4:0] Prescale;
  input [2:0] edge_count;
  input CLK, RST, S_DATA, Enable;
  output sampled_bit;
  wire   N58, n38, n39, n40, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12,
         n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26,
         n27, n28, n29, n30, n31, n32, n33, n34;
  wire   [2:0] Samples;

  NOR3BX4M U7 ( .AN(n24), .B(n14), .C(n20), .Y(n23) );
  XNOR2X8M U17 ( .A(n32), .B(Prescale[4]), .Y(n17) );
  DFFRQX1M \Samples_reg[2]  ( .D(n40), .CK(CLK), .RN(RST), .Q(Samples[2]) );
  DFFRQX2M sampled_bit_reg ( .D(N58), .CK(CLK), .RN(RST), .Q(sampled_bit) );
  DFFRQX2M \Samples_reg[0]  ( .D(n38), .CK(CLK), .RN(RST), .Q(Samples[0]) );
  DFFRQX2M \Samples_reg[1]  ( .D(n39), .CK(CLK), .RN(RST), .Q(Samples[1]) );
  XNOR2X4M U39 ( .A(n31), .B(Prescale[3]), .Y(n16) );
  OAI21X2M U40 ( .A0(Samples[0]), .A1(Samples[1]), .B0(Samples[2]), .Y(n34) );
  NAND2XLM U41 ( .A(Samples[0]), .B(Samples[1]), .Y(n33) );
  XNOR2X4M U42 ( .A(Prescale[1]), .B(edge_count[0]), .Y(n14) );
  NOR2X2M U43 ( .A(n25), .B(Prescale[1]), .Y(n18) );
  NAND2X2M U44 ( .A(n30), .B(n9), .Y(n22) );
  INVX2M U45 ( .A(n18), .Y(n9) );
  INVX2M U46 ( .A(Enable), .Y(n10) );
  AOI222X2M U47 ( .A0(n16), .A1(n17), .B0(n18), .B1(n19), .C0(n20), .C1(n9), 
        .Y(n15) );
  OAI21X2M U48 ( .A0(n16), .A1(n17), .B0(n21), .Y(n19) );
  AOI222X2M U49 ( .A0(n17), .A1(n7), .B0(n8), .B1(n29), .C0(n30), .C1(n20), 
        .Y(n28) );
  INVX2M U50 ( .A(n30), .Y(n8) );
  OAI21X2M U51 ( .A0(n17), .A1(n7), .B0(n21), .Y(n29) );
  AOI21X4M U52 ( .A0(Prescale[1]), .A1(Prescale[2]), .B0(n31), .Y(n25) );
  NOR2X4M U53 ( .A(Prescale[1]), .B(Prescale[2]), .Y(n31) );
  NAND2X2M U54 ( .A(n25), .B(Prescale[1]), .Y(n30) );
  INVX2M U55 ( .A(n16), .Y(n7) );
  OR2X2M U56 ( .A(n21), .B(n17), .Y(n20) );
  NAND2X2M U57 ( .A(S_DATA), .B(Enable), .Y(n12) );
  NAND2BX2M U58 ( .AN(Prescale[3]), .B(n31), .Y(n32) );
  OAI32X2M U59 ( .A0(n3), .A1(n23), .A2(n10), .B0(n12), .B1(n5), .Y(n39) );
  INVX2M U60 ( .A(Samples[1]), .Y(n3) );
  INVX2M U61 ( .A(n23), .Y(n5) );
  OAI32X2M U62 ( .A0(n1), .A1(n6), .A2(n10), .B0(n11), .B1(n12), .Y(n40) );
  INVX2M U63 ( .A(Samples[2]), .Y(n1) );
  INVX2M U64 ( .A(n11), .Y(n6) );
  NAND3X2M U65 ( .A(n13), .B(n14), .C(n15), .Y(n11) );
  CLKXOR2X2M U66 ( .A(n7), .B(edge_count[2]), .Y(n21) );
  CLKXOR2X2M U67 ( .A(n22), .B(edge_count[1]), .Y(n13) );
  XNOR2X2M U68 ( .A(edge_count[1]), .B(n22), .Y(n27) );
  CLKXOR2X2M U69 ( .A(edge_count[1]), .B(n25), .Y(n24) );
  OAI32X2M U70 ( .A0(n2), .A1(n4), .A2(n10), .B0(n12), .B1(n26), .Y(n38) );
  INVX2M U71 ( .A(Samples[0]), .Y(n2) );
  INVX2M U72 ( .A(n26), .Y(n4) );
  NAND3X2M U73 ( .A(n14), .B(n27), .C(n28), .Y(n26) );
  AOI21X2M U74 ( .A0(n33), .A1(n34), .B0(n10), .Y(N58) );
endmodule


module deserializer ( CLK, RST, sampled_bit, Enable, edge_count, P_DATA );
  input [2:0] edge_count;
  output [7:0] P_DATA;
  input CLK, RST, sampled_bit, Enable;
  wire   n10, n11, n12, n13, n14, n15, n16, n17, n4, n5, n6, n7, n8, n9, n18,
         n19, n20, n21;

  DFFRQX1M \P_DATA_reg[3]  ( .D(n13), .CK(CLK), .RN(RST), .Q(P_DATA[3]) );
  DFFRQX1M \P_DATA_reg[2]  ( .D(n12), .CK(CLK), .RN(RST), .Q(P_DATA[2]) );
  DFFRQX1M \P_DATA_reg[7]  ( .D(n17), .CK(CLK), .RN(RST), .Q(P_DATA[7]) );
  DFFRQX2M \P_DATA_reg[1]  ( .D(n11), .CK(CLK), .RN(RST), .Q(P_DATA[1]) );
  DFFRQX2M \P_DATA_reg[0]  ( .D(n10), .CK(CLK), .RN(RST), .Q(P_DATA[0]) );
  DFFRX2M \P_DATA_reg[6]  ( .D(n16), .CK(CLK), .RN(RST), .QN(n9) );
  DFFRX2M \P_DATA_reg[4]  ( .D(n14), .CK(CLK), .RN(RST), .QN(n18) );
  DFFRX2M \P_DATA_reg[5]  ( .D(n15), .CK(CLK), .RN(RST), .QN(n8) );
  INVX2M U18 ( .A(n18), .Y(P_DATA[4]) );
  INVX2M U19 ( .A(n8), .Y(P_DATA[5]) );
  INVX2M U20 ( .A(n9), .Y(P_DATA[6]) );
  OAI22X1M U21 ( .A0(n19), .A1(n5), .B0(n21), .B1(n7), .Y(n11) );
  OAI22X1M U22 ( .A0(n6), .A1(n19), .B0(n21), .B1(n18), .Y(n13) );
  INVX2M U23 ( .A(P_DATA[3]), .Y(n6) );
  OAI2BB2X1M U24 ( .B0(n21), .B1(n5), .A0N(P_DATA[0]), .A1N(n21), .Y(n10) );
  NAND4X2M U25 ( .A(edge_count[2]), .B(edge_count[1]), .C(edge_count[0]), .D(
        Enable), .Y(n20) );
  CLKINVX2M U26 ( .A(P_DATA[7]), .Y(n4) );
  CLKINVX2M U27 ( .A(P_DATA[2]), .Y(n7) );
  OAI2BB2X1M U28 ( .B0(n19), .B1(n4), .A0N(sampled_bit), .A1N(n19), .Y(n17) );
  OAI22X1M U29 ( .A0(n19), .A1(n7), .B0(n21), .B1(n6), .Y(n12) );
  INVX4M U30 ( .A(n21), .Y(n19) );
  OAI22X1M U31 ( .A0(n19), .A1(n9), .B0(n21), .B1(n4), .Y(n16) );
  OAI22X1M U32 ( .A0(n19), .A1(n18), .B0(n21), .B1(n8), .Y(n14) );
  OAI22X1M U33 ( .A0(n19), .A1(n8), .B0(n21), .B1(n9), .Y(n15) );
  CLKINVX1M U34 ( .A(P_DATA[1]), .Y(n5) );
  CLKBUFX6M U35 ( .A(n20), .Y(n21) );
endmodule


module strt_chk ( CLK, RST, sampled_bit, Enable, strt_glitch );
  input CLK, RST, sampled_bit, Enable;
  output strt_glitch;
  wire   n1;

  DFFRQX2M strt_glitch_reg ( .D(n1), .CK(CLK), .RN(RST), .Q(strt_glitch) );
  AO2B2XLM U2 ( .B0(sampled_bit), .B1(Enable), .A0(strt_glitch), .A1N(Enable), 
        .Y(n1) );
endmodule


module par_chk ( CLK, RST, parity_type, sampled_bit, Enable, P_DATA, par_err
 );
  input [7:0] P_DATA;
  input CLK, RST, parity_type, sampled_bit, Enable;
  output par_err;
  wire   n8, n1, n2, n3, n5, n6, n4;

  DFFRQX1M par_err_reg ( .D(n8), .CK(CLK), .RN(RST), .Q(par_err) );
  XOR3XLM U8 ( .A(P_DATA[3]), .B(P_DATA[2]), .C(P_DATA[0]), .Y(n4) );
  XOR3XLM U9 ( .A(P_DATA[1]), .B(n4), .C(n5), .Y(n3) );
  XOR3XLM U10 ( .A(P_DATA[7]), .B(P_DATA[6]), .C(n6), .Y(n5) );
  XNOR2X2M U11 ( .A(sampled_bit), .B(parity_type), .Y(n6) );
  OAI2BB2X1M U12 ( .B0(n2), .B1(n1), .A0N(par_err), .A1N(n1), .Y(n8) );
  INVX2M U13 ( .A(Enable), .Y(n1) );
  XOR3XLM U14 ( .A(P_DATA[5]), .B(P_DATA[4]), .C(n3), .Y(n2) );
endmodule


module stp_chk ( CLK, RST, sampled_bit, Enable, stp_err );
  input CLK, RST, sampled_bit, Enable;
  output stp_err;
  wire   n2, n1;

  DFFRQX1M stp_err_reg ( .D(n2), .CK(CLK), .RN(RST), .Q(stp_err) );
  OAI2BB2X1M U3 ( .B0(sampled_bit), .B1(n1), .A0N(stp_err), .A1N(n1), .Y(n2)
         );
  INVX2M U4 ( .A(Enable), .Y(n1) );
endmodule


module UART_RX ( CLK, RST, RX_IN, Prescale, parity_enable, parity_type, P_DATA, 
        data_valid );
  input [4:0] Prescale;
  output [7:0] P_DATA;
  input CLK, RST, RX_IN, parity_enable, parity_type;
  output data_valid;
  wire   n27, n28, n29, n30, n31, n32, n33, n34, n35, strt_glitch, par_err,
         stp_err, strt_chk_en, edge_bit_en, deser_en, par_chk_en, stp_chk_en,
         dat_samp_en, sampled_bit, n1, n3, n4, n7, n8, n9, n10, n12, n13, n15,
         n16, n18, n19, n21, n22, n24, n25;
  wire   [3:0] bit_count;
  wire   [2:0] edge_count;

  uart_rx_fsm U0_uart_fsm ( .CLK(CLK), .RST(RST), .S_DATA(RX_IN), 
        .parity_enable(parity_enable), .bit_count(bit_count), .edge_count(
        edge_count), .par_err(par_err), .stp_err(stp_err), .strt_glitch(
        strt_glitch), .strt_chk_en(strt_chk_en), .edge_bit_en(edge_bit_en), 
        .deser_en(deser_en), .par_chk_en(par_chk_en), .stp_chk_en(stp_chk_en), 
        .dat_samp_en(dat_samp_en), .data_valid(n35) );
  edge_bit_counter U0_edge_bit_counter ( .CLK(CLK), .RST(RST), .Enable(
        edge_bit_en), .bit_count(bit_count), .edge_count(edge_count) );
  data_sampling U0_data_sampling ( .CLK(CLK), .RST(RST), .S_DATA(RX_IN), 
        .Prescale(Prescale), .edge_count(edge_count), .Enable(dat_samp_en), 
        .sampled_bit(sampled_bit) );
  deserializer U0_deserializer ( .CLK(CLK), .RST(RST), .sampled_bit(
        sampled_bit), .Enable(deser_en), .edge_count(edge_count), .P_DATA({n27, 
        n28, n29, n30, n31, n32, n33, n34}) );
  strt_chk U0_strt_chk ( .CLK(CLK), .RST(RST), .sampled_bit(sampled_bit), 
        .Enable(strt_chk_en), .strt_glitch(strt_glitch) );
  par_chk U0_par_chk ( .CLK(CLK), .RST(RST), .parity_type(parity_type), 
        .sampled_bit(sampled_bit), .Enable(par_chk_en), .P_DATA({n13, n19, n10, 
        n16, n4, n22, n7, n25}), .par_err(par_err) );
  stp_chk U0_stp_chk ( .CLK(CLK), .RST(RST), .sampled_bit(sampled_bit), 
        .Enable(stp_chk_en), .stp_err(stp_err) );
  INVX2M U1 ( .A(n12), .Y(n13) );
  INVX2M U2 ( .A(n18), .Y(n19) );
  INVX2M U3 ( .A(n3), .Y(n4) );
  INVX2M U4 ( .A(n21), .Y(n22) );
  INVX2M U5 ( .A(n24), .Y(n25) );
  BUFX2M U6 ( .A(n33), .Y(n7) );
  INVX2M U7 ( .A(n9), .Y(n10) );
  INVX2M U8 ( .A(n15), .Y(n16) );
  CLKINVX1M U9 ( .A(n35), .Y(n1) );
  CLKINVX40M U10 ( .A(n1), .Y(data_valid) );
  CLKINVX2M U11 ( .A(n31), .Y(n3) );
  CLKINVX40M U12 ( .A(n3), .Y(P_DATA[3]) );
  CLKINVX1M U13 ( .A(n33), .Y(n8) );
  CLKINVX40M U14 ( .A(n8), .Y(P_DATA[1]) );
  CLKINVX2M U15 ( .A(n29), .Y(n9) );
  CLKINVX40M U16 ( .A(n9), .Y(P_DATA[5]) );
  CLKINVX2M U17 ( .A(n27), .Y(n12) );
  CLKINVX40M U18 ( .A(n12), .Y(P_DATA[7]) );
  CLKINVX2M U19 ( .A(n30), .Y(n15) );
  CLKINVX40M U20 ( .A(n15), .Y(P_DATA[4]) );
  CLKINVX2M U21 ( .A(n28), .Y(n18) );
  CLKINVX40M U22 ( .A(n18), .Y(P_DATA[6]) );
  CLKINVX2M U23 ( .A(n32), .Y(n21) );
  CLKINVX40M U24 ( .A(n21), .Y(P_DATA[2]) );
  CLKINVX2M U25 ( .A(n34), .Y(n24) );
  CLKINVX40M U26 ( .A(n24), .Y(P_DATA[0]) );
endmodule


module UART ( RST, TX_CLK, RX_CLK, RX_IN_S, RX_OUT_P, RX_OUT_V, TX_IN_P, 
        TX_IN_V, TX_OUT_S, TX_OUT_V, Prescale, parity_enable, parity_type );
  output [7:0] RX_OUT_P;
  input [7:0] TX_IN_P;
  input [4:0] Prescale;
  input RST, TX_CLK, RX_CLK, RX_IN_S, TX_IN_V, parity_enable, parity_type;
  output RX_OUT_V, TX_OUT_S, TX_OUT_V;
  wire   n1, n2, n3, n4, n5;

  UART_TX U0_UART_TX ( .CLK(TX_CLK), .RST(RST), .P_DATA(TX_IN_P), .Data_Valid(
        n4), .parity_enable(n1), .parity_type(parity_type), .TX_OUT(TX_OUT_S), 
        .busy(TX_OUT_V) );
  UART_RX U0_UART_RX ( .CLK(RX_CLK), .RST(RST), .RX_IN(n5), .Prescale({
        Prescale[4:3], n3, n2, Prescale[0]}), .parity_enable(n1), 
        .parity_type(parity_type), .P_DATA(RX_OUT_P), .data_valid(RX_OUT_V) );
  BUFX4M U1 ( .A(Prescale[1]), .Y(n2) );
  BUFX2M U2 ( .A(RX_IN_S), .Y(n5) );
  BUFX2M U3 ( .A(Prescale[2]), .Y(n3) );
  BUFX2M U4 ( .A(parity_enable), .Y(n1) );
  BUFX2M U5 ( .A(TX_IN_V), .Y(n4) );
endmodule

