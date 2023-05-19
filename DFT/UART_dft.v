/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06
// Date      : Sat Aug 13 21:25:55 2022
/////////////////////////////////////////////////////////////


module mux2x1_2 ( in1, in2, sel, out );
  input in1, in2, sel;
  output out;


  MX2X6M U1 ( .A(in2), .B(in1), .S0(sel), .Y(out) );
endmodule


module mux2x1_1 ( in1, in2, sel, out );
  input in1, in2, sel;
  output out;


  MX2X6M U1 ( .A(in2), .B(in1), .S0(sel), .Y(out) );
endmodule


module mux2x1_0 ( in1, in2, sel, out );
  input in1, in2, sel;
  output out;


  MX2X6M U1 ( .A(in2), .B(in1), .S0(sel), .Y(out) );
endmodule


module uart_tx_fsm_test_1 ( CLK, RST, Data_Valid, ser_done, parity_enable, 
        Ser_enable, mux_sel, busy, test_si, test_so, test_se );
  output [1:0] mux_sel;
  input CLK, RST, Data_Valid, ser_done, parity_enable, test_si, test_se;
  output Ser_enable, busy, test_so;
  wire   busy_c, n8, n9, n10, n11, n12, n13, n5, n6, n7, n19, n20, n21, n1, n2,
         n3, n4;
  wire   [2:0] current_state;
  wire   [2:0] next_state;

  INVXLM U7 ( .A(current_state[0]), .Y(n5) );
  INVX4M U8 ( .A(n5), .Y(n6) );
  INVXLM U9 ( .A(current_state[2]), .Y(n7) );
  INVX4M U10 ( .A(n7), .Y(test_so) );
  INVX2M U15 ( .A(n13), .Y(n19) );
  AOI2B1X1M U17 ( .A1N(parity_enable), .A0(ser_done), .B0(n20), .Y(n8) );
  NAND2BX2M U19 ( .AN(ser_done), .B(n6), .Y(n10) );
  NOR3X4M U21 ( .A(n9), .B(ser_done), .C(test_so), .Y(Ser_enable) );
  OAI21X4M U22 ( .A0(current_state[1]), .A1(n20), .B0(n12), .Y(n13) );
  INVX2M U23 ( .A(n6), .Y(n20) );
  NAND2X2M U24 ( .A(current_state[1]), .B(n20), .Y(n12) );
  NAND2X2M U25 ( .A(n19), .B(n6), .Y(n9) );
  OAI2B2X4M U26 ( .A1N(test_so), .A0(n12), .B0(test_so), .B1(n13), .Y(
        mux_sel[0]) );
  OAI21X2M U27 ( .A0(test_so), .A1(n6), .B0(n12), .Y(mux_sel[1]) );
  AOI21X2M U28 ( .A0(n19), .A1(n9), .B0(test_so), .Y(next_state[1]) );
  OAI21X2M U29 ( .A0(test_so), .A1(n20), .B0(n12), .Y(busy_c) );
  SDFFRQX1M current_state_reg_0_ ( .D(next_state[0]), .SI(busy), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(current_state[0]) );
  SDFFRX1M current_state_reg_1_ ( .D(next_state[1]), .SI(n6), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(current_state[1]), .QN(n21) );
  SDFFRHQX1M busy_reg ( .D(busy_c), .SI(test_si), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(busy) );
  SDFFRHQX1M current_state_reg_2_ ( .D(n2), .SI(n4), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(current_state[2]) );
  AOI21X1M U3 ( .A0(n10), .A1(n11), .B0(test_so), .Y(next_state[0]) );
  OAI21X2M U4 ( .A0(Data_Valid), .A1(n6), .B0(n4), .Y(n11) );
  INVXLM U5 ( .A(n3), .Y(n1) );
  INVXLM U6 ( .A(n1), .Y(n2) );
  OR3X1M U11 ( .A(n4), .B(test_so), .C(n8), .Y(next_state[2]) );
  INVXLM U12 ( .A(next_state[2]), .Y(n3) );
  BUFX2M U13 ( .A(n21), .Y(n4) );
endmodule


module Serializer_test_1 ( CLK, RST, DATA, Enable, Busy, Data_Valid, ser_out, 
        ser_done, test_si, test_so, test_se );
  input [7:0] DATA;
  input CLK, RST, Enable, Busy, Data_Valid, test_si, test_se;
  output ser_out, ser_done, test_so;
  wire   N23, N24, N25, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25,
         n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n44, n45, n49, n1,
         n2, n3, n4, n5;
  wire   [7:1] DATA_V;
  wire   [2:0] ser_count;

  NOR2X8M U14 ( .A(n44), .B(n18), .Y(n17) );
  NOR2BX12M U15 ( .AN(Data_Valid), .B(Busy), .Y(n18) );
  NOR2X2M U27 ( .A(n44), .B(n3), .Y(N23) );
  NOR2X8M U28 ( .A(n18), .B(n17), .Y(n15) );
  INVX2M U29 ( .A(Enable), .Y(n44) );
  OAI2BB1X2M U30 ( .A0N(ser_out), .A1N(n15), .B0(n16), .Y(n28) );
  AOI22X1M U31 ( .A0(DATA_V[1]), .A1(n17), .B0(DATA[0]), .B1(n18), .Y(n16) );
  OAI2BB1X2M U32 ( .A0N(DATA_V[1]), .A1N(n15), .B0(n24), .Y(n35) );
  AOI22X1M U33 ( .A0(DATA_V[2]), .A1(n17), .B0(DATA[1]), .B1(n18), .Y(n24) );
  OAI2BB1X2M U34 ( .A0N(n15), .A1N(DATA_V[2]), .B0(n23), .Y(n34) );
  AOI22X1M U35 ( .A0(DATA_V[3]), .A1(n17), .B0(DATA[2]), .B1(n18), .Y(n23) );
  OAI2BB1X2M U36 ( .A0N(n15), .A1N(DATA_V[3]), .B0(n22), .Y(n33) );
  AOI22X1M U37 ( .A0(DATA_V[4]), .A1(n17), .B0(DATA[3]), .B1(n18), .Y(n22) );
  OAI2BB1X2M U38 ( .A0N(n15), .A1N(DATA_V[4]), .B0(n21), .Y(n32) );
  AOI22X1M U39 ( .A0(DATA_V[5]), .A1(n17), .B0(DATA[4]), .B1(n18), .Y(n21) );
  OAI2BB1X2M U40 ( .A0N(n15), .A1N(DATA_V[5]), .B0(n20), .Y(n31) );
  AOI22X1M U41 ( .A0(DATA_V[6]), .A1(n17), .B0(DATA[5]), .B1(n18), .Y(n20) );
  OAI2BB1X2M U42 ( .A0N(n15), .A1N(DATA_V[6]), .B0(n19), .Y(n30) );
  AOI22X1M U43 ( .A0(DATA_V[7]), .A1(n17), .B0(DATA[6]), .B1(n18), .Y(n19) );
  AO22X1M U44 ( .A0(n15), .A1(DATA_V[7]), .B0(DATA[7]), .B1(n18), .Y(n29) );
  AOI21X2M U47 ( .A0(Enable), .A1(n5), .B0(N23), .Y(n26) );
  AND3X2M U49 ( .A(n3), .B(ser_count[2]), .C(ser_count[1]), .Y(ser_done) );
  NOR2X2M U50 ( .A(n27), .B(n44), .Y(N24) );
  CLKXOR2X2M U51 ( .A(n5), .B(n49), .Y(n27) );
  DLY1X1M U53 ( .A(n3), .Y(n49) );
  SDFFRX1M ser_count_reg_1_ ( .D(N24), .SI(n49), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(ser_count[1]), .QN(n45) );
  SDFFRX1M ser_count_reg_0_ ( .D(N23), .SI(DATA_V[7]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(ser_count[0]) );
  SDFFRX1M ser_count_reg_2_ ( .D(N25), .SI(n5), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(ser_count[2]), .QN(test_so) );
  SDFFRX1M DATA_V_reg_6_ ( .D(n30), .SI(DATA_V[5]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(DATA_V[6]) );
  SDFFRX1M DATA_V_reg_5_ ( .D(n31), .SI(DATA_V[4]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(DATA_V[5]) );
  SDFFRX1M DATA_V_reg_4_ ( .D(n32), .SI(DATA_V[3]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(DATA_V[4]) );
  SDFFRX1M DATA_V_reg_3_ ( .D(n33), .SI(DATA_V[2]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(DATA_V[3]) );
  SDFFRX1M DATA_V_reg_2_ ( .D(n34), .SI(DATA_V[1]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(DATA_V[2]) );
  SDFFRX1M DATA_V_reg_1_ ( .D(n35), .SI(ser_out), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(DATA_V[1]) );
  SDFFRX1M DATA_V_reg_7_ ( .D(n29), .SI(DATA_V[6]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(DATA_V[7]) );
  SDFFRX1M DATA_V_reg_0_ ( .D(n28), .SI(test_si), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(ser_out) );
  OAI32X2M U3 ( .A0(n25), .A1(n5), .A2(n44), .B0(n26), .B1(test_so), .Y(N25)
         );
  INVXLM U4 ( .A(ser_count[2]), .Y(n1) );
  NAND2XLM U5 ( .A(n3), .B(n1), .Y(n25) );
  INVXLM U6 ( .A(ser_count[0]), .Y(n2) );
  INVX2M U7 ( .A(n2), .Y(n3) );
  INVXLM U8 ( .A(n45), .Y(n4) );
  INVX2M U9 ( .A(n4), .Y(n5) );
endmodule


module mux_test_1 ( CLK, RST, IN_0, IN_1, IN_2, IN_3, SEL, OUT, test_si, 
        test_se );
  input [1:0] SEL;
  input CLK, RST, IN_0, IN_1, IN_2, IN_3, test_si, test_se;
  output OUT;
  wire   n8, mux_out, n3, n4, n7, n1, n5;

  INVX2M U7 ( .A(SEL[0]), .Y(n7) );
  OAI2B2X1M U8 ( .A1N(SEL[1]), .A0(n3), .B0(SEL[1]), .B1(n4), .Y(mux_out) );
  AOI22X1M U9 ( .A0(IN_0), .A1(n7), .B0(SEL[0]), .B1(IN_1), .Y(n4) );
  AOI22X1M U10 ( .A0(IN_2), .A1(n7), .B0(IN_3), .B1(SEL[0]), .Y(n3) );
  SDFFRHQX1M OUT_reg ( .D(mux_out), .SI(test_si), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(n8) );
  CLKINVX1M U3 ( .A(n1), .Y(OUT) );
  CLKINVX1M U4 ( .A(n5), .Y(n1) );
  CLKBUFX1M U5 ( .A(n8), .Y(n5) );
endmodule


module parity_calc_test_1 ( CLK, RST, parity_enable, parity_type, DATA, 
        Data_Valid, parity, test_si, test_se );
  input [7:0] DATA;
  input CLK, RST, parity_enable, parity_type, Data_Valid, test_si, test_se;
  output parity;
  wire   n1, n3, n4, n5, n6, n8, n10, n12, n14, n16, n18, n20, n22, n24, n33,
         n34, n2, n7, n9, n11;
  wire   [7:0] DATA_V;

  CLKBUFX8M U11 ( .A(Data_Valid), .Y(n33) );
  OAI2BB2X1M U12 ( .B0(n1), .B1(n34), .A0N(parity), .A1N(n34), .Y(n8) );
  INVX2M U13 ( .A(parity_enable), .Y(n34) );
  XOR3XLM U14 ( .A(n3), .B(parity_type), .C(n4), .Y(n1) );
  XOR3XLM U15 ( .A(DATA_V[1]), .B(DATA_V[0]), .C(n5), .Y(n4) );
  AO2B2X2M U16 ( .B0(DATA[1]), .B1(n33), .A0(DATA_V[1]), .A1N(n33), .Y(n12) );
  AO2B2X2M U26 ( .B0(DATA[2]), .B1(n33), .A0(DATA_V[2]), .A1N(n33), .Y(n14) );
  AO2B2X2M U27 ( .B0(DATA[3]), .B1(n33), .A0(n7), .A1N(n33), .Y(n16) );
  AO2B2X2M U28 ( .B0(DATA[4]), .B1(n33), .A0(DATA_V[4]), .A1N(n33), .Y(n18) );
  AO2B2X2M U29 ( .B0(DATA[5]), .B1(n33), .A0(DATA_V[5]), .A1N(n33), .Y(n20) );
  AO2B2X2M U30 ( .B0(DATA[6]), .B1(n33), .A0(DATA_V[6]), .A1N(n33), .Y(n22) );
  AO2B2X2M U31 ( .B0(n33), .B1(DATA[0]), .A0(DATA_V[0]), .A1N(n33), .Y(n10) );
  AO2B2X2M U32 ( .B0(DATA[7]), .B1(n33), .A0(n11), .A1N(n33), .Y(n24) );
  XNOR2X2M U33 ( .A(DATA_V[2]), .B(n7), .Y(n5) );
  XOR3XLM U34 ( .A(DATA_V[5]), .B(DATA_V[4]), .C(n6), .Y(n3) );
  CLKXOR2X2M U35 ( .A(n11), .B(DATA_V[6]), .Y(n6) );
  SDFFRX1M DATA_V_reg_7_ ( .D(n24), .SI(DATA_V[6]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(DATA_V[7]) );
  SDFFRX1M DATA_V_reg_6_ ( .D(n22), .SI(DATA_V[5]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(DATA_V[6]) );
  SDFFRX1M DATA_V_reg_5_ ( .D(n20), .SI(DATA_V[4]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(DATA_V[5]) );
  SDFFRX1M DATA_V_reg_4_ ( .D(n18), .SI(n7), .SE(test_se), .CK(CLK), .RN(RST), 
        .Q(DATA_V[4]) );
  SDFFRX1M DATA_V_reg_3_ ( .D(n16), .SI(DATA_V[2]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(DATA_V[3]) );
  SDFFRX1M DATA_V_reg_0_ ( .D(n10), .SI(test_si), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(DATA_V[0]) );
  SDFFRX1M parity_reg ( .D(n8), .SI(n11), .SE(test_se), .CK(CLK), .RN(RST), 
        .Q(parity) );
  SDFFRX2M DATA_V_reg_1_ ( .D(n12), .SI(DATA_V[0]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(DATA_V[1]) );
  SDFFRX2M DATA_V_reg_2_ ( .D(n14), .SI(DATA_V[1]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(DATA_V[2]) );
  INVXLM U2 ( .A(DATA_V[3]), .Y(n2) );
  INVX2M U3 ( .A(n2), .Y(n7) );
  INVXLM U4 ( .A(DATA_V[7]), .Y(n9) );
  INVX2M U5 ( .A(n9), .Y(n11) );
endmodule


module UART_TX_test_1 ( CLK, RST, P_DATA, Data_Valid, parity_enable, 
        parity_type, TX_OUT, busy, test_si, test_so, test_se );
  input [7:0] P_DATA;
  input CLK, RST, Data_Valid, parity_enable, parity_type, test_si, test_se;
  output TX_OUT, busy, test_so;
  wire   n4, seriz_en, seriz_done, ser_data, n1, n3, n5, n6;
  wire   [1:0] mux_sel;

  uart_tx_fsm_test_1 U0_fsm ( .CLK(CLK), .RST(RST), .Data_Valid(Data_Valid), 
        .ser_done(seriz_done), .parity_enable(parity_enable), .Ser_enable(
        seriz_en), .mux_sel(mux_sel), .busy(n4), .test_si(n6), .test_so(n5), 
        .test_se(test_se) );
  Serializer_test_1 U0_Serializer ( .CLK(CLK), .RST(RST), .DATA(P_DATA), 
        .Enable(seriz_en), .Busy(n3), .Data_Valid(Data_Valid), .ser_out(
        ser_data), .ser_done(seriz_done), .test_si(test_si), .test_so(n6), 
        .test_se(test_se) );
  mux_test_1 U0_mux ( .CLK(CLK), .RST(RST), .IN_0(1'b0), .IN_1(ser_data), 
        .IN_2(test_so), .IN_3(1'b1), .SEL(mux_sel), .OUT(TX_OUT), .test_si(n5), 
        .test_se(test_se) );
  parity_calc_test_1 U0_parity_calc ( .CLK(CLK), .RST(RST), .parity_enable(
        parity_enable), .parity_type(parity_type), .DATA(P_DATA), .Data_Valid(
        Data_Valid), .parity(test_so), .test_si(TX_OUT), .test_se(test_se) );
  CLKINVX40M U1 ( .A(n1), .Y(busy) );
  CLKINVX2M U2 ( .A(n4), .Y(n1) );
  INVX32M U3 ( .A(n1), .Y(n3) );
endmodule


module uart_rx_fsm_test_1 ( CLK, RST, S_DATA, parity_enable, bit_count, 
        edge_count, par_err, stp_err, strt_glitch, strt_chk_en, edge_bit_en, 
        deser_en, par_chk_en, stp_chk_en, dat_samp_en, data_valid, test_so, 
        test_se );
  input [3:0] bit_count;
  input [2:0] edge_count;
  input CLK, RST, S_DATA, parity_enable, par_err, stp_err, strt_glitch,
         test_se;
  output strt_chk_en, edge_bit_en, deser_en, par_chk_en, stp_chk_en,
         dat_samp_en, data_valid, test_so;
  wire   n27, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n4, n7, n24, n26, n29, n30, n1, n2, n3, n5, n6, n28,
         n31, n33;
  wire   [2:0] current_state;
  wire   [2:0] next_state;

  BUFX2M U6 ( .A(n13), .Y(n4) );
  NAND3BX1M U8 ( .AN(bit_count[0]), .B(n4), .C(bit_count[3]), .Y(n14) );
  OAI21X4M U9 ( .A0(n2), .A1(n26), .B0(test_so), .Y(n8) );
  INVX2M U10 ( .A(n28), .Y(n24) );
  NAND2X2M U11 ( .A(n9), .B(n8), .Y(edge_bit_en) );
  INVX2M U12 ( .A(S_DATA), .Y(n26) );
  NAND2X2M U13 ( .A(n24), .B(n8), .Y(dat_samp_en) );
  NOR2X4M U14 ( .A(test_so), .B(n9), .Y(stp_chk_en) );
  NOR2X2M U15 ( .A(n5), .B(n9), .Y(par_chk_en) );
  INVX4M U16 ( .A(n2), .Y(n7) );
  INVX4M U17 ( .A(n5), .Y(test_so) );
  NOR2X2M U18 ( .A(n28), .B(n8), .Y(strt_chk_en) );
  OAI22X1M U19 ( .A0(n2), .A1(S_DATA), .B0(n23), .B1(n7), .Y(n19) );
  NOR4BBX1M U20 ( .AN(strt_glitch), .BN(n4), .C(bit_count[3]), .D(bit_count[0]), .Y(n23) );
  OAI211X2M U21 ( .A0(n7), .A1(n12), .B0(n17), .C0(n18), .Y(next_state[0]) );
  AOI31X2M U22 ( .A0(n24), .A1(test_so), .A2(n19), .B0(n20), .Y(n17) );
  AOI22X1M U23 ( .A0(deser_en), .A1(n14), .B0(n27), .B1(n26), .Y(n18) );
  AND4X2M U24 ( .A(n21), .B(bit_count[3]), .C(bit_count[1]), .D(stp_chk_en), 
        .Y(n20) );
  NAND4BBX1M U25 ( .AN(n10), .BN(stp_chk_en), .C(n11), .D(n12), .Y(
        next_state[2]) );
  NAND4BX1M U26 ( .AN(n9), .B(bit_count[3]), .C(bit_count[0]), .D(n4), .Y(n11)
         );
  NOR3BX2M U27 ( .AN(deser_en), .B(parity_enable), .C(n14), .Y(n10) );
  NAND2X4M U29 ( .A(n28), .B(n7), .Y(n9) );
  OAI21X2M U30 ( .A0(n5), .A1(n15), .B0(n9), .Y(next_state[1]) );
  AOI31X1M U31 ( .A0(n2), .A1(n4), .A2(n16), .B0(n28), .Y(n15) );
  NOR3X2M U32 ( .A(bit_count[0]), .B(n29), .C(bit_count[3]), .Y(n16) );
  NOR3X6M U33 ( .A(n7), .B(n5), .C(n30), .Y(deser_en) );
  OR4X1M U35 ( .A(n24), .B(test_so), .C(stp_err), .D(par_err), .Y(n12) );
  DLY1X1M U39 ( .A(strt_glitch), .Y(n29) );
  INVXLM U40 ( .A(n28), .Y(n30) );
  SDFFRHQX1M current_state_reg_1_ ( .D(next_state[1]), .SI(n7), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(current_state[1]) );
  SDFFRHQX1M current_state_reg_2_ ( .D(next_state[2]), .SI(n24), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(current_state[2]) );
  SDFFRHQX1M current_state_reg_0_ ( .D(next_state[0]), .SI(n29), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(current_state[0]) );
  NOR3X2M U3 ( .A(edge_count[1]), .B(bit_count[0]), .C(n22), .Y(n21) );
  NAND3BX2M U4 ( .AN(bit_count[2]), .B(edge_count[0]), .C(edge_count[2]), .Y(
        n22) );
  NOR3BX2M U5 ( .AN(edge_count[1]), .B(n22), .C(bit_count[1]), .Y(n13) );
  BUFX2M U7 ( .A(n27), .Y(n33) );
  NOR3X4M U28 ( .A(test_so), .B(n28), .C(n7), .Y(n27) );
  INVXLM U34 ( .A(current_state[0]), .Y(n1) );
  INVX2M U36 ( .A(n1), .Y(n2) );
  INVXLM U37 ( .A(current_state[2]), .Y(n3) );
  INVX2M U38 ( .A(n3), .Y(n5) );
  INVXLM U41 ( .A(current_state[1]), .Y(n6) );
  INVX4M U42 ( .A(n6), .Y(n28) );
  CLKINVX1M U43 ( .A(n33), .Y(n31) );
  CLKINVX40M U44 ( .A(n31), .Y(data_valid) );
endmodule


module edge_bit_counter_test_1 ( CLK, RST, Enable, bit_count, edge_count, 
        test_si, test_se );
  output [3:0] bit_count;
  output [2:0] edge_count;
  input CLK, RST, Enable, test_si, test_se;
  wire   n35, n36, n37, n38, n39, N13, N14, n16, n17, n18, n19, n20, n21, n22,
         n23, n24, n25, n26, n27, n8, n9, n10, n14, n15, n28, n29, n30, n31,
         n32, n1, n3, n4, n5, n7, n12, n33;

  NOR3X6M U10 ( .A(n32), .B(n9), .C(n29), .Y(n18) );
  INVXLM U11 ( .A(n22), .Y(n8) );
  INVX4M U12 ( .A(n8), .Y(n9) );
  INVX4M U15 ( .A(n4), .Y(bit_count[3]) );
  NAND4X1M U17 ( .A(bit_count[2]), .B(bit_count[1]), .C(n18), .D(n4), .Y(n17)
         );
  INVX2M U18 ( .A(Enable), .Y(n32) );
  CLKINVX2M U19 ( .A(n9), .Y(n14) );
  AOI21X2M U20 ( .A0(n29), .A1(Enable), .B0(n9), .Y(n21) );
  OAI32X2M U21 ( .A0(n32), .A1(bit_count[0]), .A2(n9), .B0(n29), .B1(n14), .Y(
        n27) );
  OAI21X2M U22 ( .A0(bit_count[1]), .A1(n32), .B0(n21), .Y(n19) );
  OAI21X2M U23 ( .A0(n16), .A1(n4), .B0(n17), .Y(n25) );
  AOI21X2M U24 ( .A0(Enable), .A1(n31), .B0(n19), .Y(n16) );
  NOR2X2M U25 ( .A(n24), .B(n14), .Y(N14) );
  XNOR2X2M U26 ( .A(edge_count[1]), .B(edge_count[0]), .Y(n24) );
  NOR2X2M U27 ( .A(edge_count[0]), .B(n14), .Y(N13) );
  INVX2M U28 ( .A(n23), .Y(n15) );
  AOI32X1M U29 ( .A0(n9), .A1(edge_count[0]), .A2(edge_count[1]), .B0(
        edge_count[2]), .B1(n9), .Y(n23) );
  INVX2M U30 ( .A(n20), .Y(n28) );
  AOI32X1M U31 ( .A0(bit_count[1]), .A1(n31), .A2(n18), .B0(n19), .B1(
        bit_count[2]), .Y(n20) );
  OAI2BB2X1M U32 ( .B0(n21), .B1(n30), .A0N(n30), .A1N(n18), .Y(n26) );
  INVX2M U33 ( .A(bit_count[1]), .Y(n30) );
  INVX2M U34 ( .A(bit_count[0]), .Y(n29) );
  INVX2M U35 ( .A(bit_count[2]), .Y(n31) );
  SDFFRX1M bit_count_reg_3_ ( .D(n25), .SI(n31), .SE(test_se), .CK(CLK), .RN(
        RST), .QN(n10) );
  SDFFRHQX4M edge_count_reg_1_ ( .D(N14), .SI(edge_count[0]), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(edge_count[1]) );
  SDFFRHQX1M edge_count_reg_0_ ( .D(N13), .SI(n4), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(n39) );
  SDFFRHQX1M bit_count_reg_0_ ( .D(n27), .SI(test_si), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(n37) );
  SDFFRHQX1M edge_count_reg_2_ ( .D(n15), .SI(edge_count[1]), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(n38) );
  SDFFRHQX1M bit_count_reg_1_ ( .D(n26), .SI(bit_count[0]), .SE(test_se), .CK(
        CLK), .RN(RST), .Q(n36) );
  SDFFRHQX1M bit_count_reg_2_ ( .D(n28), .SI(n30), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(n35) );
  AOI31X2M U3 ( .A0(edge_count[2]), .A1(edge_count[0]), .A2(edge_count[1]), 
        .B0(n32), .Y(n22) );
  INVXLM U4 ( .A(n35), .Y(n1) );
  INVX2M U5 ( .A(n1), .Y(bit_count[2]) );
  INVXLM U6 ( .A(n10), .Y(n3) );
  INVX2M U7 ( .A(n3), .Y(n4) );
  INVXLM U8 ( .A(n36), .Y(n5) );
  INVX4M U9 ( .A(n5), .Y(bit_count[1]) );
  INVXLM U13 ( .A(n38), .Y(n7) );
  INVX4M U14 ( .A(n7), .Y(edge_count[2]) );
  INVXLM U16 ( .A(n37), .Y(n12) );
  INVX4M U36 ( .A(n12), .Y(bit_count[0]) );
  INVXLM U37 ( .A(n39), .Y(n33) );
  INVX4M U38 ( .A(n33), .Y(edge_count[0]) );
endmodule


module data_sampling_test_1 ( CLK, RST, S_DATA, Prescale, edge_count, Enable, 
        sampled_bit, test_si, test_se );
  input [4:0] Prescale;
  input [2:0] edge_count;
  input CLK, RST, S_DATA, Enable, test_si, test_se;
  output sampled_bit;
  wire   n12, N58, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28,
         n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n40, n41, n42, n43,
         n44, n1, n2, n3, n4, n5, n6, n11, n14, n7, n8, n9;
  wire   [2:0] Samples;

  CLKXOR2X2M U7 ( .A(n37), .B(Prescale[3]), .Y(n25) );
  XOR3XLM U8 ( .A(n26), .B(edge_count[2]), .C(n25), .Y(n19) );
  INVX2M U9 ( .A(Enable), .Y(n6) );
  AOI21X4M U10 ( .A0(Prescale[1]), .A1(Prescale[2]), .B0(n37), .Y(n30) );
  NOR2X4M U11 ( .A(Prescale[2]), .B(Prescale[1]), .Y(n37) );
  CLKXOR2X2M U12 ( .A(n23), .B(n24), .Y(n20) );
  NOR2X2M U13 ( .A(n25), .B(n26), .Y(n24) );
  NAND2X2M U14 ( .A(n30), .B(Prescale[1]), .Y(n26) );
  CLKXOR2X2M U15 ( .A(n23), .B(n36), .Y(n33) );
  NOR2X2M U16 ( .A(n11), .B(n35), .Y(n36) );
  INVX2M U17 ( .A(n25), .Y(n11) );
  OR2X2M U18 ( .A(Prescale[1]), .B(n30), .Y(n35) );
  NAND2X2M U19 ( .A(S_DATA), .B(Enable), .Y(n17) );
  OAI32X2M U20 ( .A0(n3), .A1(n5), .A2(n6), .B0(n17), .B1(n18), .Y(n42) );
  INVX2M U21 ( .A(n8), .Y(n3) );
  INVX2M U22 ( .A(n18), .Y(n5) );
  NAND4X2M U23 ( .A(n19), .B(n20), .C(n21), .D(n22), .Y(n18) );
  OAI32X2M U24 ( .A0(n2), .A1(n4), .A2(n6), .B0(n17), .B1(n27), .Y(n43) );
  INVX2M U25 ( .A(Samples[1]), .Y(n2) );
  INVX2M U26 ( .A(n27), .Y(n4) );
  NAND4BX2M U27 ( .AN(n21), .B(n28), .C(n23), .D(n29), .Y(n27) );
  CLKXOR2X2M U28 ( .A(n1), .B(edge_count[1]), .Y(n22) );
  AND2X2M U29 ( .A(n35), .B(n26), .Y(n1) );
  CLKXOR2X2M U30 ( .A(n11), .B(edge_count[2]), .Y(n28) );
  OAI2BB2X1M U31 ( .B0(n31), .B1(n17), .A0N(n31), .A1N(n14), .Y(n44) );
  AND2X2M U32 ( .A(n32), .B(Enable), .Y(n31) );
  NAND4BX1M U33 ( .AN(n22), .B(n33), .C(n34), .D(n21), .Y(n32) );
  XOR3XLM U34 ( .A(edge_count[2]), .B(n35), .C(n25), .Y(n34) );
  CLKXOR2X2M U35 ( .A(n38), .B(Prescale[4]), .Y(n23) );
  NAND2BX2M U36 ( .AN(Prescale[3]), .B(n37), .Y(n38) );
  XNOR2X4M U37 ( .A(Prescale[1]), .B(edge_count[0]), .Y(n21) );
  CLKXOR2X2M U38 ( .A(edge_count[1]), .B(n30), .Y(n29) );
  AOI21X2M U39 ( .A0(n40), .A1(n41), .B0(n6), .Y(N58) );
  DLY1X1M U42 ( .A(Samples[2]), .Y(n14) );
  SDFFRHQX1M sampled_bit_reg ( .D(N58), .SI(n14), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(n12) );
  SDFFRHQX2M Samples_reg_1_ ( .D(n43), .SI(n8), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(Samples[1]) );
  SDFFRHQX1M Samples_reg_2_ ( .D(n44), .SI(Samples[1]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(Samples[2]) );
  SDFFRHQX1M Samples_reg_0_ ( .D(n42), .SI(test_si), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(Samples[0]) );
  OAI21X2M U3 ( .A0(n8), .A1(Samples[1]), .B0(Samples[2]), .Y(n41) );
  INVXLM U4 ( .A(Samples[0]), .Y(n7) );
  INVX2M U5 ( .A(n7), .Y(n8) );
  NAND2XLM U6 ( .A(Samples[1]), .B(n8), .Y(n40) );
  INVXLM U40 ( .A(n12), .Y(n9) );
  INVX4M U41 ( .A(n9), .Y(sampled_bit) );
endmodule


module deserializer_test_1 ( CLK, RST, sampled_bit, Enable, edge_count, P_DATA, 
        test_so, test_se );
  input [2:0] edge_count;
  output [7:0] P_DATA;
  input CLK, RST, sampled_bit, Enable, test_se;
  output test_so;
  wire   n28, n1, n11, n13, n15, n17, n19, n21, n23, n25, n3, n4, n6, n7, n8,
         n9, n26, n27, n30, n31, n32;

  INVX2M U2 ( .A(n28), .Y(n3) );
  CLKINVX1M U3 ( .A(n3), .Y(P_DATA[3]) );
  CLKINVX2M U4 ( .A(P_DATA[1]), .Y(n26) );
  CLKINVX2M U5 ( .A(P_DATA[7]), .Y(test_so) );
  CLKINVX2M U6 ( .A(P_DATA[6]), .Y(n6) );
  OAI2BB2X1M U8 ( .B0(n4), .B1(n26), .A0N(P_DATA[0]), .A1N(n4), .Y(n11) );
  INVX4M U9 ( .A(n4), .Y(n27) );
  OAI22X1M U10 ( .A0(n27), .A1(n26), .B0(n4), .B1(n9), .Y(n13) );
  OAI22X1M U11 ( .A0(n27), .A1(n32), .B0(n4), .B1(n3), .Y(n15) );
  OAI22X1M U13 ( .A0(n27), .A1(n3), .B0(n4), .B1(n8), .Y(n17) );
  OAI22X1M U14 ( .A0(n27), .A1(n31), .B0(n4), .B1(n7), .Y(n19) );
  OAI22X1M U15 ( .A0(n27), .A1(n30), .B0(n4), .B1(n6), .Y(n21) );
  CLKINVX1M U16 ( .A(P_DATA[2]), .Y(n9) );
  CLKINVX1M U17 ( .A(P_DATA[4]), .Y(n8) );
  CLKINVX1M U18 ( .A(P_DATA[5]), .Y(n7) );
  CLKBUFX6M U27 ( .A(n1), .Y(n4) );
  DLY1X1M U29 ( .A(n7), .Y(n30) );
  DLY1X1M U30 ( .A(n8), .Y(n31) );
  DLY1X1M U31 ( .A(n9), .Y(n32) );
  SDFFRQX1M P_DATA_reg_3_ ( .D(n17), .SI(n32), .SE(test_se), .CK(CLK), .RN(RST), .Q(n28) );
  SDFFRHQX2M P_DATA_reg_2_ ( .D(n15), .SI(n26), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(P_DATA[2]) );
  SDFFRHQX2M P_DATA_reg_6_ ( .D(n23), .SI(n30), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(P_DATA[6]) );
  SDFFRHQX2M P_DATA_reg_5_ ( .D(n21), .SI(n31), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(P_DATA[5]) );
  SDFFRHQX2M P_DATA_reg_4_ ( .D(n19), .SI(n3), .SE(test_se), .CK(CLK), .RN(RST), .Q(P_DATA[4]) );
  SDFFRHQX2M P_DATA_reg_1_ ( .D(n13), .SI(P_DATA[0]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(P_DATA[1]) );
  SDFFRHQX2M P_DATA_reg_7_ ( .D(n25), .SI(n6), .SE(test_se), .CK(CLK), .RN(RST), .Q(P_DATA[7]) );
  SDFFRHQX2M P_DATA_reg_0_ ( .D(n11), .SI(sampled_bit), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(P_DATA[0]) );
  OAI2BB2X8M U7 ( .B0(n27), .B1(test_so), .A0N(sampled_bit), .A1N(n27), .Y(n25) );
  OAI22X8M U12 ( .A0(n27), .A1(n6), .B0(n4), .B1(test_so), .Y(n23) );
  NAND4X2M U19 ( .A(edge_count[2]), .B(edge_count[1]), .C(edge_count[0]), .D(
        Enable), .Y(n1) );
endmodule


module strt_chk_test_1 ( CLK, RST, sampled_bit, Enable, strt_glitch, test_si, 
        test_se );
  input CLK, RST, sampled_bit, Enable, test_si, test_se;
  output strt_glitch;
  wire   n6, n2, n5;

  AO2B2XLM U2 ( .B0(sampled_bit), .B1(Enable), .A0(n5), .A1N(Enable), .Y(n2)
         );
  DLY1X1M U4 ( .A(n6), .Y(strt_glitch) );
  DLY1X1M U5 ( .A(n6), .Y(n5) );
  SDFFRQX1M strt_glitch_reg ( .D(n2), .SI(test_si), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(n6) );
endmodule


module par_chk_test_1 ( CLK, RST, parity_type, sampled_bit, Enable, P_DATA, 
        par_err, test_si, test_se );
  input [7:0] P_DATA;
  input CLK, RST, parity_type, sampled_bit, Enable, test_si, test_se;
  output par_err;
  wire   n1, n3, n4, n5, n9, n2, n6, n7;

  XOR3XLM U2 ( .A(n3), .B(n4), .C(n5), .Y(n1) );
  CLKXOR2X2M U3 ( .A(P_DATA[3]), .B(P_DATA[2]), .Y(n2) );
  XNOR3X1M U4 ( .A(P_DATA[1]), .B(P_DATA[0]), .C(n2), .Y(n3) );
  XNOR3XLM U5 ( .A(P_DATA[5]), .B(P_DATA[4]), .C(n6), .Y(n4) );
  CLKXOR2X2M U6 ( .A(P_DATA[7]), .B(P_DATA[6]), .Y(n6) );
  OAI2BB2X1M U7 ( .B0(n1), .B1(n7), .A0N(par_err), .A1N(n7), .Y(n9) );
  INVX2M U8 ( .A(Enable), .Y(n7) );
  XNOR2X2M U9 ( .A(sampled_bit), .B(parity_type), .Y(n5) );
  SDFFRHQX2M par_err_reg ( .D(n9), .SI(test_si), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(par_err) );
endmodule


module stp_chk_test_1 ( CLK, RST, sampled_bit, Enable, stp_err, test_si, 
        test_se );
  input CLK, RST, sampled_bit, Enable, test_si, test_se;
  output stp_err;
  wire   n3, n4;

  OAI2BB2X1M U3 ( .B0(sampled_bit), .B1(n4), .A0N(stp_err), .A1N(n4), .Y(n3)
         );
  INVX2M U5 ( .A(Enable), .Y(n4) );
  SDFFRHQX2M stp_err_reg ( .D(n3), .SI(test_si), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(stp_err) );
endmodule


module UART_RX_test_1 ( CLK, RST, RX_IN, Prescale, parity_enable, parity_type, 
        P_DATA, data_valid, test_si, test_so, test_se );
  input [4:0] Prescale;
  output [7:0] P_DATA;
  input CLK, RST, RX_IN, parity_enable, parity_type, test_si, test_se;
  output data_valid, test_so;
  wire   n25, n26, n27, n28, n29, n30, n31, n32, strt_glitch, par_err, stp_err,
         strt_chk_en, edge_bit_en, deser_en, par_chk_en, stp_chk_en,
         dat_samp_en, sampled_bit, n2, n3, n4, n5, n7, n8, n10, n11, n13, n14,
         n16, n17, n19, n20, n22, n23, n34;
  wire   [3:0] bit_count;
  wire   [2:0] edge_count;

  BUFX2M U4 ( .A(n29), .Y(n2) );
  CLKINVX1M U9 ( .A(n29), .Y(n3) );
  CLKINVX40M U10 ( .A(n3), .Y(P_DATA[3]) );
  uart_rx_fsm_test_1 U0_uart_fsm ( .CLK(CLK), .RST(RST), .S_DATA(RX_IN), 
        .parity_enable(parity_enable), .bit_count(bit_count), .edge_count(
        edge_count), .par_err(par_err), .stp_err(stp_err), .strt_glitch(
        strt_glitch), .strt_chk_en(strt_chk_en), .edge_bit_en(edge_bit_en), 
        .deser_en(deser_en), .par_chk_en(par_chk_en), .stp_chk_en(stp_chk_en), 
        .dat_samp_en(dat_samp_en), .data_valid(data_valid), .test_so(test_so), 
        .test_se(test_se) );
  edge_bit_counter_test_1 U0_edge_bit_counter ( .CLK(CLK), .RST(RST), .Enable(
        edge_bit_en), .bit_count(bit_count), .edge_count(edge_count), 
        .test_si(n34), .test_se(test_se) );
  data_sampling_test_1 U0_data_sampling ( .CLK(CLK), .RST(RST), .S_DATA(RX_IN), 
        .Prescale(Prescale), .edge_count(edge_count), .Enable(dat_samp_en), 
        .sampled_bit(sampled_bit), .test_si(test_si), .test_se(test_se) );
  deserializer_test_1 U0_deserializer ( .CLK(CLK), .RST(RST), .sampled_bit(
        sampled_bit), .Enable(deser_en), .edge_count(edge_count), .P_DATA({n25, 
        n26, n27, n28, n29, n30, n31, n32}), .test_so(n34), .test_se(test_se)
         );
  strt_chk_test_1 U0_strt_chk ( .CLK(CLK), .RST(RST), .sampled_bit(sampled_bit), .Enable(strt_chk_en), .strt_glitch(strt_glitch), .test_si(stp_err), 
        .test_se(test_se) );
  par_chk_test_1 U0_par_chk ( .CLK(CLK), .RST(RST), .parity_type(parity_type), 
        .sampled_bit(sampled_bit), .Enable(par_chk_en), .P_DATA({n20, n8, n11, 
        n14, n2, n5, n17, n23}), .par_err(par_err), .test_si(edge_count[2]), 
        .test_se(test_se) );
  stp_chk_test_1 U0_stp_chk ( .CLK(CLK), .RST(RST), .sampled_bit(sampled_bit), 
        .Enable(stp_chk_en), .stp_err(stp_err), .test_si(par_err), .test_se(
        test_se) );
  CLKINVX40M U1 ( .A(n34), .Y(P_DATA[7]) );
  CLKINVX40M U2 ( .A(n22), .Y(P_DATA[0]) );
  CLKINVX2M U3 ( .A(n32), .Y(n22) );
  CLKINVX2M U5 ( .A(n25), .Y(n19) );
  CLKINVX40M U6 ( .A(n16), .Y(P_DATA[1]) );
  CLKINVX2M U7 ( .A(n31), .Y(n16) );
  CLKINVX40M U8 ( .A(n13), .Y(P_DATA[4]) );
  CLKINVX2M U11 ( .A(n28), .Y(n13) );
  CLKINVX40M U12 ( .A(n10), .Y(P_DATA[5]) );
  CLKINVX2M U13 ( .A(n27), .Y(n10) );
  CLKINVX40M U14 ( .A(n7), .Y(P_DATA[6]) );
  CLKINVX2M U15 ( .A(n26), .Y(n7) );
  CLKINVX40M U16 ( .A(n4), .Y(P_DATA[2]) );
  CLKINVX2M U17 ( .A(n30), .Y(n4) );
  INVX32M U18 ( .A(n22), .Y(n23) );
  INVX32M U19 ( .A(n19), .Y(n20) );
  INVX32M U20 ( .A(n16), .Y(n17) );
  INVX32M U21 ( .A(n13), .Y(n14) );
  INVX32M U22 ( .A(n10), .Y(n11) );
  INVX32M U23 ( .A(n7), .Y(n8) );
  INVX32M U24 ( .A(n4), .Y(n5) );
endmodule


module UART ( si, se, so, test_mode, scan_clk, scan_rst, RST, TX_CLK, RX_CLK, 
        RX_IN_S, RX_OUT_P, RX_OUT_V, TX_IN_P, TX_IN_V, TX_OUT_S, TX_OUT_V, 
        Prescale, parity_enable, parity_type );
  output [7:0] RX_OUT_P;
  input [7:0] TX_IN_P;
  input [4:0] Prescale;
  input si, se, test_mode, scan_clk, scan_rst, RST, TX_CLK, RX_CLK, RX_IN_S,
         TX_IN_V, parity_enable, parity_type;
  output so, RX_OUT_V, TX_OUT_S, TX_OUT_V;
  wire   n12, clk_tx, clk_rx, rst, n1, n2, n3, n4, n5, n8, n10;

  BUFX2M U1 ( .A(RX_IN_S), .Y(n5) );
  BUFX4M U2 ( .A(Prescale[1]), .Y(n2) );
  BUFX2M U3 ( .A(Prescale[2]), .Y(n3) );
  BUFX2M U4 ( .A(parity_enable), .Y(n1) );
  BUFX2M U5 ( .A(TX_IN_V), .Y(n4) );
  mux2x1_2 mux1 ( .in1(scan_clk), .in2(TX_CLK), .sel(test_mode), .out(clk_tx)
         );
  mux2x1_1 mux2 ( .in1(scan_clk), .in2(RX_CLK), .sel(test_mode), .out(clk_rx)
         );
  mux2x1_0 mux3 ( .in1(scan_rst), .in2(RST), .sel(test_mode), .out(rst) );
  UART_TX_test_1 U0_UART_TX ( .CLK(clk_tx), .RST(rst), .P_DATA(TX_IN_P), 
        .Data_Valid(n4), .parity_enable(n1), .parity_type(parity_type), 
        .TX_OUT(n12), .busy(TX_OUT_V), .test_si(n8), .test_so(so), .test_se(se) );
  UART_RX_test_1 U0_UART_RX ( .CLK(clk_rx), .RST(rst), .RX_IN(n5), .Prescale({
        Prescale[4:3], n3, n2, Prescale[0]}), .parity_enable(n1), 
        .parity_type(parity_type), .P_DATA(RX_OUT_P), .data_valid(RX_OUT_V), 
        .test_si(si), .test_so(n8), .test_se(se) );
  CLKINVX1M U6 ( .A(n12), .Y(n10) );
  CLKINVX40M U7 ( .A(n10), .Y(TX_OUT_S) );
endmodule

