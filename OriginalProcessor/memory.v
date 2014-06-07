module memory(bMemIn,isNEqual, isLThan, aclr, clock,memWrMemIn, ALUResultIn, RDataIn, RdMemIn, brAddResMemIn,pcMemIn, jalMemIn,
				regWrMemIn, m2RegMemIn, branchCtrl, data_ReadOutMem, rdMemOut, regWrMemOut, m2RegMemOut, ALUResultOut, brAddResMemOut,
				pcMemout, jalMemout, MemDataSel, wb_Data, bOp_2Ou);//, branchClr);
input bMemIn,isNEqual, isLThan, clock, memWrMemIn, aclr, regWrMemIn, m2RegMemIn, jalMemIn, bOp_2Ou;
input[31:0] RDataIn, ALUResultIn, brAddResMemIn,pcMemIn, wb_Data;
input [4:0] RdMemIn;
input MemDataSel;
output branchCtrl, regWrMemOut, m2RegMemOut, jalMemout;
output [31:0] data_ReadOutMem, ALUResultOut, brAddResMemOut, pcMemout;
output[4:0] rdMemOut;
wire[4:0] rdMemOut1;
wire[31:0]  data_ReadOut, ALUResultOut1, pcMemout1, RDataIn1;
wire regWrMemOut1, m2RegMemOut1,jalMemout1, branch_cur;

assign brAddResMemOut = brAddResMemIn;
assign branchCtrl = bMemIn & (isNEqual)  | bOp_2Ou & (~isLThan & isNEqual); 
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

endmodule