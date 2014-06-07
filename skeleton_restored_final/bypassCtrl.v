module bypassCtrl(ldMem, stEx, F_D_RS1, F_D_RS2, D_X_RS1, D_X_RS2, X_M_RD, M_W_RD, aluActrl, aluBctrl, dataMemCtrl, highFD1, highFD2);
input [4:0] D_X_RS1, D_X_RS2, X_M_RD, M_W_RD, F_D_RS1, F_D_RS2;
input ldMem, stEx;
output [2:0] aluActrl, aluBctrl;
output dataMemCtrl, highFD1, highFD2;
wire high1, high2, high3, cinSub, coutSub, coutSubB, coutSub3, coutSubB4,coutSubC, coutSub2, coutSubB2, high12, 
		high22, high32, rs10, rs20, a0;
wire [31:0] a, b, negA, negB, rs1, rs2, rs3, rs4, subA, subA3, subA4,subB, subC, subA2, subB2;


	assign cinSub = 1'b1;
	
	assign a[31:5] = {27{1'b0}};
	assign b[31:5] = {27{1'b0}};
	assign rs1[31:5] = {27{1'b0}};
	assign rs2[31:5] = {27{1'b0}};
	assign rs3[31:5] = {27{1'b0}};
	assign rs4[31:5] = {27{1'b0}};
	
	assign a[4:0] = X_M_RD;
	assign b[4:0] = M_W_RD;
	assign rs1[4:0] = D_X_RS1;
	assign rs2[4:0] = D_X_RS2;
    assign rs3[4:0] = F_D_RS1;
	assign rs4[4:0] = F_D_RS2;
   
   assign negA = ~a;
   assign negB = ~b;
   
   assign rs10 = a[4] | a[3] | a[2] | a[1] | a[0];
   assign rs20 = b[4] | b[3] | b[2] | b[1] | b[0];
   assign a0 = a[4] | a[3] | a[2] | a[1] | a[0];
   
   CLA subACLA(rs1, negA, cinSub, subA, coutSub);
   CLA subBCLA(rs1, negB, cinSub, subB, coutSubB);
   CLA subCCLA(a, negB, cinSub, subC, coutSubC);
	
	assign high1 = rs10 & (~(subA[31] | subA[30] | subA[29] | subA[28] | subA[27] | subA[26] | subA[25] | subA[24] | subA[23] | subA[22] |
						subA[21] | subA[20] | subA[19] | subA[18] | subA[17] | subA[16] | subA[15] | subA[14] | subA[13] | subA[12] |
						subA[11] | subA[10] | subA[9] | subA[8] | subA[7] | subA[6] | subA[5] | subA[4] | subA[3] | subA[2] | subA[1] | subA[0]));

	assign high2 = rs10 & (~(subB[31] | subB[30] | subB[29] | subB[28] | subB[27] | subB[26] | subB[25] | subB[24] | subB[23] | subB[22] |
						subB[21] | subB[20] | subB[19] | subB[18] | subB[17] | subB[16] | subB[15] | subB[14] | subB[13] | subB[12] |
						subB[11] | subB[10] | subB[9] | subB[8] | subB[7] | subB[6] | subB[5] | subB[4] | subB[3] | subB[2] | subB[1] | subB[0]));
	assign high3 = (~high1)&(~high2);
	
	assign aluActrl[2] =  high3;
	assign aluActrl[1] = (~ldMem | (ldMem & stEx)) & high2 & (~high1);
	assign aluActrl[0] = high1;
	
	assign dataMemCtrl = (a0 & (~(subC[31] | subC[30] | subC[29] | subC[28] | subC[27] | subC[26] | subC[25] | subC[24] | subC[23] | subC[22] |
						subC[21] | subC[20] | subC[19] | subC[18] | subC[17] | subC[16] | subC[15] | subC[14] | subC[13] | subC[12] |
						subC[11] | subC[10] | subC[9] | subC[8] | subC[7] | subC[6] | subC[5] | subC[4] | subC[3] | subC[2] | subC[1] | subC[0])));					

   CLA subA2CLA(rs2, negA, cinSub, subA2, coutSub2);
   CLA subB2CLA(rs2, negB, cinSub, subB2, coutSubB2);
	
	assign high12 = rs10 & (~(subA2[31] | subA2[30] | subA2[29] | subA2[28] | subA2[27] | subA2[26] | subA2[25] | subA2[24] | subA2[23] | subA2[22] |
						subA2[21] | subA2[20] | subA2[19] | subA2[18] | subA2[17] | subA2[16] | subA2[15] | subA2[14] | subA2[13] | subA2[12] |
						subA2[11] | subA2[10] | subA2[9] | subA2[8] | subA2[7] | subA2[6] | subA2[5] | subA2[4] | subA2[3] | subA2[2] | subA2[1] | subA2[0]));

	assign high22 = rs20 & (~(subB2[31] | subB2[30] | subB2[29] | subB2[28] | subB2[27] | subB2[26] | subB2[25] | subB2[24] | subB2[23] | subB2[22] |
						subB2[21] | subB2[20] | subB2[19] | subB2[18] | subB2[17] | subB2[16] | subB2[15] | subB2[14] | subB2[13] | subB2[12] |
						subB2[11] | subB2[10] | subB2[9] | subB2[8] | subB2[7] | subB2[6] | subB2[5] | subB2[4] | subB2[3] | subB2[2] | subB2[1] | subB2[0]));
	assign high32 = (~high12)&(~high22);
	
	assign aluBctrl[2] = high32;
	assign aluBctrl[1] = (~ldMem | (ldMem & stEx)) & high22 & (~high12);
	assign aluBctrl[0] = high12;
	
	CLA subACLA3(rs3, negB, cinSub, subA3, coutSub3);
	CLA subBCLA3(rs4, negB, cinSub, subA4, coutSubB4);
	assign highFD1 = (rs20 & (~(subA3[31] | subA3[30] | subA3[29] | subA3[28] | subA3[27] | subA3[26] | subA3[25] | subA3[24] | subA3[23] | subA3[22] |
						subA3[21] | subA3[20] | subA3[19] | subA3[18] | subA3[17] | subA3[16] | subA3[15] | subA3[14] | subA3[13] | subA3[12] |
						subA3[11] | subA3[10] | subA3[9] | subA3[8] | subA3[7] | subA3[6] | subA3[5] | subA3[4] | subA3[3] | subA3[2] | subA3[1] | subA3[0])));
	assign highFD2 = rs20 & (~(subA4[31] | subA4[30] | subA4[29] | subA4[28] | subA4[27] | subA4[26] | subA4[25] | subA4[24] | subA4[23] | subA4[22] |
						subA4[21] | subA4[20] | subA4[19] | subA4[18] | subA4[17] | subA4[16] | subA4[15] | subA4[14] | subA4[13] | subA4[12] |
						subA4[11] | subA4[10] | subA4[9] | subA4[8] | subA4[7] | subA4[6] | subA4[5] | subA4[4] | subA4[3] | subA4[2] | subA4[1] | subA4[0]));

	
endmodule