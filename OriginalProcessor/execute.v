module execute(aclr, clock, data_readAIn, data_readBIn, immediateIn, RDIn, ALUopIn, shiftamtIn, pcExIn, 
		jrOpIn, bOpIn, jalOpIn, aluSrcIn, memWrIn, regWrIn, jump_InEx, m2RegIn, branchExOut, lthOut, neOut,
		brAddRes1, alu_result1, jal_jr1, jal_jrExClr,jalJrAddr1, RdExOut1, RData2, memWrEx, regWrEx, m2RegEx, pcExout, jalEx,
		M_W_data, aluACtrl, aluBCtrl, loadIn, loadOu, storeIn, storeOu, bOp_2,bOp_2Ou, FDRS1, FDRS2);

input [4:0] RDIn,ALUopIn,shiftamtIn, FDRS1, FDRS2;
input [31:0] data_readAIn, data_readBIn, immediateIn, pcExIn, jump_InEx, M_W_data ;
input jrOpIn, bOpIn, jalOpIn, aluSrcIn, memWrIn, regWrIn, m2RegIn, aclr, clock, loadIn, storeIn, bOp_2;
input [2:0] aluACtrl, aluBCtrl;
wire[31:0] bIn, alu_result, brAddRes, X_M_data, data_ALUaIN, data_readBIn2, data_result, 
			ALUopdecoded, alu_resultF, data_result1, data_result2, alu_resultF1;
wire [4:0] const0, aluCtrlIn;
wire[1:0] jalJR;
wire[16:0] remain;
wire isNotEqual, isLessThan, brinAdd, coutbAdd, ex_always_Enable, jal_jrDelayed, jal_jrCur, data_exception, ctrl_MULT, ctrl_DIV,data_resultRDY;
output branchExOut, lthOut, neOut, memWrEx, regWrEx, m2RegEx, jal_jrExClr, jal_jr1, jalEx, loadOu, storeOu,bOp_2Ou;
output[31:0] RData2, jalJrAddr1, brAddRes1, alu_result1, pcExout;
output[4:0] RdExOut1;

my_dff loadEXFF(loadIn, aclr, clock, ex_always_Enable, loadOu);
my_dff storeExFF(storeIn, aclr, clock, ex_always_Enable, storeOu);


register pcExoutReg(pcExIn, aclr, clock, ex_always_Enable, pcExout);
my_dff jalExFF(jalOpIn, aclr, clock, ex_always_Enable, jalEx);
my_dff memWrExFF(memWrIn, aclr, clock, ex_always_Enable, memWrEx);
my_dff regWrExFF(regWrIn, aclr, clock, ex_always_Enable, regWrEx);
my_dff m2RegExFF(m2RegIn, aclr, clock, ex_always_Enable, m2RegEx);

assign const0 = 5'd0;
assign ex_always_Enable = 1'b1;
assign brinAdd = 1'b0;
assign jal_jrCur = jrOpIn | jalOpIn;
//my_dff regdelayJFF(jal_jrCur, aclr, clock, ex_always_Enable, jal_jrDelayed);
assign jal_jr1 = jal_jrCur;
assign jal_jrExClr = jal_jrCur;// | jal_jrDelayed;

assign jalJR[1] = jrOpIn;
assign jalJR[0] = jalOpIn;

//assign branchCtrl = bOpIn & (isNotEqual | ~isLessThan); 
my_dff regBrExFF(bOpIn, aclr, clock, ex_always_Enable, branchExOut);
my_dff regBrExFF2(bOp_2, aclr, clock, ex_always_Enable, bOp_2Ou);
my_dff neOutExFF(isNotEqual, aclr, clock, ex_always_Enable, neOut);
my_dff lthOutExFF(isLessThan, aclr, clock, ex_always_Enable, lthOut);

Mux3 #(32) rs2Sel(data_readBIn, M_W_data, X_M_data, aluBCtrl, data_readBIn2);

Mux2bin #(32) dataBMux(data_readBIn2, immediateIn, aluSrcIn, bIn);
Mux2bin #(5) aluCtrlMux(ALUopIn, const0, aluSrcIn, aluCtrlIn);
Dec5to32 ALUOpdec1(ALUopIn, ALUopdecoded); 
assign ctrl_MULT = ALUopdecoded[6]; 
assign ctrl_DIV = ALUopdecoded[7];

Mux3 #(32) rs1Sel(data_readAIn, M_W_data, X_M_data, aluACtrl, data_ALUaIN);

ALU execALU(data_ALUaIN, bIn, aluCtrlIn, shiftamtIn, alu_result, isNotEqual, isLessThan);
register execALUReg(alu_resultF, aclr, clock, ex_always_Enable, X_M_data);
assign alu_result1  = X_M_data;
register RData2Reg(data_readBIn, aclr, clock, ex_always_Enable, RData2);
register2 #(5) rdregEx(RDIn, aclr, clock, ex_always_Enable, RdExOut1);

CLA branchadd(pcExIn, immediateIn, brinAdd, brAddRes, coutbAdd);
register branchValExReg(brAddRes, aclr, clock, ex_always_Enable, brAddRes1);

Mux2b #(32) jaljrMux(data_readBIn2, jump_InEx, jalJR, jalJrAddr1);

//processMulDiv mulDivA1(FDRS1, FDRS2, RDIn, RdExOut1, data_ALUaIN, data_readBIn2, 1'b0, 1'b0, clock, data_result, data_exception, stall, data_resultRDY);
Mux2bin #(32) mulALuMux1(alu_result, data_result1, ctrl_DIV, alu_resultF1);
Mux2bin #(32) mulALuMux2(alu_resultF1, data_result2, ctrl_MULT, alu_resultF);
lpm_divide0 dividLPM1(data_readBIn2[15:0],data_ALUaIN, data_result1, remain);
lpm_mult1 mulLPM1(data_readBIn2,data_ALUaIN, data_result2);

endmodule



// 2:1 binary select multiplexer(arbitrary width)
module Mux2bin(a0, a1, s, b);
	parameter k = 1;
	input [k-1:0] a0, a1; //inputs
	input  s; 
	output [k-1:0] b;
	
	assign b = ({k{s}} & a1) | ({k{~s}} & a0);
endmodule