module memory(bMemIn,isNEqual, isLThan, aclr, clock,memWrMemIn, ALUResultIn, RDataIn, RdMemIn, brAddResMemIn,pcMemIn,
		jalMemIn, regWrMemIn, m2RegMemIn, branchCtrl, data_ReadOutMem, rdMemOut, regWrMemOut, m2RegMemOut, ALUResultOut, brAddResMemOut,
				pcMemout, jalMemout, MemDataSel, wb_Data, bOp_2Ou, playLeds,branchCtrl5Ou, row1LedOut,PB1, PB2);//, branchClr);
input bMemIn,isNEqual, isLThan, clock, memWrMemIn, aclr, regWrMemIn, m2RegMemIn, jalMemIn, bOp_2Ou;
input[31:0] RDataIn, ALUResultIn, brAddResMemIn,pcMemIn, wb_Data;
input [4:0] RdMemIn;
input MemDataSel, PB1, PB2;
output branchCtrl, regWrMemOut, m2RegMemOut, jalMemout, branchCtrl5Ou;
output [31:0] data_ReadOutMem, ALUResultOut, brAddResMemOut, pcMemout, playLeds, row1LedOut;
output[4:0] rdMemOut;
wire[4:0] rdMemOut1;
wire[31:0]  data_ReadOut, ALUResultOut1, pcMemout1, RDataIn1,playLedA, playLedB, row1Led;
wire regWrMemOut1, m2RegMemOut1,jalMemout1, branch_cur, ledR1Sel, row1LedWriteEn, branchCtrl1, branchCtrl2, branchCtrl3, branchCtrl4,
			branchCtrl5, branchCtrl6, ledR1Wr;

assign brAddResMemOut = brAddResMemIn;
assign branchCtrl1 = (bMemIn & (isNEqual))  | (bOp_2Ou & (~isLThan & isNEqual)); 
assign branchCtrl = branchCtrl1 ;
//assign branchCtrl6 = cOut2Det;
//my_dff colFF1(branchCtrl6, aclr, clock, 1'b1, colDet);

my_dff br2MFF1(branchCtrl1, aclr, clock, 1'b1, branchCtrl2);
my_dff br3MFF1(branchCtrl2, aclr, clock, 1'b1, branchCtrl3);
my_dff br4MFF1(branchCtrl3, aclr, clock, 1'b1, branchCtrl4);
my_dff br5MFF1(branchCtrl4, aclr, clock, 1'b1, branchCtrl5);
assign branchCtrl5Ou = branchCtrl5;

//my_dff brMemClrFF1(branch_cur, aclr, clock, 1'b1, branchClr);
//assign branchCtrl = branch_cur;
//assign branchClr = branch_cur;
register pcMemoutReg1(pcMemIn, aclr, clock, 1'b1, pcMemout);
my_dff jalMemFF1(jalMemIn, aclr, clock, 1'b1, jalMemout);
//register pcMemoutReg2(pcMemout1, aclr, clock, 1'b1, pcMemout);
//my_dff jalMemFF2(jalMemout1, aclr, clock, 1'b1, jalMemout);
Mux2bin #(32) dmemDataSel(RDataIn, wb_Data, MemDataSel, RDataIn1);
dmem dataMem(ALUResultIn,~clock, RDataIn1, memWrMemIn, data_ReadOut);
register dataMemorReg(data_ReadOut, aclr, clock,1'b1, data_ReadOutMem);


register2 #(5) rdregMemory1(RdMemIn, aclr, clock, 1'b1, rdMemOut);
//register2 #(5) rdregMemory2(rdMemOut1, aclr, clock, 1'b1, rdMemOut);

my_dff WrMemInFF1(regWrMemIn, aclr, clock, 1'b1, regWrMemOut);
//my_dff WrMemInFF2(regWrMemOut1, aclr, clock, 1'b1, regWrMemOut);

my_dff m2RegMemInFF1(m2RegMemIn, aclr, clock, 1'b1,m2RegMemOut);
//my_dff mwRegMemInFF2(m2RegMemOut1, aclr, clock, 1'b1, m2RegMemOut);

register ALUMemReg1(ALUResultIn, aclr, clock,1'b1, ALUResultOut);
//register ALUMemReg2(ALUResultOut1, aclr, clock,1'b1, ALUResultOut);

assign ledR1Sel = RdMemIn[0] & (~RdMemIn[1]) & (~RdMemIn[2]) & (~RdMemIn[3]) & (~RdMemIn[4]);
assign ledR1Wr =  ledR1Sel & regWrMemIn;
register playLedReg(ALUResultIn, aclr, clock,ledR1Wr, playLeds);

assign row1Led = ALUResultIn & {32{regWrMemIn}};// & {32{~jalMemIn}} & ~(PB1 & PB2) & {32{~ledR1Sel}};
register row1LedReg(row1Led, aclr, clock, branchCtrl5 & (~(PB1 | PB2)), row1LedOut);


endmodule