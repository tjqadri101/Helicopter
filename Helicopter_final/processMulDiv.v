module processMulDiv(rs1, rs2, RDIn, RDin2, data_operandA, data_operandB, ctrl_MULT, ctrl_DIV, clock, data_result, data_exception, stall,
		data_resultRDY);
input [4:0] RDIn, RDin2, rs1, rs2;
input[31:0] data_operandA, data_operandB;
input ctrl_MULT, ctrl_DIV, clock;
output [31:0]  data_result; 
output data_exception, stall, data_resultRDY;
wire data_inputRDY, stall_1, stall_2, stall_3;
wire ctrl_MULT1 , ctrl_MULT2 , ctrl_MULT3 , ctrl_MULT4 , ctrl_MULT5 , ctrl_MULT6 , ctrl_MULT7 , ctrl_MULT8 , ctrl_MULT9 , ctrl_MULT10 , 
         ctrl_MULT11 , ctrl_MULT12 , ctrl_MULT13 , ctrl_MULT14 , ctrl_MULT15 , ctrl_MULT16 , ctrl_MULT17 , ctrl_MULT18 , 
         ctrl_MULT19 , ctrl_MULT20 , ctrl_MULT21 , ctrl_MULT22 , ctrl_MULT23 , ctrl_MULT24 , ctrl_MULT25 , ctrl_MULT26 , ctrl_MULT27 , 
         ctrl_MULT28 , ctrl_MULT29 , ctrl_MULT30 , ctrl_MULT31 , ctrl_MULT32 ,  ctrl_DIV1 , ctrl_DIV2 , ctrl_DIV3 , ctrl_DIV4 , ctrl_DIV5 , ctrl_DIV6 , 
         ctrl_DIV7 , ctrl_DIV8 , ctrl_DIV9 , ctrl_DIV10 , ctrl_DIV11 , ctrl_DIV12 , ctrl_DIV13 , ctrl_DIV14 , ctrl_DIV15 , ctrl_DIV16 , 
         ctrl_DIV17 , ctrl_DIV18 , ctrl_DIV19 , ctrl_DIV20 , ctrl_DIV21 , ctrl_DIV22 , ctrl_DIV23 , ctrl_DIV24 , ctrl_DIV25 , ctrl_DIV26 ,
          ctrl_DIV27 , ctrl_DIV28 , ctrl_DIV29 , ctrl_DIV30 , ctrl_DIV31 , ctrl_DIV32;
wire [31:0] RS1, RS2,RDin, RDIn2, RDIn3, RDIn4, RDIn5, RDIn6, RDIn7, RDIn8, RDIn9, RDIn10, RDIn11, RDIn12, RDIn13, RDIn14, RDIn15, 
			RDIn16, RDIn17, RDIn18, RDIn19, RDIn20, RDIn21, RDIn22, RDIn23, RDIn24, RDIn25, RDIn26, RDIn27, RDIn28, RDIn29, 
			RDIn30, RDIn31, RDIn32, RDIn33;
wire equals2, equals3, equals4, equals5, equals6, equals7, equals8, equals9, equals10, equals11, equals12, equals13, equals14, equals15, equals16, equals17, equals18, 
		equals19, equals20, equals21, equals22, equals23, equals24, equals25, equals26, equals27, equals28, equals29, equals30, equals31, equals1, equals0;
wire  equalsRS20, equalsRS21, equalsRS22, equalsRS23, equalsRS24, equalsRS25, equalsRS26, equalsRS27, equalsRS28, equalsRS29, equalsRS210, equalsRS211, equalsRS212, 
		equalsRS213, equalsRS214, equalsRS215, equalsRS216, equalsRS217, equalsRS218, equalsRS219, equalsRS220, equalsRS221, equalsRS222, equalsRS223, equalsRS224,
		 equalsRS225, equalsRS226, equalsRS227, equalsRS228, equalsRS229, equalsRS230, equalsRS231;
wire 	equalsRS10, equalsRS11, equalsRS12, equalsRS13, equalsRS14, equalsRS15, equalsRS16, equalsRS17, equalsRS18, equalsRS19, equalsRS110, equalsRS111, equalsRS112, 
        equalsRS113, equalsRS114, equalsRS115, equalsRS116, equalsRS117, equalsRS118, equalsRS119, equalsRS120, equalsRS121, equalsRS122, equalsRS123, equalsRS124, equalsRS125, 
        equalsRS126, equalsRS127, equalsRS128, equalsRS129, equalsRS130, equalsRS131;	 


	assign RDin[31:5] = {27{1'b0}};
	assign RS1[31:5] = {27{1'b0}};
	assign RS2[31:5] = {27{1'b0}};
	assign RDin[4:0] = RDIn; 
	assign RS1[4:0] = rs1; 
	assign RS2[4:0] = rs2; 
	assign RDIn2[31:5] = {27{1'b0}};
	assign RDIn2[4:0] = RDin2;
	 
	multDiv processorMula(data_operandA, data_operandB, ctrl_MULT, ctrl_DIV, clock, data_result, data_exception, 
							data_inputRDY, data_resultRDY);
	

	equals equalsA1(RDin, RDIn2, equals0);
	register delayRD0(RDIn2, 1'b0, clock, 1'b1, RDIn3);
	equals Equals1(RDin, RDIn3, equals1);
	register delayRD1(RDIn3, 1'b0, clock, 1'b1, RDIn4);
	equals Equals2(RDin, RDIn4, equals2);
	register delayRD2(RDIn4, 1'b0, clock, 1'b1, RDIn5);
	equals Equals3(RDin, RDIn5, equals3);
	register delayRD3(RDIn5, 1'b0, clock, 1'b1, RDIn6);
	equals Equals4(RDin, RDIn6, equals4);
	register delayRD4(RDIn6, 1'b0, clock, 1'b1, RDIn7);
	equals Equals5(RDin, RDIn7, equals5);
	register delayRD5(RDIn7, 1'b0, clock, 1'b1, RDIn8);
	equals Equals6(RDin, RDIn8, equals6);
	register delayRD6(RDIn8, 1'b0, clock, 1'b1, RDIn9);
	equals Equals7(RDin, RDIn9, equals7);
	register delayRD7(RDIn9, 1'b0, clock, 1'b1, RDIn10);
	equals Equals8(RDin, RDIn10, equals8);
	register delayRD8(RDIn10, 1'b0, clock, 1'b1, RDIn11);
	equals Equals9(RDin, RDIn11, equals9);
	register delayRD9(RDIn11, 1'b0, clock, 1'b1, RDIn12);
	equals Equals10(RDin, RDIn12, equals10);
	register delayRD10(RDIn12, 1'b0, clock, 1'b1, RDIn13);
	equals Equals11(RDin, RDIn13, equals11);
	register delayRD11(RDIn13, 1'b0, clock, 1'b1, RDIn14);
	equals Equals12(RDin, RDIn14, equals12);
	register delayRD12(RDIn14, 1'b0, clock, 1'b1, RDIn15);
	equals Equals13(RDin, RDIn15, equals13);
	register delayRD13(RDIn15, 1'b0, clock, 1'b1, RDIn16);
	equals Equals14(RDin, RDIn16, equals14);
	register delayRD14(RDIn16, 1'b0, clock, 1'b1, RDIn17);
	equals Equals15(RDin, RDIn17, equals15);
	register delayRD15(RDIn17, 1'b0, clock, 1'b1, RDIn18);
	equals Equals16(RDin, RDIn18, equals16);
	register delayRD16(RDIn18, 1'b0, clock, 1'b1, RDIn19);
	equals Equals17(RDin, RDIn19, equals17);
	register delayRD17(RDIn19, 1'b0, clock, 1'b1, RDIn20);
	equals Equals18(RDin, RDIn20, equals18);
	register delayRD18(RDIn20, 1'b0, clock, 1'b1, RDIn21);
	equals Equals19(RDin, RDIn21, equals19);
	register delayRD19(RDIn21, 1'b0, clock, 1'b1, RDIn22);
	equals Equals20(RDin, RDIn22, equals20);
	register delayRD20(RDIn22, 1'b0, clock, 1'b1, RDIn23);
	equals Equals21(RDin, RDIn23, equals21);
	register delayRD21(RDIn23, 1'b0, clock, 1'b1, RDIn24);
	equals Equals22(RDin, RDIn24, equals22);
	register delayRD22(RDIn24, 1'b0, clock, 1'b1, RDIn25);
	equals Equals23(RDin, RDIn25, equals23);
	register delayRD23(RDIn25, 1'b0, clock, 1'b1, RDIn26);
	equals Equals24(RDin, RDIn26, equals24);
	register delayRD24(RDIn26, 1'b0, clock, 1'b1, RDIn27);
	equals Equals25(RDin, RDIn27, equals25);
	register delayRD25(RDIn27, 1'b0, clock, 1'b1, RDIn28);
	equals Equals26(RDin, RDIn28, equals26);
	register delayRD26(RDIn28, 1'b0, clock, 1'b1, RDIn29);
	equals Equals27(RDin, RDIn29, equals27);
	register delayRD27(RDIn29, 1'b0, clock, 1'b1, RDIn30);
	equals Equals28(RDin, RDIn30, equals28);
	register delayRD28(RDIn30, 1'b0, clock, 1'b1, RDIn31);
	equals Equals29(RDin, RDIn31, equals29);
	register delayRD29(RDIn31, 1'b0, clock, 1'b1, RDIn32);
	equals Equals30(RDin, RDIn32, equals30);
	register delayRD30(RDIn32, 1'b0, clock, 1'b1, RDIn33);
	equals Equals31(RDin, RDIn33, equals31);
	
	my_dff ctMulCh(ctrl_MULT, 1'b0, clock, 1'b0, ctrl_MULT1);
	my_dff ctdivCh(ctrl_DIV, 1'b0, clock, 1'b0, ctrl_DIV1);
   my_dff ctMulCh1(ctrl_MULT1, 1'b0, clock, 1'b0, ctrl_MULT2);
	my_dff ctdivCh1(ctrl_DIV1, 1'b0, clock, 1'b0, ctrl_DIV2);
	my_dff ctMulCh2(ctrl_MULT2, 1'b0, clock, 1'b0, ctrl_MULT3);
	my_dff ctdivCh2(ctrl_DIV2, 1'b0, clock, 1'b0, ctrl_DIV3);
	my_dff ctMulCh3(ctrl_MULT3, 1'b0, clock, 1'b0, ctrl_MULT4);
	my_dff ctdivCh3(ctrl_DIV3, 1'b0, clock, 1'b0, ctrl_DIV4);
	my_dff ctMulCh4(ctrl_MULT4, 1'b0, clock, 1'b0, ctrl_MULT5);
	my_dff ctdivCh4(ctrl_DIV4, 1'b0, clock, 1'b0, ctrl_DIV5);
	my_dff ctMulCh5(ctrl_MULT5, 1'b0, clock, 1'b0, ctrl_MULT6);
	my_dff ctdivCh5(ctrl_DIV5, 1'b0, clock, 1'b0, ctrl_DIV6);
	my_dff ctMulCh6(ctrl_MULT6, 1'b0, clock, 1'b0, ctrl_MULT7);
	my_dff ctdivCh6(ctrl_DIV6, 1'b0, clock, 1'b0, ctrl_DIV7);
	my_dff ctMulCh7(ctrl_MULT7, 1'b0, clock, 1'b0, ctrl_MULT8);
	my_dff ctdivCh7(ctrl_DIV7, 1'b0, clock, 1'b0, ctrl_DIV8);
	my_dff ctMulCh8(ctrl_MULT8, 1'b0, clock, 1'b0, ctrl_MULT9);
	my_dff ctdivCh8(ctrl_DIV8, 1'b0, clock, 1'b0, ctrl_DIV9);
	my_dff ctMulCh9(ctrl_MULT9, 1'b0, clock, 1'b0, ctrl_MULT10);
	my_dff ctdivCh9(ctrl_DIV9, 1'b0, clock, 1'b0, ctrl_DIV10);
	my_dff ctMulCh10(ctrl_MULT10, 1'b0, clock, 1'b0, ctrl_MULT11);
	my_dff ctdivCh10(ctrl_DIV10, 1'b0, clock, 1'b0, ctrl_DIV11);
	my_dff ctMulCh11(ctrl_MULT11, 1'b0, clock, 1'b0, ctrl_MULT12);
	my_dff ctdivCh11(ctrl_DIV11, 1'b0, clock, 1'b0, ctrl_DIV12);
	my_dff ctMulCh12(ctrl_MULT12, 1'b0, clock, 1'b0, ctrl_MULT13);
	my_dff ctdivCh12(ctrl_DIV12, 1'b0, clock, 1'b0, ctrl_DIV13);
	my_dff ctMulCh13(ctrl_MULT13, 1'b0, clock, 1'b0, ctrl_MULT14);
	my_dff ctdivCh13(ctrl_DIV13, 1'b0, clock, 1'b0, ctrl_DIV14);
	my_dff ctMulCh14(ctrl_MULT14, 1'b0, clock, 1'b0, ctrl_MULT15);
	my_dff ctdivCh14(ctrl_DIV14, 1'b0, clock, 1'b0, ctrl_DIV15);
	my_dff ctMulCh15(ctrl_MULT15, 1'b0, clock, 1'b0, ctrl_MULT16);
	my_dff ctdivCh15(ctrl_DIV15, 1'b0, clock, 1'b0, ctrl_DIV16);
	my_dff ctMulCh16(ctrl_MULT16, 1'b0, clock, 1'b0, ctrl_MULT17);
	my_dff ctdivCh16(ctrl_DIV16, 1'b0, clock, 1'b0, ctrl_DIV17);
	my_dff ctMulCh17(ctrl_MULT17, 1'b0, clock, 1'b0, ctrl_MULT18);
	my_dff ctdivCh17(ctrl_DIV17, 1'b0, clock, 1'b0, ctrl_DIV18);
	my_dff ctMulCh18(ctrl_MULT18, 1'b0, clock, 1'b0, ctrl_MULT19);
	my_dff ctdivCh18(ctrl_DIV18, 1'b0, clock, 1'b0, ctrl_DIV19);
	my_dff ctMulCh19(ctrl_MULT19, 1'b0, clock, 1'b0, ctrl_MULT20);
	my_dff ctdivCh19(ctrl_DIV19, 1'b0, clock, 1'b0, ctrl_DIV20);
	my_dff ctMulCh20(ctrl_MULT20, 1'b0, clock, 1'b0, ctrl_MULT21);
	my_dff ctdivCh20(ctrl_DIV20, 1'b0, clock, 1'b0, ctrl_DIV21);
	my_dff ctMulCh21(ctrl_MULT21, 1'b0, clock, 1'b0, ctrl_MULT22);
	my_dff ctdivCh21(ctrl_DIV21, 1'b0, clock, 1'b0, ctrl_DIV22);
	my_dff ctMulCh22(ctrl_MULT22, 1'b0, clock, 1'b0, ctrl_MULT23);
	my_dff ctdivCh22(ctrl_DIV22, 1'b0, clock, 1'b0, ctrl_DIV23);
	my_dff ctMulCh23(ctrl_MULT23, 1'b0, clock, 1'b0, ctrl_MULT24);
	my_dff ctdivCh23(ctrl_DIV23, 1'b0, clock, 1'b0, ctrl_DIV24);
	my_dff ctMulCh24(ctrl_MULT24, 1'b0, clock, 1'b0, ctrl_MULT25);
	my_dff ctdivCh24(ctrl_DIV24, 1'b0, clock, 1'b0, ctrl_DIV25);
	my_dff ctMulCh25(ctrl_MULT25, 1'b0, clock, 1'b0, ctrl_MULT26);
	my_dff ctdivCh25(ctrl_DIV25, 1'b0, clock, 1'b0, ctrl_DIV26);
	my_dff ctMulCh26(ctrl_MULT26, 1'b0, clock, 1'b0, ctrl_MULT27);
	my_dff ctdivCh26(ctrl_DIV26, 1'b0, clock, 1'b0, ctrl_DIV27);
	my_dff ctMulCh27(ctrl_MULT27, 1'b0, clock, 1'b0, ctrl_MULT28);
	my_dff ctdivCh27(ctrl_DIV27, 1'b0, clock, 1'b0, ctrl_DIV28);
	my_dff ctMulCh28(ctrl_MULT28, 1'b0, clock, 1'b0, ctrl_MULT29);
	my_dff ctdivCh28(ctrl_DIV28, 1'b0, clock, 1'b0, ctrl_DIV29);
	my_dff ctMulCh29(ctrl_MULT29, 1'b0, clock, 1'b0, ctrl_MULT30);
	my_dff ctdivCh29(ctrl_DIV29, 1'b0, clock, 1'b0, ctrl_DIV30);
	my_dff ctMulCh30(ctrl_MULT30, 1'b0, clock, 1'b0, ctrl_MULT31);
	my_dff ctdivCh30(ctrl_DIV30, 1'b0, clock, 1'b0, ctrl_DIV31);
	my_dff ctMulCh31(ctrl_MULT31, 1'b0, clock, 1'b0, ctrl_MULT32);
	my_dff ctdivCh31(ctrl_DIV31, 1'b0, clock, 1'b0, ctrl_DIV32);
	
	
	equals EqualsRS11(RS1, RDIn2, equalsRS10);
	equals EqualsRS12(RS1, RDIn3, equalsRS11);
	equals EqualsRS13(RS1, RDIn4, equalsRS12);
	equals EqualsRS14(RS1, RDIn5, equalsRS13);
	equals EqualsRS15(RS1, RDIn6, equalsRS14);
	equals EqualsRS16(RS1, RDIn7, equalsRS15);
	equals EqualsRS17(RS1, RDIn8, equalsRS16);
	equals EqualsRS18(RS1, RDIn9, equalsRS17);
	equals EqualsRS19(RS1, RDIn10, equalsRS18);
	equals EqualsRS110(RS1, RDIn11, equalsRS19);
	equals EqualsRS111(RS1, RDIn12, equalsRS110);
	equals EqualsRS112(RS1, RDIn13, equalsRS111);
	equals EqualsRS113(RS1, RDIn14, equalsRS112);
	equals EqualsRS114(RS1, RDIn15, equalsRS113);
	equals EqualsRS115(RS1, RDIn16, equalsRS114);
	equals EqualsRS116(RS1, RDIn17, equalsRS115);
	equals EqualsRS117(RS1, RDIn18, equalsRS116);
	equals EqualsRS118(RS1, RDIn19, equalsRS117);
	equals EqualsRS119(RS1, RDIn20, equalsRS118);
	equals EqualsRS120(RS1, RDIn21, equalsRS119);
	equals EqualsRS121(RS1, RDIn22, equalsRS120);
	equals EqualsRS122(RS1, RDIn23, equalsRS121);
	equals EqualsRS123(RS1, RDIn24, equalsRS122);
	equals EqualsRS124(RS1, RDIn25, equalsRS123);
	equals EqualsRS125(RS1, RDIn26, equalsRS124);
	equals EqualsRS126(RS1, RDIn27, equalsRS125);
	equals EqualsRS127(RS1, RDIn28, equalsRS126);
	equals EqualsRS128(RS1, RDIn29, equalsRS127);
	equals EqualsRS129(RS1, RDIn30, equalsRS128);
	equals EqualsRS130(RS1, RDIn31, equalsRS129);
	equals EqualsRS131(RS1, RDIn32, equalsRS130);
	equals EqualsRS132(RS1, RDIn33, equalsRS131);
	
	equals EqualsRS21(RS2, RDIn2, equalsRS20);
	equals EqualsRS22(RS2, RDIn3, equalsRS21);
	equals EqualsRS23(RS2, RDIn4, equalsRS22);
	equals EqualsRS24(RS2, RDIn5, equalsRS23);
	equals EqualsRS25(RS2, RDIn6, equalsRS24);
	equals EqualsRS26(RS2, RDIn7, equalsRS25);
	equals EqualsRS27(RS2, RDIn8, equalsRS26);
	equals EqualsRS28(RS2, RDIn9, equalsRS27);
	equals EqualsRS29(RS2, RDIn10, equalsRS28);
	equals EqualsRS210(RS2, RDIn11, equalsRS29);
	equals EqualsRS211(RS2, RDIn12, equalsRS210);
	equals EqualsRS212(RS2, RDIn13, equalsRS211);
	equals EqualsRS213(RS2, RDIn14, equalsRS212);
	equals EqualsRS214(RS2, RDIn15, equalsRS213);
	equals EqualsRS215(RS2, RDIn16, equalsRS214);
	equals EqualsRS216(RS2, RDIn17, equalsRS215);
	equals EqualsRS217(RS2, RDIn18, equalsRS216);
	equals EqualsRS218(RS2, RDIn19, equalsRS217);
	equals EqualsRS219(RS2, RDIn20, equalsRS218);
	equals EqualsRS220(RS2, RDIn21, equalsRS219);
	equals EqualsRS221(RS2, RDIn22, equalsRS220);
	equals EqualsRS222(RS2, RDIn23, equalsRS221);
	equals EqualsRS223(RS2, RDIn24, equalsRS222);
	equals EqualsRS224(RS2, RDIn25, equalsRS223);
	equals EqualsRS225(RS2, RDIn26, equalsRS224);
	equals EqualsRS226(RS2, RDIn27, equalsRS225);
	equals EqualsRS227(RS2, RDIn28, equalsRS226);
	equals EqualsRS228(RS2, RDIn29, equalsRS227);
	equals EqualsRS229(RS2, RDIn30, equalsRS228);
	equals EqualsRS230(RS2, RDIn31, equalsRS229);
	equals EqualsRS231(RS2, RDIn32, equalsRS230);
	equals EqualsRS232(RS2, RDIn33, equalsRS231);
	
	assign stall_1 = ((ctrl_DIV1 | ctrl_MULT1) & equals0) | ((ctrl_DIV2 | ctrl_MULT2) & equals1) | ((ctrl_DIV3 | ctrl_MULT3) & equals2) | 
	                ((ctrl_DIV4 | ctrl_MULT4) & equals3) | ((ctrl_DIV5 | ctrl_MULT5) & equals4) | ((ctrl_DIV6 | ctrl_MULT6) & equals5) | 
	                ((ctrl_DIV7 | ctrl_MULT7) & equals6) | ((ctrl_DIV8 | ctrl_MULT8) & equals7) | ((ctrl_DIV9 | ctrl_MULT9) & equals8) | 
	                ((ctrl_DIV10 | ctrl_MULT10) & equals9) | ((ctrl_DIV11 | ctrl_MULT11) & equals10) | ((ctrl_DIV12 | ctrl_MULT12) & equals11) | 
	                ((ctrl_DIV13 | ctrl_MULT13) & equals12) | ((ctrl_DIV14 | ctrl_MULT14) & equals13) | 
	                ((ctrl_DIV15 | ctrl_MULT15) & equals14) | ((ctrl_DIV16 | ctrl_MULT16) & equals15) | 
	                ((ctrl_DIV17 | ctrl_MULT17) & equals16) | ((ctrl_DIV18 | ctrl_MULT18) & equals17) | ((ctrl_DIV19 | ctrl_MULT19) & equals18) | 
	                ((ctrl_DIV20 | ctrl_MULT20) & equals19) | ((ctrl_DIV21 | ctrl_MULT21) & equals20) | ((ctrl_DIV22 | ctrl_MULT22) & equals21) | 
	                ((ctrl_DIV23 | ctrl_MULT23) & equals22) | ((ctrl_DIV24 | ctrl_MULT24) & equals23) | ((ctrl_DIV25 | ctrl_MULT25) & equals24) | 
	                ((ctrl_DIV26 | ctrl_MULT26) & equals25) | ((ctrl_DIV27 | ctrl_MULT27) & equals26) | ((ctrl_DIV28 | ctrl_MULT28) & equals27) | 
	                ((ctrl_DIV29 | ctrl_MULT29) & equals28) | ((ctrl_DIV30 | ctrl_MULT30) & equals29) | ((ctrl_DIV31 | ctrl_MULT31) & equals30) | 
	                ((ctrl_DIV32 | ctrl_MULT32) & equals31);
	
	assign stall_2 =  ((ctrl_DIV1 | ctrl_MULT1) & equalsRS10) | ((ctrl_DIV2 | ctrl_MULT2) & equalsRS11) | 
	                  ((ctrl_DIV3 | ctrl_MULT3) & equalsRS12) | ((ctrl_DIV4 | ctrl_MULT4) & equalsRS13) | 
	                  ((ctrl_DIV5 | ctrl_MULT5) & equalsRS14) | ((ctrl_DIV6 | ctrl_MULT6) & equalsRS15) |
	                  ((ctrl_DIV7 | ctrl_MULT7) & equalsRS16) | ((ctrl_DIV8 | ctrl_MULT8) & equalsRS17) | 
	                  ((ctrl_DIV9 | ctrl_MULT9) & equalsRS18) | ((ctrl_DIV10 | ctrl_MULT10) & equalsRS19) | 
	                  ((ctrl_DIV11 | ctrl_MULT11) & equalsRS110) | ((ctrl_DIV12 | ctrl_MULT12) & equalsRS111) | 
	                  ((ctrl_DIV13 | ctrl_MULT13) & equalsRS112) | ((ctrl_DIV14 | ctrl_MULT14) & equalsRS113) | 
	                  ((ctrl_DIV15 | ctrl_MULT15) & equalsRS114) | ((ctrl_DIV16 | ctrl_MULT16) & equalsRS115) | 
	                  ((ctrl_DIV17 | ctrl_MULT17) & equalsRS116) | ((ctrl_DIV18 | ctrl_MULT18) & equalsRS117) | 
	                  ((ctrl_DIV19 | ctrl_MULT19) & equalsRS118) | ((ctrl_DIV20 | ctrl_MULT20) & equalsRS119) | 
	                  ((ctrl_DIV21 | ctrl_MULT21) & equalsRS120) | ((ctrl_DIV22 | ctrl_MULT22) & equalsRS121) | 
	                  ((ctrl_DIV23 | ctrl_MULT23) & equalsRS122) | ((ctrl_DIV24 | ctrl_MULT24) & equalsRS123) | 
	                  ((ctrl_DIV25 | ctrl_MULT25) & equalsRS124) | ((ctrl_DIV26 | ctrl_MULT26) & equalsRS125) | 
	                  ((ctrl_DIV27 | ctrl_MULT27) & equalsRS126) | ((ctrl_DIV28 | ctrl_MULT28) & equalsRS127) | 
	                  ((ctrl_DIV29 | ctrl_MULT29) & equalsRS128) | ((ctrl_DIV30 | ctrl_MULT30) & equalsRS129) | 
	                  ((ctrl_DIV31 | ctrl_MULT31) & equalsRS130) | ((ctrl_DIV32 | ctrl_MULT32) & equalsRS131);
	
	assign stall_3 = ((ctrl_DIV1 | ctrl_MULT1) & equalsRS20) | ((ctrl_DIV2 | ctrl_MULT2) & equalsRS21) | 
					((ctrl_DIV3 | ctrl_MULT3) & equalsRS22) | ((ctrl_DIV4 | ctrl_MULT4) & equalsRS23) | 
					((ctrl_DIV5 | ctrl_MULT5) & equalsRS24) | ((ctrl_DIV6 | ctrl_MULT6) & equalsRS25) | 
					((ctrl_DIV7 | ctrl_MULT7) & equalsRS26) | ((ctrl_DIV8 | ctrl_MULT8) & equalsRS27) | 
					((ctrl_DIV9 | ctrl_MULT9) & equalsRS28) | ((ctrl_DIV10 | ctrl_MULT10) & equalsRS29) | 
					((ctrl_DIV11 | ctrl_MULT11) & equalsRS210) | ((ctrl_DIV12 | ctrl_MULT12) & equalsRS211) | 
					((ctrl_DIV13 | ctrl_MULT13) & equalsRS212) | ((ctrl_DIV14 | ctrl_MULT14) & equalsRS213) | 
					((ctrl_DIV15 | ctrl_MULT15) & equalsRS214) | ((ctrl_DIV16 | ctrl_MULT16) & equalsRS215) | 
					((ctrl_DIV17 | ctrl_MULT17) & equalsRS216) | ((ctrl_DIV18 | ctrl_MULT18) & equalsRS217) | 
					((ctrl_DIV19 | ctrl_MULT19) & equalsRS218) | ((ctrl_DIV20 | ctrl_MULT20) & equalsRS219) | 
					((ctrl_DIV21 | ctrl_MULT21) & equalsRS220) | ((ctrl_DIV22 | ctrl_MULT22) & equalsRS221) | 
					((ctrl_DIV23 | ctrl_MULT23) & equalsRS222) | ((ctrl_DIV24 | ctrl_MULT24) & equalsRS223) | 
					((ctrl_DIV25 | ctrl_MULT25) & equalsRS224) | ((ctrl_DIV26 | ctrl_MULT26) & equalsRS225) |
					 ((ctrl_DIV27 | ctrl_MULT27) & equalsRS226) | ((ctrl_DIV28 | ctrl_MULT28) & equalsRS227) | 
					 ((ctrl_DIV29 | ctrl_MULT29) & equalsRS228) | ((ctrl_DIV30 | ctrl_MULT30) & equalsRS229) |
					  ((ctrl_DIV31 | ctrl_MULT31) & equalsRS230) | ((ctrl_DIV32 | ctrl_MULT32) & equalsRS231);
	assign stall = stall_1 | stall_2 | stall_3;				  
endmodule




module equals(aIn, bIn, equals);
	input [31:0] aIn, bIn;
	output equals;
	wire cinSubmul, coutSub, rs10;
	wire [31:0] negB, subA;


	assign cinSubmul = 1'b1;

	assign negB = ~bIn;
   
   assign rs10 = aIn[4] | aIn[3] | aIn[2] | aIn[1] | aIn[0];
   
   CLA mul_subACLA(aIn, negB, cinSubmul, subA, coutSub);

	
	assign equals = rs10 & (~(subA[31] | subA[30] | subA[29] | subA[28] | subA[27] | subA[26] | subA[25] | subA[24] | subA[23] | subA[22] |
						subA[21] | subA[20] | subA[19] | subA[18] | subA[17] | subA[16] | subA[15] | subA[14] | subA[13] | subA[12] |
						subA[11] | subA[10] | subA[9] | subA[8] | subA[7] | subA[6] | subA[5] | subA[4] | subA[3] | subA[2] | subA[1] | subA[0]));



endmodule