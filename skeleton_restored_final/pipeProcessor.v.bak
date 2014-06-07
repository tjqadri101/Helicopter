module pipeProcessor(PB1, PB2, aclr, clock, pc_one1, instruction, FinalWr, FINAL,	RD_DEST, PC_Final, 
						fdCheck1, fdCheck2, stallCheck, playLedsOut, row1LedsOut, row2LedsOut, row3LedsOut, row4LedsOut,
						 collisionDetected, bOutFinal,  hex1, hex2, hex3, hex4);//, counterOut);

input aclr, clock, PB1, PB2;
output 	[31:0] 	pc_one1, instruction, FINAL, PC_Final;//, counterOut;
output [4:0] RD_DEST; 
output [5:0] playLedsOut, row1LedsOut, row2LedsOut, row3LedsOut, row4LedsOut;
output [6:0] hex1, hex2, hex3, hex4;
wire [31:0] row1Leds, playLeds, row2Leds, row3Leds, row4Leds;
output FinalWr, fdCheck1, fdCheck2, stallCheck, collisionDetected, bOutFinal ;
wire branchCtrl, jal_jr1,reg_WBack, jrOp, bOp, jalOp, aluSrc,memWr, regWr, m2Reg, branchExOut, lthOut, neOut, memWrEx, regWrEx, m2RegEx,
	jalEx,regWrMemOut, m2RegMemOut, jalMemout, jal_jrExClr, brClrMem, dataMemCtrl, loadCur, loadOut, storeCur,
	storeOut,  loadOu, storeOu, stall1, stall2, highFD1, highFD2, stall_1, stallB, bOp_2,bOp_2Ou, 
	stallMul, stallMulInc, PB1Out, PB2Out, PB1, PB2, PBOF1, PBOF2, PB1EO, PB2EO, custbOp, custbOpOu, colOut, branchCtrl4, cOut2Det;			
wire[31:0] brAddResMemOut, jalJrAddr1, insOut, pcOut, jOut, pcCur, data_WBack, data_readA, data_readB, immediateOut,pcDecOut, jump_Out,
			brAddRes1, alu_result1, RData2, pcExout, data_ReadOutMem, ALUResultOut, pcMemout;
wire[4:0] rd_WBack, RD, ALUop, shiftamt,RdExOut1, rdMemOut, D_X_RS1, D_X_RS2, rs1FD, rs2FD;
wire [2:0] aluActrl, aluBctrl; 
wire cons1, collisionDetected1, collisionDetected2, gameOver, collis2, collisionDetected3;
	
	assign cons1 = 1'b1;
	my_dff collisff(cons1, aclr, clock,  collisionDetected1 , collis2);


fetch fetchStageMod(PB1, PB2, clock, branchCtrl, jal_jr1, jal_jrExClr, aclr, brAddResMemOut, jalJrAddr1, 
					insOut, pcOut, jOut, stallMulInc, stall2, PB1Out, PB2Out);

decode decodeStageMod(PB1Out, PB2Out, highFD1, highFD2, insOut, pcOut, jOut, clock, reg_WBack, aclr, rd_WBack, 
						data_WBack, data_readA, data_readB, immediateOut, RD, ALUop, shiftamt, pcDecOut,
						jrOp, bOp, jalOp, aluSrc,memWr, regWr, jump_Out, m2Reg, branchCtrl, D_X_RS1, D_X_RS2,
						loadCur, loadOut, storeCur, storeOut, rs1FD, rs2FD, stall1, bOp_2, PBOF1, PBOF2);

execute executeStageMod(PBOF1, PBOF2, aclr, clock, data_readA, data_readB, immediateOut, RD, ALUop, shiftamt, pcDecOut, 
		jrOp, bOp, jalOp, aluSrc,memWr, regWr, jump_Out, m2Reg, branchExOut, lthOut, neOut,
		brAddRes1, alu_result1, jal_jr1,jal_jrExClr, jalJrAddr1, RdExOut1, RData2, memWrEx, regWrEx, m2RegEx, pcExout, jalEx,
		data_WBack, aluActrl, aluBctrl, loadOut, loadOu, storeOut, storeOu, bOp_2,bOp_2Ou, rs1FD, rs2FD, PB1EO, PB2EO, playLeds);	
		

	
memory memoryStageMod( branchExOut,neOut, lthOut, aclr, clock,memWrEx, alu_result1, RData2, RdExOut1, brAddRes1,pcExout, jalEx,
				regWrEx, m2RegEx, branchCtrl, data_ReadOutMem, rdMemOut, regWrMemOut, m2RegMemOut, ALUResultOut, brAddResMemOut,
				pcMemout, jalMemout, dataMemCtrl, data_WBack, bOp_2Ou, playLeds, branchCtrl4, row1Leds,  PB1EO, PB2EO);	
assign playLedsOut = playLeds[5:0];				
assign row1LedsOut = 	row1Leds[5:0];// & {6{~(custbOpOu &colOut)}};	
assign bOutFinal = 	branchCtrl4;	
write_back wbStageMod(pcMemout, jalMemout, aclr, clock, data_ReadOutMem, rdMemOut, regWrMemOut, 
					m2RegMemOut,  ALUResultOut,data_WBack, rd_WBack, reg_WBack);	

bypassCtrl byProcCtrl(loadOu,  storeOut, rs1FD,rs2FD, D_X_RS1, D_X_RS2, RdExOut1, rd_WBack, aluActrl,
						aluBctrl, dataMemCtrl, highFD1, highFD2);

ldStall ldStall1(loadOut, storeCur, loadOu, storeOut, RD, RdExOut1, rs1FD,rs2FD, D_X_RS1, D_X_RS2, stall_1, stall2);
my_dff stBff(stall_1, aclr, clock, 1'b1, stallB);

//my_dff colBff(custbOpOu & colOut, aclr, clock, 1'b1, collisionDetected1);
//my_dff colFinalFF(cons1, aclr, clock, collisionDetected1, collisionDetected2);
//assign collisionDetected = cOut2Det;//collisionDetected1;// | cOut2Det;// | collisionDetected2;
//assign collisionDetected = gameOver;

LedMatrixRegister matrixReg(branchCtrl4, clock, aclr, playLeds, row1Leds, row2Leds, row3Leds, row4Leds);
assign collisionDetected1 =  ((playLeds[5] & row4Leds[5]) | (playLeds[4] & row4Leds[4]) | (playLeds[3] & row4Leds[3]) | (playLeds[2] & row4Leds[2])|
					(playLeds[1] & row4Leds[1]) | (playLeds[0] & row4Leds[0]));
assign collisionDetected3 = 	collisionDetected1 | collis2;	
assign collisionDetected = collisionDetected3;

scoreCounter ca1(clock, aclr, branchCtrl4, collisionDetected3, hex1, hex2, hex3, hex4);//, counterOut);
		

assign row2LedsOut = row2Leds[5:0];
assign row3LedsOut = row3Leds[5:0];
assign row4LedsOut = row4Leds[5:0];

assign stall1 = stall_1 | stall2;
assign stallMulInc =  stall_1;

assign pc_one1 = pcOut;
assign instruction = insOut; 		
assign FINAL = data_WBack;
assign RD_DEST = rd_WBack;
assign FinalWr = reg_WBack;	
assign PC_Final = pcMemout;	
assign fdCheck1 =highFD1; 
assign fdCheck2 = highFD2;
assign stallCheck =stallMulInc;							

endmodule