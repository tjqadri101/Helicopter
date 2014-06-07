module decode(PB1In, PB2In,highFD1, highFD2, ins_in, pc_in, jump_in, clock, ctrl_writeEnable, aclr1, wb_writeReg, 
				 wbdata_writeReg, data_readA, data_readB, immediateOut, RD, ALUop, shiftamt, pcDecOut,
				jrOp, bOp, jalOp, aluSrc,memWr, regWr, jump_Out, m2Reg, aclr2, rs1DX, rs2DX, load, loadOut, store, storeOut,
				rs1FD, rs2FD, stallA, bOp_2, PBOF1, PBOF2);

input [31:0] ins_in, pc_in, jump_in,wbdata_writeReg;
input clock, ctrl_writeEnable, aclr2, aclr1,highFD1, highFD2, stallA, PB1In, PB2In;
input [4:0] wb_writeReg;
wire [4:0] ctrl_readRegB, stl2; //RD1, shiftamt1, ALUop1,
wire [1:0] rt_rd1;
output [4:0] RD,ALUop,shiftamt, rs1DX, rs2DX, rs1FD, rs2FD;
output [31:0] data_readA, data_readB, immediateOut, pcDecOut, jump_Out;
output jrOp, bOp, jalOp, aluSrc, memWr, regWr, m2Reg, load, loadOut, store, storeOut, bOp_2, PBOF1, PBOF2;
wire [31:0] data_readRegA, data_readRegB, data_readRegA1, data_readRegB1,immediate, decInsout, stallHigh;//, immediateOut1, pcDecOut1, ;
wire always_Enable, jrOp1, m2Reg1, bOp1, jalOp1, aluSrc1, memWr1, regWr1, rt_rd, bOp2; //always_enable,
wire custb1;
//wire jrOp2, jOp2, bOp2, jalOp2, aluSrc2, addOp2, memRd2, memWr2, regWr2, rt_rd;

wire aclr;

assign aclr = aclr2 | aclr1;

genvar i, j;

generate
		for(i =0; i <= 31; i =i+1) begin: stalldecblock
			assign stallHigh[i] = ~stallA;
		end		
endgenerate


			assign stl2[0] = ~stallA;
			assign stl2[1] = ~stallA;
			assign stl2[2] = ~stallA;
			assign stl2[3] = ~stallA;
	assign stl2[4] = ~stallA;
assign always_Enable = 1'b1;
//assign always_enable = 1'b1;
//assign cons31 = 5'd31;
//
//Dec2 decodeWreg(wb_jalIn, wb_jalIn1);
//Mux2b #(5) muxWreg(cons31, wb_writeReg, wb_jalIn1, ctrl_writeReg);
//Mux2b #(32) muxDataWreg(wb_pcOne, wbdata_writeReg, wb_jalIn1, data_writeReg);
Dec2 decodeRtRd(rt_rd, rt_rd1);
Mux2b #(5) muxRtRd(ins_in[26:22], ins_in[16:12], rt_rd1, ctrl_readRegB);

regFile decodeStage(clock, ctrl_writeEnable, aclr1, wb_writeReg, ins_in[21:17], 
					ctrl_readRegB, wbdata_writeReg, data_readRegA, data_readRegB);
Mux2bin #(32) FDdAmux(data_readRegA,wbdata_writeReg, highFD1,data_readRegA1);	
Mux2bin #(32) FDdBmux(data_readRegB,wbdata_writeReg, highFD2,data_readRegB1);				

//assign data_readA = data_readRegA;
//assign data_readB = data_readRegB;
register dataAReg(stallHigh & data_readRegA1, aclr, clock, always_Enable, data_readA);
register dataBReg(stallHigh & data_readRegB1, aclr, clock, always_Enable, data_readB);
register pcdecReg(stallHigh & pc_in, aclr, clock, always_Enable, pcDecOut);
register jumpDecReg(stallHigh & jump_in, aclr, clock, always_Enable, jump_Out);
//assign pcDecOut = pcDecOut1;
//register pcdec1Reg(pcDecOut1, aclr, clock, always_Enable, pcDecOut);

assign immediate[16:0] = ins_in[16:0];
assign immediate[31:17] = {15{ins_in[16]}};
register immediateReg(immediate, aclr, clock, always_Enable, immediateOut);
//register immediate1Reg(immediateOut1, aclr, clock, always_enable, immediateOut);
register2 #(5) rdreg(ins_in[26:22] & {5{(~stallA & ~bOp2 & ~bOp1 & ~jrOp1)}}, aclr, clock, always_Enable, RD);
register2 #(5) rdreg1(ctrl_readRegB, aclr, clock, always_Enable, rs2DX);
register2 #(5) rdreg2(ins_in[21:17], aclr, clock, always_Enable, rs1DX);
assign rs1FD = ins_in[21:17];
assign rs2FD = ctrl_readRegB;
//register2 #(5) rd1reg(RD1, aclr, clock, always_Enable, RD);
register2 #(5) alureg(stl2 & ins_in[6:2], aclr, clock, always_Enable, ALUop);
//register2 #(5) alu1reg(ALUop1, aclr, clock, always_Enable, ALUop);
register2 #(5) shiftamtreg(stl2 & ins_in[11:7], aclr, clock, always_Enable, shiftamt);
//register2 #(5) shiftamt1reg(shiftamt1, aclr, clock, always_Enable, shiftamt);

Dec5to32 decInstruc(ins_in[31:27],decInsout);
assign load = ~ins_in[27] & ~ins_in[28] & ~ins_in[29] & ins_in[30] & ~ins_in[31];
my_dff loadDCFF(load, aclr, clock, always_Enable, loadOut);
assign store = ins_in[27] & ins_in[28] & ins_in[29] & ~ins_in[30] & ~ins_in[31];
my_dff storeDCFF(store, aclr, clock, always_Enable, storeOut);

assign jrOp1 = decInsout[4];
assign m2Reg1 = decInsout[8];
assign bOp1 = decInsout[2];
assign bOp2 = decInsout[6];
assign jalOp1 = decInsout[3];
assign aluSrc1 = decInsout[5] | decInsout[7] | decInsout[8];
//assign addOp1 = decInsout[5] | decInsout[7] | decInsout[8];
assign memWr1 = decInsout[7];
assign regWr1 = decInsout[0] | decInsout[3] | decInsout[5] | decInsout[8];
assign rt_rd = decInsout[2] | decInsout[4] | decInsout[6] | decInsout[7];


my_dff jr1ff(~stallA & jrOp1, aclr, clock, always_Enable, jrOp);
//my_dff jr2ff(jrOp2, aclr, clock, always_Enable, jrOp);

my_dff jreg1ff(~stallA & m2Reg1, aclr, clock, always_Enable, m2Reg);
//my_dff jreg2ff(jOp2, aclr, clock, always_Enable, jOp);

my_dff br1ff(~stallA & bOp1, aclr, clock, always_Enable, bOp);
my_dff br2ff(~stallA & bOp2, aclr, clock, always_Enable, bOp_2);

my_dff jal1ff(~stallA & jalOp1, aclr, clock, always_Enable, jalOp);
//my_dff jal2ff(jalOp2, aclr, clock, always_Enable, jalOp);

my_dff aluS1ff(~stallA & aluSrc1, aclr, clock, always_Enable, aluSrc);
//my_dff aluS2ff(aluSrc2, aclr, clock, always_Enable, aluSrc);

//my_dff addO1ff(addOp1, aclr, clock, always_Enable, addOp);
//my_dff addO2ff(addOp2, aclr, clock, always_Enable, addOp);

//my_dff memR1ff(memRd1, aclr, clock, always_Enable, memRd);
//my_dff memR2ff(memRd2, aclr, clock, always_Enable, memRd);

my_dff memW1ff(~stallA & memWr1, aclr, clock, always_Enable, memWr);
//my_dff memW2ff(memWr2, aclr, clock, always_Enable, memWr);

my_dff regW1ff(~stallA & regWr1, aclr, clock, always_Enable, regWr);
//my_dff regW2ff(regWr2, aclr, clock, always_Enable, regWr);

my_dff PB1Fff(PB1In, aclr, clock, always_Enable, PBOF1);
my_dff PB2Fff(PB2In, aclr, clock, always_Enable, PBOF2);


endmodule