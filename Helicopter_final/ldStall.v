module ldStall(D_X_ld, F_D_st, X_M_ld, D_X_st, D_X_RD, X_M_RD, F_D_RS1, F_D_RS2, D_X_RS1, D_X_RS2, stall1, stall2);
input [4:0] D_X_RD, X_M_RD, F_D_RS1, F_D_RS2, D_X_RS1, D_X_RS2;
input D_X_ld, F_D_st, X_M_ld, D_X_st;
output stall1, stall2;
wire high1, high2, high3, cinSub, coutSub, coutSubC, coutSub2, coutSubB2, high12, high22, high32, rs10, rs20, rs30, rs40;
wire [31:0] a, b, negA, negB, rs1, rs2, rs3, rs4, subA, subB, suba, subb, suba2, subb2,subC, subA2, subB2;

	//assign stCase1 = l_high & 
	assign cinSub = 1'b1;
	
	
	assign a[31:5] = {27{1'b0}};
	assign b[31:5] = {27{1'b0}};
	assign rs1[31:5] = {27{1'b0}};
	assign rs2[31:5] = {27{1'b0}};
	assign rs3[31:5] = {27{1'b0}};
	assign rs4[31:5] = {27{1'b0}};
	
	assign a[4:0] = D_X_RD;
	assign b[4:0] = X_M_RD;
	assign rs1[4:0] = F_D_RS1;
	assign rs2[4:0] = F_D_RS2;
	assign rs3[4:0] = D_X_RS1;
	assign rs4[4:0] = D_X_RS2;
	
   
   assign negA = ~a;
   assign negB = ~b;
   
   assign rs10 = a[4] | a[3] | a[2] | a[1] | a[0];
   assign rs20 = rs10; //rs2[4] | rs2[3] | rs2[2] | rs2[1] | rs2[0];
   assign rs30 = b[4] | b[3] | b[2] | b[1] | b[0];
   assign rs40 = rs30; //rs4[4] | rs4[3] | rs4[2] | rs4[1] | rs4[0];

   
   CLA subACLA1(rs1, negA, cinSub, subA, coutSub);
   CLA subACLA3(rs3, negB, cinSub, suba, coutSubC);
   //CLA subBCLA1(rs1, negB, cinSub, subB, coutSubB);
   //CLA subCCLA1(a, negB, cinSub, subC, coutSubC);
	
	assign high1 = rs10 & (~(subA[31] | subA[30] | subA[29] | subA[28] | subA[27] | subA[26] | subA[25] | subA[24] | subA[23] | subA[22] |
						subA[21] | subA[20] | subA[19] | subA[18] | subA[17] | subA[16] | subA[15] | subA[14] | subA[13] | subA[12] |
						subA[11] | subA[10] | subA[9] | subA[8] | subA[7] | subA[6] | subA[5] | subA[4] | subA[3] | subA[2] | subA[1] | subA[0]));

	assign high2 = rs30 & (~(suba[31] | suba[30] | suba[29] | suba[28] | suba[27] | suba[26] | suba[25] | suba[24] | suba[23] | suba[22] |
						suba[21] | suba[20] | suba[19] | suba[18] | suba[17] | suba[16] | suba[15] | suba[14] | suba[13] | suba[12] |
						suba[11] | suba[10] | suba[9] | suba[8] | suba[7] | suba[6] | suba[5] | suba[4] | suba[3] | suba[2] | suba[1] | suba[0]));
	//assign high3 = (~high1)&(~high2);
	
	CLA subA2CLA1(rs2, negA, cinSub, subA2, coutSub2);
    CLA subB2CLA2(rs4, negB, cinSub, subB2, coutSubB2);
	
	assign high12 = rs20 & (~(subA2[31] | subA2[30] | subA2[29] | subA2[28] | subA2[27] | subA2[26] | subA2[25] | subA2[24] | subA2[23] | subA2[22] |
						subA2[21] | subA2[20] | subA2[19] | subA2[18] | subA2[17] | subA2[16] | subA2[15] | subA2[14] | subA2[13] | subA2[12] |
						subA2[11] | subA2[10] | subA2[9] | subA2[8] | subA2[7] | subA2[6] | subA2[5] | subA2[4] | subA2[3] | subA2[2] | subA2[1] | subA2[0]));

	assign high22 = rs40 & (~(subB2[31] | subB2[30] | subB2[29] | subB2[28] | subB2[27] | subB2[26] | subB2[25] | subB2[24] | subB2[23] | subB2[22] |
						subB2[21] | subB2[20] | subB2[19] | subB2[18] | subB2[17] | subB2[16] | subB2[15] | subB2[14] | subB2[13] | subB2[12] |
						subB2[11] | subB2[10] | subB2[9] | subB2[8] | subB2[7] | subB2[6] | subB2[5] | subB2[4] | subB2[3] | subB2[2] | subB2[1] | subB2[0]));
	//assign high32 = (~high12)&(~high22);
	
	assign stall1 = D_X_ld & (high1 | high12) & !F_D_st;
	assign stall2 = X_M_ld & (high2 | high22) & !D_X_st;
	
endmodule	