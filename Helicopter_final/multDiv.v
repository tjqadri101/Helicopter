 module multDiv(data_operandA, data_operandB, ctrl_MULT, ctrl_DIV, clock, data_result, data_exception, data_inputRDY, data_resultRDY);
   input [31:0] data_operandA;
   input [15:0] data_operandB;
   input ctrl_MULT, ctrl_DIV, clock;      
   wire write_Enable; //always 1       
   output [31:0] data_result; 
   output data_exception, data_inputRDY, data_resultRDY;
   wire [31:0] mult_result, div_result;
   wire mult_overflow, div_exception, mul_rdy, div_rdy;
   
   assign write_Enable = 1'b1;
   assign data_inputRDY = 1'b1; //as units are pipelined, new inputs can be accepted every cycle
   
   multiplier multipler1(data_operandA[15:0], data_operandB, ctrl_MULT, clock, write_Enable, mult_result,mult_overflow, mul_rdy);
   divider divider1(data_operandA, data_operandB ,clock, ctrl_DIV, write_Enable, div_exception, div_result, div_rdy);
   
   assign  data_resultRDY = mul_rdy | div_rdy;
   assign data_exception = (mult_overflow & mul_rdy) | (div_exception & div_rdy);
   assign data_result = (mult_result&{32{mul_rdy}}) | (div_result&{32{div_rdy}});


   
   
endmodule

//32by16 divider
module divider(a, b,clk, ctrl0, write_Enable, exception, Result, rdy);
	input [31:0] a;
	input [15:0]  b;
	input write_Enable, clk, ctrl0;
	output [31:0] Result;
	output exception, rdy;
	wire ex0, ex1, ex2, ex3, ex4, ex5, ex6, ex7, ex8, ex9, ex10, ex11, ex12, ex13, ex14, ex15, ex16, ex17, ex18, ex19, ex20, ex21, ex22;
	wire ex23, ex24, ex25, ex26, ex27, ex28, ex29, ex30, ex31; 
	wire msbA0, msbA1, msbA2, msbA3, msbA4, msbA5, msbA6, msbA7, msbA8, msbA9, msbA10, msbA11, msbA12, msbA13, msbA14, msbA15, msbA16;
	wire msbA17, msbA18, msbA19, msbA20, msbA21, msbA22, msbA23, msbA24, msbA25, msbA26, msbA27, msbA28, msbA29, msbA30, msbA31, msbA32;
	wire msbB0, msbB1, msbB2, msbB3, msbB4, msbB5, msbB6, msbB7, msbB8, msbB9, msbB10, msbB11, msbB12, msbB13, msbB14, msbB15, msbB16; 
	wire msbB17, msbB18, msbB19, msbB20, msbB21, msbB22, msbB23, msbB24, msbB25, msbB26, msbB27, msbB28, msbB29, msbB30, msbB31, msbB32;
	wire [31:0] notA, compA, A, car1, result, notResult, compResult;
	wire [15:0] notB, compB, car0, B, ex;
	wire gdiv, tinit, tinit1, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15, t16, t17, t18, t19, t20, t21, t22, t23, t24, t25;
	wire  t26, t27, t28, t29, t30, t31, t32, nreq1, nreq2, nreq;
	wire[14:0] rem0, rem1, rem2, rem3, rem4, rem5, rem6, rem7, rem8, rem9, rem10, rem11, rem12, rem13, rem14, rem15;
	wire[14:0] rem16, rem17, rem18, rem19, rem20, rem21, rem31, rem22, rem23, rem24, rem25, rem26, rem27, rem28, rem29, rem30;
	wire[15:0] irem16, irem17, irem18, irem19, irem20, irem21, irem31, irem22, irem23, irem24, irem25, irem26, irem27, irem28, irem29, irem30;
	wire[15:0] irem0, irem1, irem2, irem3, irem4, irem5, irem6, irem7, irem8, irem9, irem10, irem11, irem12, irem13, irem14, irem15;
	wire[15:0] di0;
	wire[15:0] divisor, divisor0, divisor1, divisor2, divisor3, divisor4, divisor5, divisor6, divisor7, divisor8, divisor9, divisor10, divisor11, divisor12;
	wire[15:0] divisor13, divisor14, divisor15, divisor16, divisor17, divisor18, divisor19, divisor20, divisor21, divisor22, divisor23, divisor24; 
	wire[15:0] divisor25, divisor26, divisor27, divisor28, divisor29, divisor30, divisor31, divisor32; 
	wire[31:0] dividend0, dividend1, dividend2, dividend3, dividend4, dividend5, dividend6, dividend7, dividend8, dividend9, dividend10, dividend11; 
	wire[31:0] dividend12, dividend13, dividend14, dividend15, dividend16, dividend17, dividend18, dividend19, dividend20, dividend21, dividend22; 
	wire[31:0] dividend23, dividend24, dividend25, dividend26, dividend27, dividend28, dividend29, dividend30, dividend31, dividend32;
	wire st2, st3, st4, st5, st6, st7, st8, st9, st10, st11, st12, st13, st14, st15, st16, st17, st18, st19, st20, st21, st22, st23, st24, st25, st26; 
	wire st27, st28, st29, st30, st31, st1;
	wire [14:0] srem0, srem1, srem2, srem3, srem4, srem5, srem6, srem7, srem8, srem9, srem10, srem11, srem12, srem13, srem14, srem15, srem16, srem17, srem18; 
	wire [14:0] srem19, srem20, srem21, srem22, srem23, srem24, srem25, srem26, srem27, srem28, srem29, srem30; 
	wire ctrl1, ctrl2, ctrl3, ctrl4, ctrl5, ctrl6, ctrl7, ctrl8, ctrl9, ctrl10, ctrl11, ctrl12, ctrl13, ctrl14, ctrl15, ctrl16, ctrl17, ctrl18, ctrl19, ctrl20;
	wire ctrl21, ctrl22, ctrl23, ctrl24, ctrl25, ctrl26, ctrl27, ctrl28, ctrl29, ctrl30, ctrl31, ctrl32;
	wire[31:0] divreg1,divreg2, divreg3, divreg4, divreg5, divreg6, divreg7, divreg8, divreg9, divreg10, divreg11, divreg12, divreg13, divreg14; 
	wire[31:0] divreg15, divreg16, divreg17, divreg18, divreg19, divreg20, divreg21, divreg22, divreg23, divreg24, divreg25, divreg26, divreg27, divreg28, divreg29, divreg30; 
	wire[31:0] divreg31, divreg32, divreg33, divreg34, divreg35, divreg36, divreg37, divreg38, divreg39, divreg40, divreg41, divreg42, divreg43, divreg44, divreg45, divreg46; 
	wire[31:0] divreg47, divreg48, divreg49, divreg50, divreg51, divreg52, divreg53, divreg54, divreg55, divreg56, divreg57, divreg58, divreg59, divreg60, divreg61, divreg62, divreg63; 
	
	
	 
	assign notA = ~a;
	assign notB = ~b;
	
	assign car0 = {16{1'b0}};
	assign car1 = {32{1'b0}};
	
	CLA der1(notA, car1, 1'b1, compA, nreq2);
	CLA2 der2(notB, car0, 1'b1, compB, nreq1);
	
	assign A = {32{a[31]}}&compA | {32{~a[31]}}&a;
	assign B = ({16{b[15]}}&compB)|({16{~b[15]}}&b);
	assign dividend0 = A & {32{ctrl0}};
	assign divisor0 = B;
	assign divisor = B;
	assign gdiv = 0;
	assign tinit1 = 1;
	my_dff tstall(tinit1, 1'b0, clk, write_Enable, tinit);
	
	
	assign divreg1[30:0] = {31{gdiv}};
	
	assign msbA0 = a[31];
	assign msbB0 = b[15];
	
	my_dff mSBA0(msbA0, 1'b0, clk, write_Enable, msbA1);
	my_dff mSBA1(msbA1, 1'b0, clk, write_Enable, msbA2);
	my_dff mSBA2(msbA2, 1'b0, clk, write_Enable, msbA3);
	my_dff mSBA3(msbA3, 1'b0, clk, write_Enable, msbA4);
	my_dff mSBA4(msbA4, 1'b0, clk, write_Enable, msbA5);
	my_dff mSBA5(msbA5, 1'b0, clk, write_Enable, msbA6);
	my_dff mSBA6(msbA6, 1'b0, clk, write_Enable, msbA7);
	my_dff mSBA7(msbA7, 1'b0, clk, write_Enable, msbA8);
	my_dff mSBA8(msbA8, 1'b0, clk, write_Enable, msbA9);
	my_dff mSBA9(msbA9, 1'b0, clk, write_Enable, msbA10);
	my_dff mSBA10(msbA10, 1'b0, clk, write_Enable, msbA11);
	my_dff mSBA11(msbA11, 1'b0, clk, write_Enable, msbA12);
	my_dff mSBA12(msbA12, 1'b0, clk, write_Enable, msbA13);
	my_dff mSBA13(msbA13, 1'b0, clk, write_Enable, msbA14);
	my_dff mSBA14(msbA14, 1'b0, clk, write_Enable, msbA15);
	my_dff mSBA15(msbA15, 1'b0, clk, write_Enable, msbA16);
	my_dff mSBA16(msbA16, 1'b0, clk, write_Enable, msbA17);
	my_dff mSBA17(msbA17, 1'b0, clk, write_Enable, msbA18);
	my_dff mSBA18(msbA18, 1'b0, clk, write_Enable, msbA19);
	my_dff mSBA19(msbA19, 1'b0, clk, write_Enable, msbA20);
	my_dff mSBA20(msbA20, 1'b0, clk, write_Enable, msbA21);
	my_dff mSBA21(msbA21, 1'b0, clk, write_Enable, msbA22);
	my_dff mSBA22(msbA22, 1'b0, clk, write_Enable, msbA23);
	my_dff mSBA23(msbA23, 1'b0, clk, write_Enable, msbA24);
	my_dff mSBA24(msbA24, 1'b0, clk, write_Enable, msbA25);
	my_dff mSBA25(msbA25, 1'b0, clk, write_Enable, msbA26);
	my_dff mSBA26(msbA26, 1'b0, clk, write_Enable, msbA27);
	my_dff mSBA27(msbA27, 1'b0, clk, write_Enable, msbA28);
	my_dff mSBA28(msbA28, 1'b0, clk, write_Enable, msbA29);
	my_dff mSBA29(msbA29, 1'b0, clk, write_Enable, msbA30);
	my_dff mSBA30(msbA30, 1'b0, clk, write_Enable, msbA31);
	my_dff mSBA31(msbA31, 1'b0, clk, write_Enable, msbA32);

	my_dff mSBB0(msbB0, 1'b0, clk, write_Enable, msbB1);
	my_dff mSBB1(msbB1, 1'b0, clk, write_Enable, msbB2);
	my_dff mSBB2(msbB2, 1'b0, clk, write_Enable, msbB3);
	my_dff mSBB3(msbB3, 1'b0, clk, write_Enable, msbB4);
	my_dff mSBB4(msbB4, 1'b0, clk, write_Enable, msbB5);
	my_dff mSBB5(msbB5, 1'b0, clk, write_Enable, msbB6);
	my_dff mSBB6(msbB6, 1'b0, clk, write_Enable, msbB7);
	my_dff mSBB7(msbB7, 1'b0, clk, write_Enable, msbB8);
	my_dff mSBB8(msbB8, 1'b0, clk, write_Enable, msbB9);
	my_dff mSBB9(msbB9, 1'b0, clk, write_Enable, msbB10);
	my_dff mSBB10(msbB10, 1'b0, clk, write_Enable, msbB11);
	my_dff mSBB11(msbB11, 1'b0, clk, write_Enable, msbB12);
	my_dff mSBB12(msbB12, 1'b0, clk, write_Enable, msbB13);
	my_dff mSBB13(msbB13, 1'b0, clk, write_Enable, msbB14);
	my_dff mSBB14(msbB14, 1'b0, clk, write_Enable, msbB15);
	my_dff mSBB15(msbB15, 1'b0, clk, write_Enable, msbB16);
	my_dff mSBB16(msbB16, 1'b0, clk, write_Enable, msbB17);
	my_dff mSBB17(msbB17, 1'b0, clk, write_Enable, msbB18);
	my_dff mSBB18(msbB18, 1'b0, clk, write_Enable, msbB19);
	my_dff mSBB19(msbB19, 1'b0, clk, write_Enable, msbB20);
	my_dff mSBB20(msbB20, 1'b0, clk, write_Enable, msbB21);
	my_dff mSBB21(msbB21, 1'b0, clk, write_Enable, msbB22);
	my_dff mSBB22(msbB22, 1'b0, clk, write_Enable, msbB23);
	my_dff mSBB23(msbB23, 1'b0, clk, write_Enable, msbB24);
	my_dff mSBB24(msbB24, 1'b0, clk, write_Enable, msbB25);
	my_dff mSBB25(msbB25, 1'b0, clk, write_Enable, msbB26);
	my_dff mSBB26(msbB26, 1'b0, clk, write_Enable, msbB27);
	my_dff mSBB27(msbB27, 1'b0, clk, write_Enable, msbB28);
	my_dff mSBB28(msbB28, 1'b0, clk, write_Enable, msbB29);
	my_dff mSBB29(msbB29, 1'b0, clk, write_Enable, msbB30);
	my_dff mSBB30(msbB30, 1'b0, clk, write_Enable, msbB31);
	my_dff mSBB31(msbB31, 1'b0, clk, write_Enable, msbB32);
	
	my_dff ctr0(ctrl0, 1'b0, clk, write_Enable, ctrl1);
	my_dff ctr1(ctrl1, 1'b0, clk, write_Enable, ctrl2);
	my_dff ctr2(ctrl2, 1'b0, clk, write_Enable, ctrl3);
	my_dff ctr3(ctrl3, 1'b0, clk, write_Enable, ctrl4);
	my_dff ctr4(ctrl4, 1'b0, clk, write_Enable, ctrl5);
	my_dff ctr5(ctrl5, 1'b0, clk, write_Enable, ctrl6);
	my_dff ctr6(ctrl6, 1'b0, clk, write_Enable, ctrl7);
	my_dff ctr7(ctrl7, 1'b0, clk, write_Enable, ctrl8);
	my_dff ctr8(ctrl8, 1'b0, clk, write_Enable, ctrl9);
	my_dff ctr9(ctrl9, 1'b0, clk, write_Enable, ctrl10);
	my_dff ctr10(ctrl10, 1'b0, clk, write_Enable, ctrl11);
	my_dff ctr11(ctrl11, 1'b0, clk, write_Enable, ctrl12);
	my_dff ctr12(ctrl12, 1'b0, clk, write_Enable, ctrl13);
	my_dff ctr13(ctrl13, 1'b0, clk, write_Enable, ctrl14);
	my_dff ctr14(ctrl14, 1'b0, clk, write_Enable, ctrl15);
	my_dff ctr15(ctrl15, 1'b0, clk, write_Enable, ctrl16);
	my_dff ctr16(ctrl16, 1'b0, clk, write_Enable, ctrl17);
	my_dff ctr17(ctrl17, 1'b0, clk, write_Enable, ctrl18);
	my_dff ctr18(ctrl18, 1'b0, clk, write_Enable, ctrl19);
	my_dff ctr19(ctrl19, 1'b0, clk, write_Enable, ctrl20);
	my_dff ctr20(ctrl20, 1'b0, clk, write_Enable, ctrl21);
	my_dff ctr21(ctrl21, 1'b0, clk, write_Enable, ctrl22);
	my_dff ctr22(ctrl22, 1'b0, clk, write_Enable, ctrl23);
	my_dff ctr23(ctrl23, 1'b0, clk, write_Enable, ctrl24);
	my_dff ctr24(ctrl24, 1'b0, clk, write_Enable, ctrl25);
	my_dff ctr25(ctrl25, 1'b0, clk, write_Enable, ctrl26);
	my_dff ctr26(ctrl26, 1'b0, clk, write_Enable, ctrl27);
	my_dff ctr27(ctrl27, 1'b0, clk, write_Enable, ctrl28);
	my_dff ctr28(ctrl28, 1'b0, clk, write_Enable, ctrl29);
	my_dff ctr29(ctrl29, 1'b0, clk, write_Enable, ctrl30);
	my_dff ctr30(ctrl30, 1'b0, clk, write_Enable, ctrl31);
	my_dff ctr31(ctrl31, 1'b0, clk, write_Enable, ctrl32);
	
	assign rdy = ctrl32;
	
	register2 divis0(divisor0, 1'b0, clk, write_Enable, divisor1);
	register2 divis1(divisor1, 1'b0, clk, write_Enable, divisor2);
	register2 divis2(divisor2, 1'b0, clk, write_Enable, divisor3);
	register2 divis3(divisor3, 1'b0, clk, write_Enable, divisor4);
	register2 divis4(divisor4, 1'b0, clk, write_Enable, divisor5);
	register2 divis5(divisor5, 1'b0, clk, write_Enable, divisor6);
	register2 divis6(divisor6, 1'b0, clk, write_Enable, divisor7);
	register2 divis7(divisor7, 1'b0, clk, write_Enable, divisor8);
	register2 divis8(divisor8, 1'b0, clk, write_Enable, divisor9);
	register2 divis9(divisor9, 1'b0, clk, write_Enable, divisor10);
	register2 divis10(divisor10, 1'b0, clk, write_Enable, divisor11);
	register2 divis11(divisor11, 1'b0, clk, write_Enable, divisor12);
	register2 divis12(divisor12, 1'b0, clk, write_Enable, divisor13);
	register2 divis13(divisor13, 1'b0, clk, write_Enable, divisor14);
	register2 divis14(divisor14, 1'b0, clk, write_Enable, divisor15);
	register2 divis15(divisor15, 1'b0, clk, write_Enable, divisor16);
	register2 divis16(divisor16, 1'b0, clk, write_Enable, divisor17);
	register2 divis17(divisor17, 1'b0, clk, write_Enable, divisor18);
	register2 divis18(divisor18, 1'b0, clk, write_Enable, divisor19);
	register2 divis19(divisor19, 1'b0, clk, write_Enable, divisor20);
	register2 divis20(divisor20, 1'b0, clk, write_Enable, divisor21);
	register2 divis21(divisor21, 1'b0, clk, write_Enable, divisor22);
	register2 divis22(divisor22, 1'b0, clk, write_Enable, divisor23);
	register2 divis23(divisor23, 1'b0, clk, write_Enable, divisor24);
	register2 divis24(divisor24, 1'b0, clk, write_Enable, divisor25);
	register2 divis25(divisor25, 1'b0, clk, write_Enable, divisor26);
	register2 divis26(divisor26, 1'b0, clk, write_Enable, divisor27);
	register2 divis27(divisor27, 1'b0, clk, write_Enable, divisor28);
	register2 divis28(divisor28, 1'b0, clk, write_Enable, divisor29);
	register2 divis29(divisor29, 1'b0, clk, write_Enable, divisor30);
	register2 divis30(divisor30, 1'b0, clk, write_Enable, divisor31);
	register2 divis31(divisor31, 1'b0, clk, write_Enable, divisor32);
	
	register divid0(dividend0, 1'b0, clk, write_Enable, dividend1);
	register divid1(dividend1, 1'b0, clk, write_Enable, dividend2);
	register divid2(dividend2, 1'b0, clk, write_Enable, dividend3);
	register divid3(dividend3, 1'b0, clk, write_Enable, dividend4);
	register divid4(dividend4, 1'b0, clk, write_Enable, dividend5);
	register divid5(dividend5, 1'b0, clk, write_Enable, dividend6);
	register divid6(dividend6, 1'b0, clk, write_Enable, dividend7);
	register divid7(dividend7, 1'b0, clk, write_Enable, dividend8);
	register divid8(dividend8, 1'b0, clk, write_Enable, dividend9);
	register divid9(dividend9, 1'b0, clk, write_Enable, dividend10);
	register divid10(dividend10, 1'b0, clk, write_Enable, dividend11);
	register divid11(dividend11, 1'b0, clk, write_Enable, dividend12);
	register divid12(dividend12, 1'b0, clk, write_Enable, dividend13);
	register divid13(dividend13, 1'b0, clk, write_Enable, dividend14);
	register divid14(dividend14, 1'b0, clk, write_Enable, dividend15);
	register divid15(dividend15, 1'b0, clk, write_Enable, dividend16);
	register divid16(dividend16, 1'b0, clk, write_Enable, dividend17);
	register divid17(dividend17, 1'b0, clk, write_Enable, dividend18);
	register divid18(dividend18, 1'b0, clk, write_Enable, dividend19);
	register divid19(dividend19, 1'b0, clk, write_Enable, dividend20);
	register divid20(dividend20, 1'b0, clk, write_Enable, dividend21);
	register divid21(dividend21, 1'b0, clk, write_Enable, dividend22);
	register divid22(dividend22, 1'b0, clk, write_Enable, dividend23);
	register divid23(dividend23, 1'b0, clk, write_Enable, dividend24);
	register divid24(dividend24, 1'b0, clk, write_Enable, dividend25);
	register divid25(dividend25, 1'b0, clk, write_Enable, dividend26);
	register divid26(dividend26, 1'b0, clk, write_Enable, dividend27);
	register divid27(dividend27, 1'b0, clk, write_Enable, dividend28);
	register divid28(dividend28, 1'b0, clk, write_Enable, dividend29);
	register divid29(dividend29, 1'b0, clk, write_Enable, dividend30);
	register divid30(dividend30, 1'b0, clk, write_Enable, dividend31);
	register divid31(dividend31, 1'b0, clk, write_Enable, dividend32);
	
	
	assign di0[15:1] = {15{gdiv}};
	assign di0[0] = dividend1[31];
	CAS16 c0(divisor1, di0, tinit, rem0, t1);
	register2 #(14) remreg0(rem0, 1'b0, clk, write_Enable, srem0);
	my_dff tstall1(t1, 1'b0, clk, write_Enable, st1);
	assign irem0[0] = dividend2[30];
	assign irem0[15:1] = srem0;
	//assign result[31]= t1;
	assign divreg1[31] = t1;
	register delaydiv1(divreg1, 1'b0, clk, write_Enable, divreg2);
	
	CAS16 c1(divisor2, irem0, st1, rem1, t2);
	register2 #(14) remreg1(rem1, 1'b0, clk, write_Enable, srem1);
	assign irem1[0] = dividend3[29];
	assign irem1[15:1] = srem1;
	my_dff tstall2(t2, 1'b0, clk, write_Enable, st2);
	assign divreg3[30] = t2;
	assign divreg3[31:31] = divreg2[31:31];
	assign divreg3[29:0] = divreg2[29:0];
	register delaydiv2(divreg3, 1'b0, clk, write_Enable, divreg4);
	CAS16 c2(divisor3, irem1, st2, rem2, t3);
	register2 #(14) remreg2(rem2, 1'b0, clk, write_Enable, srem2);
	assign irem2[0] = dividend4[28];
	assign irem2[15:1] = srem2;
	my_dff tstall3(t3, 1'b0, clk, write_Enable, st3);
	assign divreg5[29] = t3;
	assign divreg5[31:30] = divreg4[31:30];
	assign divreg5[28:0] = divreg4[28:0];
	register delaydiv3(divreg5, 1'b0, clk, write_Enable, divreg6);
	CAS16 c3(divisor4, irem2, st3, rem3, t4);
	register2 #(14) remreg3(rem3, 1'b0, clk, write_Enable, srem3);
	assign irem3[0] = dividend5[27];
	assign irem3[15:1] = srem3;
	my_dff tstall4(t4, 1'b0, clk, write_Enable, st4);
	assign divreg7[28] = t4;
	assign divreg7[31:29] = divreg6[31:29];
	assign divreg7[27:0] = divreg6[27:0];
	register delaydiv4(divreg7, 1'b0, clk, write_Enable, divreg8);
	CAS16 c4(divisor5, irem3, st4, rem4, t5);
	register2 #(14) remreg4(rem4, 1'b0, clk, write_Enable, srem4);
	assign irem4[0] = dividend6[26];
	assign irem4[15:1] = srem4;
	my_dff tstall5(t5, 1'b0, clk, write_Enable, st5);
	assign divreg9[27] = t5;
	assign divreg9[31:28] = divreg8[31:28];
	assign divreg9[26:0] = divreg8[26:0];
	register delaydiv5(divreg9, 1'b0, clk, write_Enable, divreg10);
	CAS16 c5(divisor6, irem4, st5, rem5, t6);
	register2 #(14) remreg5(rem5, 1'b0, clk, write_Enable, srem5);
	assign irem5[0] = dividend7[25];
	assign irem5[15:1] = srem5;
	my_dff tstall6(t6, 1'b0, clk, write_Enable, st6);
	assign divreg11[26] = t6;
	assign divreg11[31:27] = divreg10[31:27];
	assign divreg11[25:0] = divreg10[25:0];
	register delaydiv6(divreg11, 1'b0, clk, write_Enable, divreg12);
	CAS16 c6(divisor7, irem5, st6, rem6, t7);
	register2 #(14) remreg6(rem6, 1'b0, clk, write_Enable, srem6);
	assign irem6[0] = dividend8[24];
	assign irem6[15:1] = srem6;
	my_dff tstall7(t7, 1'b0, clk, write_Enable, st7);
	assign divreg13[25] = t7;
	assign divreg13[31:26] = divreg12[31:26];
	assign divreg13[24:0] = divreg12[24:0];
	register delaydiv7(divreg13, 1'b0, clk, write_Enable, divreg14);
	CAS16 c7(divisor8, irem6, st7, rem7, t8);
	register2 #(14) remreg7(rem7, 1'b0, clk, write_Enable, srem7);
	assign irem7[0] = dividend9[23];
	assign irem7[15:1] = srem7;
	my_dff tstall8(t8, 1'b0, clk, write_Enable, st8);
	assign divreg15[24] = t8;
	assign divreg15[31:25] = divreg14[31:25];
	assign divreg15[23:0] = divreg14[23:0];
	register delaydiv8(divreg15, 1'b0, clk, write_Enable, divreg16);
	CAS16 c8(divisor9, irem7, st8, rem8, t9);
	register2 #(14) remreg8(rem8, 1'b0, clk, write_Enable, srem8);
	assign irem8[0] = dividend10[22];
	assign irem8[15:1] = srem8;
	my_dff tstall9(t9, 1'b0, clk, write_Enable, st9);
	assign divreg17[23] = t9;
	assign divreg17[31:24] = divreg16[31:24];
	assign divreg17[22:0] = divreg16[22:0];
	register delaydiv9(divreg17, 1'b0, clk, write_Enable, divreg18);
	CAS16 c9(divisor10, irem8, st9, rem9, t10);
	register2 #(14) remreg9(rem9, 1'b0, clk, write_Enable, srem9);
	assign irem9[0] = dividend11[21];
	assign irem9[15:1] = srem9;
	my_dff tstall10(t10, 1'b0, clk, write_Enable, st10);
	assign divreg19[22] = t10;
	assign divreg19[31:23] = divreg18[31:23];
	assign divreg19[21:0] = divreg18[21:0];
	register delaydiv10(divreg19, 1'b0, clk, write_Enable, divreg20);
	CAS16 c10(divisor11, irem9, st10, rem10, t11);
	register2 #(14) remreg10(rem10, 1'b0, clk, write_Enable, srem10);
	assign irem10[0] = dividend12[20];
	assign irem10[15:1] = srem10;
	my_dff tstall11(t11, 1'b0, clk, write_Enable, st11);
	assign divreg21[21] = t11;
	assign divreg21[31:22] = divreg20[31:22];
	assign divreg21[20:0] = divreg20[20:0];
	register delaydiv11(divreg21, 1'b0, clk, write_Enable, divreg22);
	CAS16 c11(divisor12, irem10, st11, rem11, t12);
	register2 #(14) remreg11(rem11, 1'b0, clk, write_Enable, srem11);
	assign irem11[0] = dividend13[19];
	assign irem11[15:1] = srem11;
	my_dff tstall12(t12, 1'b0, clk, write_Enable, st12);
	assign divreg23[20] = t12;
	assign divreg23[31:21] = divreg22[31:21];
	assign divreg23[19:0] = divreg22[19:0];
	register delaydiv12(divreg23, 1'b0, clk, write_Enable, divreg24);
	CAS16 c12(divisor13, irem11, st12, rem12, t13);
	register2 #(14) remreg12(rem12, 1'b0, clk, write_Enable, srem12);
	assign irem12[0] = dividend14[18];
	assign irem12[15:1] = srem12;
	my_dff tstall13(t13, 1'b0, clk, write_Enable, st13);
	assign divreg25[19] = t13;
	assign divreg25[31:20] = divreg24[31:20];
	assign divreg25[18:0] = divreg24[18:0];
	register delaydiv13(divreg25, 1'b0, clk, write_Enable, divreg26);
	CAS16 c13(divisor14, irem12, st13, rem13, t14);
	register2 #(14) remreg13(rem13, 1'b0, clk, write_Enable, srem13);
	assign irem13[0] = dividend15[17];
	assign irem13[15:1] = srem13;
	my_dff tstall14(t14, 1'b0, clk, write_Enable, st14);
	assign divreg27[18] = t14;
	assign divreg27[31:19] = divreg26[31:19];
	assign divreg27[17:0] = divreg26[17:0];
	register delaydiv14(divreg27, 1'b0, clk, write_Enable, divreg28);
	CAS16 c14(divisor15, irem13, st14, rem14, t15);
	register2 #(14) remreg14(rem14, 1'b0, clk, write_Enable, srem14);
	assign irem14[0] = dividend16[16];
	assign irem14[15:1] = srem14;
	my_dff tstall15(t15, 1'b0, clk, write_Enable, st15);
	assign divreg29[17] = t15;
	assign divreg29[31:18] = divreg28[31:18];
	assign divreg29[16:0] = divreg28[16:0];
	register delaydiv15(divreg29, 1'b0, clk, write_Enable, divreg30);
	CAS16 c15(divisor16, irem14, st15, rem15, t16);
	register2 #(14) remreg15(rem15, 1'b0, clk, write_Enable, srem15);
	assign irem15[0] = dividend17[15];
	assign irem15[15:1] = srem15;
	my_dff tstall16(t16, 1'b0, clk, write_Enable, st16);
	assign divreg31[16] = t16;
	assign divreg31[31:17] = divreg30[31:17];
	assign divreg31[15:0] = divreg30[15:0];
	register delaydiv16(divreg31, 1'b0, clk, write_Enable, divreg32);
	CAS16 c16(divisor17, irem15, st16, rem16, t17);
	register2 #(14) remreg16(rem16, 1'b0, clk, write_Enable, srem16);
	assign irem16[0] = dividend18[14];
	assign irem16[15:1] = srem16;
	my_dff tstall17(t17, 1'b0, clk, write_Enable, st17);
	assign divreg33[15] = t17;
	assign divreg33[31:16] = divreg32[31:16];
	assign divreg33[14:0] = divreg32[14:0];
	register delaydiv17(divreg33, 1'b0, clk, write_Enable, divreg34);
	CAS16 c17(divisor18, irem16, st17, rem17, t18);
	register2 #(14) remreg17(rem17, 1'b0, clk, write_Enable, srem17);
	assign irem17[0] = dividend19[13];
	assign irem17[15:1] = srem17;
	my_dff tstall18(t18, 1'b0, clk, write_Enable, st18);
	assign divreg35[14] = t18;
	assign divreg35[31:15] = divreg34[31:15];
	assign divreg35[13:0] = divreg34[13:0];
	register delaydiv18(divreg35, 1'b0, clk, write_Enable, divreg36);
	CAS16 c18(divisor19, irem17, st18, rem18, t19);
	register2 #(14) remreg18(rem18, 1'b0, clk, write_Enable, srem18);
	assign irem18[0] = dividend20[12];
	assign irem18[15:1] = srem18;
	my_dff tstall19(t19, 1'b0, clk, write_Enable, st19);
	assign divreg37[13] = t19;
	assign divreg37[31:14] = divreg36[31:14];
	assign divreg37[12:0] = divreg36[12:0];
	register delaydiv19(divreg37, 1'b0, clk, write_Enable, divreg38);
	CAS16 c19(divisor20, irem18, st19, rem19, t20);
	register2 #(14) remreg19(rem19, 1'b0, clk, write_Enable, srem19);
	assign irem19[0] = dividend21[11];
	assign irem19[15:1] = srem19;
	my_dff tstall20(t20, 1'b0, clk, write_Enable, st20);
	assign divreg39[12] = t20;
	assign divreg39[31:13] = divreg38[31:13];
	assign divreg39[11:0] = divreg38[11:0];
	register delaydiv20(divreg39, 1'b0, clk, write_Enable, divreg40);
	CAS16 c20(divisor21, irem19, st20, rem20, t21);
	register2 #(14) remreg20(rem20, 1'b0, clk, write_Enable, srem20);
	assign irem20[0] = dividend22[10];
	assign irem20[15:1] = srem20;
	my_dff tstall21(t21, 1'b0, clk, write_Enable, st21);
	assign divreg41[11] = t21;
	assign divreg41[31:12] = divreg40[31:12];
	assign divreg41[10:0] = divreg40[10:0];
	register delaydiv21(divreg41, 1'b0, clk, write_Enable, divreg42);
	CAS16 c21(divisor22, irem20, st21, rem21, t22);
	register2 #(14) remreg21(rem21, 1'b0, clk, write_Enable, srem21);
	assign irem21[0] = dividend23[9];
	assign irem21[15:1] = srem21;
	my_dff tstall22(t22, 1'b0, clk, write_Enable, st22);
	assign divreg43[10] = t22;
	assign divreg43[31:11] = divreg42[31:11];
	assign divreg43[9:0] = divreg42[9:0];
	register delaydiv22(divreg43, 1'b0, clk, write_Enable, divreg44);
	CAS16 c22(divisor23, irem21, st22, rem22, t23);
	register2 #(14) remreg22(rem22, 1'b0, clk, write_Enable, srem22);
	assign irem22[0] = dividend24[8];
	assign irem22[15:1] = srem22;
	my_dff tstall23(t23, 1'b0, clk, write_Enable, st23);
	assign divreg45[9] = t23;
	assign divreg45[31:10] = divreg44[31:10];
	assign divreg45[8:0] = divreg44[8:0];
	register delaydiv23(divreg45, 1'b0, clk, write_Enable, divreg46);
	CAS16 c23(divisor24, irem22, st23, rem23, t24);
	register2 #(14) remreg23(rem23, 1'b0, clk, write_Enable, srem23);
	assign irem23[0] = dividend25[7];
	assign irem23[15:1] = srem23;
	my_dff tstall24(t24, 1'b0, clk, write_Enable, st24);
	assign divreg47[8] = t24;
	assign divreg47[31:9] = divreg46[31:9];
	assign divreg47[7:0] = divreg46[7:0];
	register delaydiv24(divreg47, 1'b0, clk, write_Enable, divreg48);
	CAS16 c24(divisor25, irem23, st24, rem24, t25);
	register2 #(14) remreg24(rem24, 1'b0, clk, write_Enable, srem24);
	assign irem24[0] = dividend26[6];
	assign irem24[15:1] = srem24;
	my_dff tstall25(t25, 1'b0, clk, write_Enable, st25);
	assign divreg49[7] = t25;
	assign divreg49[31:8] = divreg48[31:8];
	assign divreg49[6:0] = divreg48[6:0];
	register delaydiv25(divreg49, 1'b0, clk, write_Enable, divreg50);
	CAS16 c25(divisor26, irem24, st25, rem25, t26);
	register2 #(14) remreg25(rem25, 1'b0, clk, write_Enable, srem25);
	assign irem25[0] = dividend27[5];
	assign irem25[15:1] = srem25;
	my_dff tstall26(t26, 1'b0, clk, write_Enable, st26);
	assign divreg51[6] = t26;
	assign divreg51[31:7] = divreg50[31:7];
	assign divreg51[5:0] = divreg50[5:0];
	register delaydiv26(divreg51, 1'b0, clk, write_Enable, divreg52);
	CAS16 c26(divisor27, irem25, st26, rem26, t27);
	register2 #(14) remreg26(rem26, 1'b0, clk, write_Enable, srem26);
	assign irem26[0] = dividend28[4];
	assign irem26[15:1] = srem26;
	my_dff tstall27(t27, 1'b0, clk, write_Enable, st27);
	assign divreg53[5] = t27;
	assign divreg53[31:6] = divreg52[31:6];
	assign divreg53[4:0] = divreg52[4:0];
	register delaydiv27(divreg53, 1'b0, clk, write_Enable, divreg54);
	CAS16 c27(divisor28, irem26, st27, rem27, t28);
	register2 #(14) remreg27(rem27, 1'b0, clk, write_Enable, srem27);
	assign irem27[0] = dividend29[3];
	assign irem27[15:1] = srem27;
	my_dff tstall28(t28, 1'b0, clk, write_Enable, st28);
	assign divreg55[4] = t28;
	assign divreg55[31:5] = divreg54[31:5];
	assign divreg55[3:0] = divreg54[3:0];
	register delaydiv28(divreg55, 1'b0, clk, write_Enable, divreg56);
	CAS16 c28(divisor29, irem27, st28, rem28, t29);
	register2 #(14) remreg28(rem28, 1'b0, clk, write_Enable, srem28);
	assign irem28[0] = dividend30[2];
	assign irem28[15:1] = srem28;
	my_dff tstall29(t29, 1'b0, clk, write_Enable, st29);
	assign divreg57[3] = t29;
	assign divreg57[31:4] = divreg56[31:4];
	assign divreg57[2:0] = divreg56[2:0];
	register delaydiv29(divreg57, 1'b0, clk, write_Enable, divreg58);
	CAS16 c29(divisor30, irem28, st29, rem29, t30);
	register2 #(14) remreg29(rem29, 1'b0, clk, write_Enable, srem29);
	assign irem29[0] = dividend31[1];
	assign irem29[15:1] = srem29;
	my_dff tstall30(t30, 1'b0, clk, write_Enable, st30);
	assign divreg59[2] = t30;
	assign divreg59[31:3] = divreg58[31:3];
	assign divreg59[1:0] = divreg58[1:0];
	register delaydiv30(divreg59, 1'b0, clk, write_Enable, divreg60);
	CAS16 c30(divisor31, irem29, st30, rem30, t31);
	register2 #(14) remreg30(rem30, 1'b0, clk, write_Enable, srem30);
	assign irem30[0] = dividend32[0];
	assign irem30[15:1] = srem30;
	my_dff tstall31(t31, 1'b0, clk, write_Enable, st31);
	assign divreg61[1] = t31;
	assign divreg61[31:2] = divreg60[31:2];
	assign divreg61[0:0] = divreg60[0:0];
	register delaydiv31(divreg61, 1'b0, clk, write_Enable, divreg62);
	CAS16 c31(divisor32, irem30, st31, rem31, t32);
	assign divreg63[0] = t32;
	assign divreg63[31:1] = divreg62[31:1];
	assign result = divreg63;

	
	assign ex0 = ~(B[0] | B[1] |B[2] | B[3] | B[4] | B[5] | B[6] | B[7] 
						| B[8] | B[9] | B[10] | B[11] | B[12] |B[13] | B[14] | B[15]);
		
		my_dff excep0(ex0, 1'b0, clk, write_Enable, ex1);			
		my_dff excep1(ex1, 1'b0, clk, write_Enable, ex2);
		my_dff excep2(ex2, 1'b0, clk, write_Enable, ex3);
		my_dff excep3(ex3, 1'b0, clk, write_Enable, ex4);
		my_dff excep4(ex4, 1'b0, clk, write_Enable, ex5);
		my_dff excep5(ex5, 1'b0, clk, write_Enable, ex6);
		my_dff excep6(ex6, 1'b0, clk, write_Enable, ex7);
		my_dff excep7(ex7, 1'b0, clk, write_Enable, ex8);
		my_dff excep8(ex8, 1'b0, clk, write_Enable, ex9);
		my_dff excep9(ex9, 1'b0, clk, write_Enable, ex10);
		my_dff excep10(ex10, 1'b0, clk, write_Enable, ex11);
		my_dff excep11(ex11, 1'b0, clk, write_Enable, ex12);
		my_dff excep12(ex12, 1'b0, clk, write_Enable, ex13);
		my_dff excep13(ex13, 1'b0, clk, write_Enable, ex14);
		my_dff excep14(ex14, 1'b0, clk, write_Enable, ex15);
		my_dff excep15(ex15, 1'b0, clk, write_Enable, ex16);
		my_dff excep16(ex16, 1'b0, clk, write_Enable, ex17);
		my_dff excep17(ex17, 1'b0, clk, write_Enable, ex18);
		my_dff excep18(ex18, 1'b0, clk, write_Enable, ex19);
		my_dff excep19(ex19, 1'b0, clk, write_Enable, ex20);
		my_dff excep20(ex20, 1'b0, clk, write_Enable, ex21);
		my_dff excep21(ex21, 1'b0, clk, write_Enable, ex22);
		my_dff excep22(ex22, 1'b0, clk, write_Enable, ex23);
		my_dff excep23(ex23, 1'b0, clk, write_Enable, ex24);
		my_dff excep24(ex24, 1'b0, clk, write_Enable, ex25);
		my_dff excep25(ex25, 1'b0, clk, write_Enable, ex26);
		my_dff excep26(ex26, 1'b0, clk, write_Enable, ex27);
		my_dff excep27(ex27, 1'b0, clk, write_Enable, ex28);
		my_dff excep28(ex28, 1'b0, clk, write_Enable, ex29);
		my_dff excep29(ex29, 1'b0, clk, write_Enable, ex30);
		my_dff excep30(ex30, 1'b0, clk, write_Enable, ex31);
		my_dff excep31(ex31, 1'b0, clk, write_Enable, exception);				

	assign notResult = ~result;
	CLA der3(notResult, car1, 1'b1, compResult, nreq);
	assign Result = {32{((msbB32&(~msbA32))|(~msbB32&(msbA32)))}}&compResult | 
					{32{((msbB32&(msbA32))|(~msbB32&(~msbA32)))}}&result;

endmodule




module CAS16(divisor, dividend, T, remainder_out, tnext);
	input [15:0] divisor, dividend;
	input T;
	output [14:0] remainder_out;
	output tnext;
	wire [15:0] ripple;
	wire notMSB;
	genvar i;
	
		CAS cas1(divisor[0], dividend[0], T, T, ripple[0], remainder_out[0]);
	generate
		
		for (i = 1; i < 15; i = i + 1) begin: CASblock
				CAS cas2(divisor[i], dividend[i], T, ripple[i-1], ripple[i], remainder_out[i]);
		end 
	 endgenerate
		
		CAS cas3(divisor[15], dividend[15], T, ripple[14], ripple[15], notMSB);
		assign tnext = ~notMSB;
endmodule

module CAS(divisor, remainder_in, T, cin, cout, remainder_out);
	input divisor, remainder_in, T, cin;
	output cout, remainder_out;
	wire xOR;
	
	assign xOR = T^divisor;
	modFullAdder2 modAdder2(xOR, remainder_in, cin, remainder_out, cout);
endmodule


module modFullAdder2(a, b, cIn, sOut, cOut);
	input a,b,cIn;
	output sOut, cOut; // sum and carry out
	assign sOut = a^b^cIn;
	assign cOut = a&b | (a|b)&cIn;
endmodule


// 16 by 16 multiplier without registers
module multiplier(mplicand, mplier, ctmul0, clk, write_Enable, out,overflow, rdymul);
	input [15:0] mplier, mplicand;
	input clk, write_Enable, ctmul0;
	output [31:0] out;
	output overflow, rdymul;
	wire msbC0, msbC1, msbC2, msbC3, msbC4, msbC5, msbC6, msbC7, msbC8, msbC9, msbC10, msbC11, msbC12, msbC13, msbC14, msbC15, msbC16;
	wire msbC17, msbC18, msbC19, msbC20, msbC21, msbC22, msbC23, msbC24, msbC25, msbC26, msbC27, msbC28, msbC29, msbC30, msbC31, msbC32;
	wire msbP0, msbP1, msbP2, msbP3, msbP4, msbP5, msbP6, msbP7, msbP8, msbP9, msbP10, msbP11, msbP12, msbP13, msbP14, msbP15, msbP16;
	wire msbP17, msbP18, msbP19, msbP20, msbP21, msbP22, msbP23, msbP24, msbP25, msbP26, msbP27, msbP28, msbP29, msbP30, msbP31, msbP32;
	wire cout1, cout2, cout3, cout4, overflow1;
	wire [15:0] c0,s16, s17, notMultilpicand, notMultiplier, multiplicand, multiplier, comPlicand, comPlier;
	wire[31:0] product, notProduct, compProduct, out1, product0, product1, product2, product3, product4, product5, product6, product7; 
	wire[31:0] product8, product9, product10, product11, product12, product13;
	//for multiplier
	wire [31:0] m0, m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, m15, m16, m17, m18;
	wire [31:0] mu0, mu1, mu2, mu3, mu4, mu5, mu6, mu7, mu8, mu9, mu10, mu11, mu12, mu13, mu14, mu15, mu16, mu17, mu18;
	//for sum
	wire [31:0] s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15;
	wire [31:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15,e16, g32;
	//for carry
	wire [15:0] d0, d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14, d15;
	wire [15:0] e0, e1, e2, e3, e4, e5, e6, e7, e8, e9, e10, e11, e12, e13, e14, e15;
	wire ctmul1, ctmul2, ctmul3, ctmul4, ctmul5, ctmul6, ctmul7, ctmul8, ctmul9, ctmul10, ctmul11, ctmul12, ctmul13, ctmul14, ctmul15, ctmul16;
	wire ctmul17, ctmul18, ctmul19, ctmul20, ctmul21, ctmul22, ctmul23, ctmul24, ctmul25, ctmul26, ctmul27, ctmul28, ctmul29, ctmul30, ctmul31, ctmul32;
	wire overflow0, overflow2, overflow3, overflow4, overflow5, overflow6, overflow7, overflow8, overflow9, overflow10, overflow11;
	wire overflow12, overflow13;
	assign notMultilpicand = ~mplicand;
	assign notMultiplier = ~mplier;
	wire zer;
	
	assign c0 = {16{1'b0}};
	assign s16 = {16{1'b0}};
	
	assign msbC0 = mplicand[15];
	assign msbP0 = mplier[15];
	
	CLA2 comp1(notMultilpicand, c0, 1'b1, comPlicand, cout1);
	CLA2 comp2(notMultiplier, c0, 1'b1, comPlier, cout2);
	
	assign multiplier = {16{mplier[15]}}&comPlier| {16{~mplier[15]}}&mplier;
	assign multiplicand = (({16{mplicand[15]}}&comPlicand)|({16{~mplicand[15]}}&mplicand))& {16{ctmul0}};
	
	my_dff ctrm0(ctmul0, 1'b0, clk, write_Enable, ctmul1);
	my_dff ctrm1(ctmul1, 1'b0, clk, write_Enable, ctmul2);
	my_dff ctrm2(ctmul2, 1'b0, clk, write_Enable, ctmul3);
	my_dff ctrm3(ctmul3, 1'b0, clk, write_Enable, ctmul4);
	my_dff ctrm4(ctmul4, 1'b0, clk, write_Enable, ctmul5);
	my_dff ctrm5(ctmul5, 1'b0, clk, write_Enable, ctmul6);
	my_dff ctrm6(ctmul6, 1'b0, clk, write_Enable, ctmul7);
	my_dff ctrm7(ctmul7, 1'b0, clk, write_Enable, ctmul8);
	my_dff ctrm8(ctmul8, 1'b0, clk, write_Enable, ctmul9);
	my_dff ctrm9(ctmul9, 1'b0, clk, write_Enable, ctmul10);
	my_dff ctrm10(ctmul10, 1'b0, clk, write_Enable, ctmul11);
	my_dff ctrm11(ctmul11, 1'b0, clk, write_Enable, ctmul12);
	my_dff ctrm12(ctmul12, 1'b0, clk, write_Enable, ctmul13);
	my_dff ctrm13(ctmul13, 1'b0, clk, write_Enable, ctmul14);
	my_dff ctrm14(ctmul14, 1'b0, clk, write_Enable, ctmul15);
	my_dff ctrm15(ctmul15, 1'b0, clk, write_Enable, ctmul16);
	my_dff ctrm16(ctmul16, 1'b0, clk, write_Enable, ctmul17);
	my_dff ctrm17(ctmul17, 1'b0, clk, write_Enable, ctmul18);
	my_dff ctrm18(ctmul18, 1'b0, clk, write_Enable, ctmul19);
	my_dff ctrm19(ctmul19, 1'b0, clk, write_Enable, ctmul20);
	my_dff ctrm20(ctmul20, 1'b0, clk, write_Enable, ctmul21);
	my_dff ctrm21(ctmul21, 1'b0, clk, write_Enable, ctmul22);
	my_dff ctrm22(ctmul22, 1'b0, clk, write_Enable, ctmul23);
	my_dff ctrm23(ctmul23, 1'b0, clk, write_Enable, ctmul24);
	my_dff ctrm24(ctmul24, 1'b0, clk, write_Enable, ctmul25);
	my_dff ctrm25(ctmul25, 1'b0, clk, write_Enable, ctmul26);
	my_dff ctrm26(ctmul26, 1'b0, clk, write_Enable, ctmul27);
	my_dff ctrm27(ctmul27, 1'b0, clk, write_Enable, ctmul28);
	my_dff ctrm28(ctmul28, 1'b0, clk, write_Enable, ctmul29);
	my_dff ctrm29(ctmul29, 1'b0, clk, write_Enable, ctmul30);
	my_dff ctrm30(ctmul30, 1'b0, clk, write_Enable, ctmul31);
	my_dff ctrm31(ctmul31, 1'b0, clk, write_Enable, ctmul32);
	assign rdymul = ctmul32;
	
	my_dff multC0(msbC0, 1'b0, clk, write_Enable, msbC1);
	my_dff multC1(msbC1, 1'b0, clk, write_Enable, msbC2);
	my_dff multC2(msbC2, 1'b0, clk, write_Enable, msbC3);
	my_dff multC3(msbC3, 1'b0, clk, write_Enable, msbC4);
	my_dff multC4(msbC4, 1'b0, clk, write_Enable, msbC5);
	my_dff multC5(msbC5, 1'b0, clk, write_Enable, msbC6);
	my_dff multC6(msbC6, 1'b0, clk, write_Enable, msbC7);
	my_dff multC7(msbC7, 1'b0, clk, write_Enable, msbC8);
	my_dff multC8(msbC8, 1'b0, clk, write_Enable, msbC9);
	my_dff multC9(msbC9, 1'b0, clk, write_Enable, msbC10);
	my_dff multC10(msbC10, 1'b0, clk, write_Enable, msbC11);
	my_dff multC11(msbC11, 1'b0, clk, write_Enable, msbC12);
	my_dff multC12(msbC12, 1'b0, clk, write_Enable, msbC13);
	my_dff multC13(msbC13, 1'b0, clk, write_Enable, msbC14);
	my_dff multC14(msbC14, 1'b0, clk, write_Enable, msbC15);
	my_dff multC15(msbC15, 1'b0, clk, write_Enable, msbC16);
	my_dff multC16(msbC16, 1'b0, clk, write_Enable, msbC17);
	my_dff multC17(msbC17, 1'b0, clk, write_Enable, msbC18);
	my_dff multC18(msbC18, 1'b0, clk, write_Enable, msbC19);
	my_dff multC19(msbC19, 1'b0, clk, write_Enable, msbC20);
	my_dff multC20(msbC20, 1'b0, clk, write_Enable, msbC21);
	my_dff multC21(msbC21, 1'b0, clk, write_Enable, msbC22);
	my_dff multC22(msbC22, 1'b0, clk, write_Enable, msbC23);
	my_dff multC23(msbC23, 1'b0, clk, write_Enable, msbC24);
	my_dff multC24(msbC24, 1'b0, clk, write_Enable, msbC25);
	my_dff multC25(msbC25, 1'b0, clk, write_Enable, msbC26);
	my_dff multC26(msbC26, 1'b0, clk, write_Enable, msbC27);
	my_dff multC27(msbC27, 1'b0, clk, write_Enable, msbC28);
	my_dff multC28(msbC28, 1'b0, clk, write_Enable, msbC29);
	my_dff multC29(msbC29, 1'b0, clk, write_Enable, msbC30);
	my_dff multC30(msbC30, 1'b0, clk, write_Enable, msbC31);
	my_dff multC31(msbC31, 1'b0, clk, write_Enable, msbC32);
	
	my_dff multP0(msbP0, 1'b0, clk, write_Enable, msbP1);
	my_dff multP1(msbP1, 1'b0, clk, write_Enable, msbP2);
	my_dff multP2(msbP2, 1'b0, clk, write_Enable, msbP3);
	my_dff multP3(msbP3, 1'b0, clk, write_Enable, msbP4);
	my_dff multP4(msbP4, 1'b0, clk, write_Enable, msbP5);
	my_dff multP5(msbP5, 1'b0, clk, write_Enable, msbP6);
	my_dff multP6(msbP6, 1'b0, clk, write_Enable, msbP7);
	my_dff multP7(msbP7, 1'b0, clk, write_Enable, msbP8);
	my_dff multP8(msbP8, 1'b0, clk, write_Enable, msbP9);
	my_dff multP9(msbP9, 1'b0, clk, write_Enable, msbP10);
	my_dff multP10(msbP10, 1'b0, clk, write_Enable, msbP11);
	my_dff multP11(msbP11, 1'b0, clk, write_Enable, msbP12);
	my_dff multP12(msbP12, 1'b0, clk, write_Enable, msbP13);
	my_dff multP13(msbP13, 1'b0, clk, write_Enable, msbP14);
	my_dff multP14(msbP14, 1'b0, clk, write_Enable, msbP15);
	my_dff multP15(msbP15, 1'b0, clk, write_Enable, msbP16);
	my_dff multP16(msbP16, 1'b0, clk, write_Enable, msbP17);
	my_dff multP17(msbP17, 1'b0, clk, write_Enable, msbP18);
	my_dff multP18(msbP18, 1'b0, clk, write_Enable, msbP19);
	my_dff multP19(msbP19, 1'b0, clk, write_Enable, msbP20);
	my_dff multP20(msbP20, 1'b0, clk, write_Enable, msbP21);
	my_dff multP21(msbP21, 1'b0, clk, write_Enable, msbP22);
	my_dff multP22(msbP22, 1'b0, clk, write_Enable, msbP23);
	my_dff multP23(msbP23, 1'b0, clk, write_Enable, msbP24);
	my_dff multP24(msbP24, 1'b0, clk, write_Enable, msbP25);
	my_dff multP25(msbP25, 1'b0, clk, write_Enable, msbP26);
	my_dff multP26(msbP26, 1'b0, clk, write_Enable, msbP27);
	my_dff multP27(msbP27, 1'b0, clk, write_Enable, msbP28);
	my_dff multP28(msbP28, 1'b0, clk, write_Enable, msbP29);
	my_dff multP29(msbP29, 1'b0, clk, write_Enable, msbP30);
	my_dff multP30(msbP30, 1'b0, clk, write_Enable, msbP31);
	my_dff multP31(msbP31, 1'b0, clk, write_Enable, msbP32);
	
	assign mu0[31:16] = {16{1'b0}};
	assign r0[31:16] = {16{1'b0}};
//	assign r1[31:16] = {16{1'b0}};
	assign r2[31:17] = {15{1'b0}};
//	assign r3[31:17] = {15{1'b0}};
	assign r4[31:18] = {14{1'b0}};
//	assign r5[31:18] = {14{1'b0}};
	assign r6[31:19] = {13{1'b0}};
//	assign r7[31:19] = {13{1'b0}};
	assign r8[31:20] = {12{1'b0}};
//	assign r9[31:20] = {12{1'b0}};
	assign r10[31:21] = {11{1'b0}};
//	assign r11[31:21] = {11{1'b0}};
	assign r12[31:22] = {10{1'b0}};
//	assign r13[31:22] = {10{1'b0}};
	assign r14[31:23] = {9{1'b0}};
//	assign r15[31:23] = {9{1'b0}};
	assign s0[31:24] = {8{1'b0}};
//	assign s1[31:24] = {8{1'b0}};
	assign s2[31:25] = {7{1'b0}};
//	assign s3[31:25] = {7{1'b0}};
	assign s4[31:26] = {6{1'b0}};
//	assign s5[31:26] = {6{1'b0}};
	assign s6[31:27] = {5{1'b0}};
//	assign s7[31:27] = {5{1'b0}};
	assign s8[31:28] = {4{1'b0}};
//	assign s9[31:28] = {4{1'b0}};
	assign s10[31:29] = {3{1'b0}};
//	assign s11[31:29] = {3{1'b0}};
	assign s12[31:30] = {2{1'b0}};
//	assign s13[31:30] = {2{1'b0}};
	assign s14[31:31] = 1'b0;
//	assign s15[31:31] = 1'b0;
//	

	assign m0[31:16] = {16{1'b0}};
	assign m0[15:0] = multiplier;
	assign mu0[15:0] = multiplicand;
	
	register regist0(mu0, 1'b0, clk, write_Enable, mu1);
	register regist1(mu1, 1'b0, clk, write_Enable, mu2);
	register regist2(mu2, 1'b0, clk, write_Enable, mu3);
	register regist3(mu3, 1'b0, clk, write_Enable, mu4);
	register regist4(mu4, 1'b0, clk, write_Enable, mu5);
	register regist5(mu5, 1'b0, clk, write_Enable, mu6);
	register regist6(mu6, 1'b0, clk, write_Enable, mu7);
	register regist7(mu7, 1'b0, clk, write_Enable, mu8);
	register regist8(mu8, 1'b0, clk, write_Enable, mu9);
	register regist9(mu9, 1'b0, clk, write_Enable, mu10);
	register regist10(mu10, 1'b0, clk, write_Enable, mu11);
	register regist11(mu11, 1'b0, clk, write_Enable, mu12);
	register regist12(mu12, 1'b0, clk, write_Enable, mu13);
	register regist13(mu13, 1'b0, clk, write_Enable, mu14);
	register regist14(mu14, 1'b0, clk, write_Enable, mu15);
	register regist15(mu15, 1'b0, clk, write_Enable, mu16);
	register regist16(mu16, 1'b0, clk, write_Enable, mu17);
	register regist17(mu17, 1'b0, clk, write_Enable, mu18);
	
	register regis0(m0, 1'b0, clk, write_Enable, m1);
	register regis1(m1, 1'b0, clk, write_Enable, m2);
	register regis2(m2, 1'b0, clk, write_Enable, m3);
	register regis3(m3, 1'b0, clk, write_Enable, m4);
	register regis4(m4, 1'b0, clk, write_Enable, m5);
	register regis5(m5, 1'b0, clk, write_Enable, m6);
	register regis6(m6, 1'b0, clk, write_Enable, m7);
	register regis7(m7, 1'b0, clk, write_Enable, m8);
	register regis8(m8, 1'b0, clk, write_Enable, m9);
	register regis9(m9, 1'b0, clk, write_Enable, m10);
	register regis10(m10, 1'b0, clk, write_Enable, m11);
	register regis11(m11, 1'b0, clk, write_Enable, m12);
	register regis12(m12, 1'b0, clk, write_Enable, m13);
	register regis13(m13, 1'b0, clk, write_Enable, m14);
	register regis14(m14, 1'b0, clk, write_Enable, m15);
	register regis15(m15, 1'b0, clk, write_Enable, m16);
	register regis16(m16, 1'b0, clk, write_Enable, m17);
	register regis17(m17, 1'b0, clk, write_Enable, m18);

	
	CSA adder0(mu1[15:0], m1[0], s16, c0, r0[15:0], d0);
	register reg0(r0, 1'b0, clk, write_Enable, r1);
	register2 re(d0, 1'b0, clk, write_Enable, d1);
	assign r2[0] = r1[0];
	CSA adder1(mu2[15:0], m2[1], r1[15:0], d1,r2[16:1], d2);
	register reg1(r2, 1'b0, clk, write_Enable, r3);
	assign r4[1:0] = r3[1:0];
	register2 re1(d2, 1'b0, clk, write_Enable, d3);
	CSA adder2(mu3[15:0], m3[2], r3[16:1], d3, r4[17:2], d4);
	register reg15(r4, 1'b0, clk, write_Enable, r5);
	assign r6[2:0] = r5[2:0];
	register2 re15(d4, 1'b0, clk, write_Enable, d5);
	CSA adder3(mu4[15:0], m4[3], r5[17:2], d5, r6[18:3], d6);
	register reg2(r6, 1'b0, clk, write_Enable, r7);
	assign r8[3:0] = r7[3:0];	
	register2 re2(d6, 1'b0, clk, write_Enable, d7);
	CSA adder4(mu5[15:0], m5[4], r7[18:3], d7, r8[19:4], d8);
	register reg3(r8, 1'b0, clk, write_Enable, r9);
	assign r10[4:0] = r9[4:0];
	register2 re3(d8, 1'b0, clk, write_Enable, d9);
	CSA adder5(mu6[15:0], m6[5], r9[19:4], d9, r10[20:5], d10);
	register reg4(r10, 1'b0, clk, write_Enable, r11);
	assign r12[5:0] = r11[5:0];
	register2 re4(d10, 1'b0, clk, write_Enable, d11);
	CSA adder6(mu7[15:0], m7[6], r11[20:5], d11, r12[21:6], d12);
	register reg5(r12, 1'b0, clk, write_Enable, r13);
	assign r14[6:0] = r13[6:0];
	register2 re5(d12, 1'b0, clk, write_Enable, d13);
	CSA adder7(mu8[15:0], m8[7], r13[21:6], d13,r14[22:7], d14);
	register reg6(r14, 1'b0, clk, write_Enable, r15);
	assign s0[7:0] = r15[7:0];
	register2 re6(d14, 1'b0, clk, write_Enable, d15);
	CSA adder8(mu9[15:0], m9[8], r15[22:7], d15, s0[23:8], e0);
	register reg7(s0, 1'b0, clk, write_Enable, s1);
	assign s2[8:0] = s1[8:0];
	register2 re7(e0, 1'b0, clk, write_Enable, e1);
	CSA adder9(mu10[15:0], m10[9], s1[23:8], e1, s2[24:9], e2);
	register reg8(s2, 1'b0, clk, write_Enable, s3);
	assign s4[9:0] = s3[9:0];
	register2 re8(e2, 1'b0, clk, write_Enable, e3);
	CSA adder10(mu11[15:0], m11[10], s3[24:9], e3, s4[25:10], e4);
	register reg9(s4, 1'b0, clk, write_Enable, s5);
	assign s6[10:0] = s5[10:0];
	register2 re9(e4, 1'b0, clk, write_Enable, e5);
	CSA adder11(mu12[15:0], m12[11], s5[25:10], e5, s6[26:11], e6);
	register reg10(s6, 1'b0, clk, write_Enable, s7);
	assign s8[11:0] = s7[11:0];
	register2 re10(e6, 1'b0, clk, write_Enable, e7);
	CSA adder12(mu13[15:0], m13[12], s7[26:11], e7, s8[27:12], e8);
	register reg11(s8, 1'b0, clk, write_Enable, s9);
	assign s10[12:0] = s9[12:0];
	register2 re11(e8, 1'b0, clk, write_Enable, e9);
	CSA adder13(mu14[15:0], m14[13], s9[27:12], e9, s10[28:13], e10);
	register reg12(s10, 1'b0, clk, write_Enable, s11);
	assign s12[13:0] = s11[13:0];
	register2 re12(e10, 1'b0, clk, write_Enable, e11);
	CSA adder14(mu15[15:0], m15[14], s11[28:13], e11, s12[29:14], e12);
	register reg13(s12, 1'b0, clk, write_Enable, s13);
	assign s14[14:0] = s13[14:0];
	register2 re13(e12, 1'b0, clk, write_Enable, e13);
	CSA adder15(mu16[15:0], m16[15], s13[29:14], e13, s14[30:15],  e14);
	register reg14(s14, 1'b0, clk, write_Enable, s15);
	register2 re14(e14, 1'b0, clk, write_Enable, e15);
	
	assign s17[15] = 1'b0;
	assign s17[14:0] = s15[30:16];
	CLA2 adder16(s17, e15, 1'b0, e16[31:16], overflow0);
	assign e16[15:0] = s15[15:0];
	register re16(e16, 1'b0, clk, write_Enable, product0);
	register delToMatch0(product0, 1'b0, clk, write_Enable, product1);
	register delToMatch1(product1, 1'b0, clk, write_Enable, product2);
	register delToMatch2(product2, 1'b0, clk, write_Enable, product3);
	register delToMatch3(product3, 1'b0, clk, write_Enable, product4);
	register delToMatch4(product4, 1'b0, clk, write_Enable, product5);
	register delToMatch5(product5, 1'b0, clk, write_Enable, product6);
	register delToMatch6(product6, 1'b0, clk, write_Enable, product7);
	register delToMatch7(product7, 1'b0, clk, write_Enable, product8);
	register delToMatch8(product8, 1'b0, clk, write_Enable, product9);
	register delToMatch9(product9, 1'b0, clk, write_Enable, product10);
	register delToMatch10(product10, 1'b0, clk, write_Enable, product11);
	register delToMatch11(product11, 1'b0, clk, write_Enable, product12);
	register delToMatch12(product12, 1'b0, clk, write_Enable, product13);
	register delToMatch13(product13, 1'b0, clk, write_Enable, product);
	
	my_dff overflowmult0(overflow0, 1'b0, clk, write_Enable, overflow1); 
	my_dff overflowmult1(overflow1, 1'b0, clk, write_Enable, overflow2); 
	my_dff overflowmult2(overflow2, 1'b0, clk, write_Enable, overflow3); 
	my_dff overflowmult3(overflow3, 1'b0, clk, write_Enable, overflow4); 
	my_dff overflowmult4(overflow4, 1'b0, clk, write_Enable, overflow5); 
	my_dff overflowmult5(overflow5, 1'b0, clk, write_Enable, overflow6); 
	my_dff overflowmult6(overflow6, 1'b0, clk, write_Enable, overflow7); 
	my_dff overflowmult7(overflow7, 1'b0, clk, write_Enable, overflow8); 
	my_dff overflowmult8(overflow8, 1'b0, clk, write_Enable, overflow9); 
	my_dff overflowmult9(overflow9, 1'b0, clk, write_Enable, overflow10); 
	my_dff overflowmult10(overflow10, 1'b0, clk, write_Enable, overflow11); 
	my_dff overflowmult11(overflow11, 1'b0, clk, write_Enable, overflow12); 
	my_dff overflowmult12(overflow12, 1'b0, clk, write_Enable, overflow13); 
	my_dff overflowmult13(overflow13, 1'b0, clk, write_Enable, cout3); 

	assign g32 = {32{1'b0}};
	assign notProduct = ~product;
	CLA comp3(notProduct, g32, 1'b1, compProduct, cout4);
	
	assign zer = (product[0] | product[1] | product[2] | product[3] |
				product[4] | product[5] | product[6] | product[7] |
				product[8] | product[9] | product[10] | product[11] |
				product[12] | product[13] | product[14] | product[15]);
	
	assign out = {32{((msbP32&(~msbC32))|(~msbP32&(msbC32)))}}&compProduct | 
		  {32{((msbP32&(msbC32))|(~msbP32&(~msbC32)))}}&product;
	assign overflow = zer&(((msbP32&(~msbC32))|(~msbP32&(msbC32)))&cout4) | 
		       ((msbP32&(msbC32))|(~msbP32&(~msbC32)))&cout3; 
	     
endmodule

////A register with 16parallel [1-b] D-F/Fs for CSA carry ins, can be modified through parameterization
module register2(d, aclr, clk, write_Enable, out);
		parameter k = 15;
		input clk, write_Enable, aclr;
		input [k:0] d;
		output [k:0] out;
		wire [k:0] x;
		genvar i;
	 generate
		for (i = 0; i <= k; i = i + 1) begin: myblock
				my_dff dFF16(d[i], aclr, clk, write_Enable, x[i]) ;
				assign out[i] = x[i];
		end 
	 endgenerate

endmodule


//16 bit CSA
module CSA(a ,b,sIn, cIn, sOut, cOut);
	input [15:0] a,cIn;
	input [15:0] sIn;
	input b;
	output [15:0] cOut;
	output [15:0] sOut;
	wire ground;
	
	assign ground = 0;
	genvar i;
	
	generate
		for (i = 0; i < 15; i = i + 1) begin: loop
				modFullAdder add(a[i], b, sIn[i+1], cIn[i], sOut[i], cOut[i]);
		end 
	endgenerate
	modFullAdder add15(a[15], b, ground, cIn[15], sOut[15], cOut[15]);

endmodule

//16-bit CLA (modified from last hw)
module CLA2(a, b, cin, sum, cout);
	input [15:0] a, b;
	input cin;
	output [15:0] sum;
	output cout;
	wire [15:0] p, g;
	wire p0, p8, p16, p24, g0, g8, g16, g24;
	wire c8, c16;
	
	propGen8 pg1(a[7:0], b[7:0], p0, g0, p[7:0], g[7:0]);
	propGen8 pg2(a[15:8], b[15:8], p8, g8, p[15:8], g[15:8]);
//	propGen8 pg3(a[23:16], b[23:16], p16, g16, p[23:16], g[23:16]);
//	propGen8 pg4(a[31:24], b[31:24], p21, g24, p[31:24], g[31:24]);
	
	LCU2 look(p0,g0,p8,g8,cin,c8,c16);
	assign cout = c16;
	
	CLA8 b1 (a[7:0], b[7:0], p[7:0], g[7:0], cin, sum[7:0]);
	CLA8 b2(a[15:8], b[15:8],p[15:8], g[15:8], c8, sum[15:8]);

endmodule	

//16 bit lookahead carry unit (modified from last hw)
module LCU2(p0, g0, p8, g8, cin, C8, C16);
	input p0, g0, p8, g8, cin;
	output C8, C16;
	
	assign C8 = g0 | p0&cin;
	assign C16 = g8 | g0&p8 | cin&p0&p8;
endmodule


//modified from previous hw to include carry out modFullAdder
module modFullAdder(a, b, sIn, cIn, sOut, cOut);
	input a,b,sIn,cIn;
	output sOut, cOut; // sum and carry out
	wire x;
	assign x = a&b;
	assign sOut = x^sIn^cIn;
	assign cOut = x&sIn | (x|sIn)&cIn;
endmodule
