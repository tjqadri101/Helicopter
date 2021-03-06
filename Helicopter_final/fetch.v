module fetch(PB1, PB2, clock, br, jal_jr, jal_jrClr, aclr, brVal, jal_jrVal, insOut, pcOut, jOut, stallA, stallB, PB1Out, PB2Out); 
	input PB1, PB2, clock, br, jal_jr, aclr, jal_jrClr, stallA, stallB;
	input [31:0] jal_jrVal, brVal;
	output [31:0] jOut, insOut, pcOut, PB1Out, PB2Out;
	wire [31:0] pc, pc_next, imem_out, pc_one, pcOut1,jumpTo, jumpToIn, jmuxOut, consOne, brmuxOut, pcA, pcB, zer, imem_outIn, 
				stallHigh, pc_oneIn ,pc_less, pcOut2, jOut2, insOut2, pbIns1, pbIns2, imem_outInA, pc_nextA;
	wire high_enable, pcinAdd, coutpcAdd,  jOp, stallClr,stallB1, coutpcAdd2, stallA1,  pbSel;
	wire [1:0] jsel, brsel, jal_jrSel;
	wire [2:0] insPbsel;
	
	//assign stallHigh = {32{~stallA}};
	assign stallA1 = stallA | stallB;
	assign stallClr = jal_jrClr | br | aclr;
	assign high_enable = 1'b1;
	assign consOne =  32'd1;
	assign zer = 32'd0;
	assign pcinAdd = 1'b0;
	assign pbSel = PB1 | PB2;
	register pcReg(pc_next, aclr, clock, high_enable, pc);
	imem insmem(pc,high_enable,~clock,imem_out);
	
//	Dec2 jdec(jOp, jsel);
//	Dec2 jal_jrdec(jal_jr, jal_jrSel);
//	Dec2 brdec(br, brsel);
	
//	Mux2b #(32) jmux(jumpTo, brmuxOut, jsel, jmuxOut);
//	Mux2b #(32) jal_jrmux(jal_jrVal, jmuxOut, jal_jrSel, pc_next);
//	Mux2b #(32) brmux(brVal, pc_one, brsel, brmuxOut);

	Mux2bin #(32) jmux(brmuxOut, jumpTo, jOp, jmuxOut);
	Mux2bin #(32) jal_jrmux(jmuxOut, jal_jrVal, jal_jr, pcA);
	Mux2bin #(32) brmux(pc_one,brVal,  br, brmuxOut);
	Mux2bin #(32) stalArmux(pcA, pc, stallA, pcB);
	
	Mux2bin #(32) stalBrmux(pcB, pc_less, stallB, pc_nextA);
	Mux2bin #(32) PBmux(pc_nextA, pc,  pbSel, pc_next);
	
	CLA pcadd(pc, consOne, pcinAdd, pc_one, coutpcAdd);
	CLA pcsub2(pc, ~consOne, 1'b1, pc_less, coutpcAdd2);
	assign jumpTo[26:0] = imem_out[26:0];
	assign jumpTo[31:27] = pc_one[31:27];
//	
	Mux2bin #(32) pcmux(pc_one,zer,  stallA1, pc_oneIn);
	Mux2bin #(32) jumprmux(jumpTo, zer, stallA1, jumpToIn);
	Mux2bin #(32) insmux(imem_out, zer,  stallA1, imem_outIn);
//	
	
	register pcoutReg(pc_oneIn, stallClr, clock, high_enable, pcOut2);
	//register pcout1Reg(pcOut1, aclr, clock, high_enable, pcOut);
	register joutReg(jumpToIn, stallClr, clock, high_enable, jOut2);
	register insoutReg(imem_outInA, stallClr, clock, high_enable, insOut2);
	assign pcOut = pcOut2; //& stallHigh;
	assign jOut = jOut2;// & stallHigh;
	
	assign insPbsel[2] = PB2;
	assign insPbsel[1] = PB1;
	assign insPbsel[0] = (~PB2) & (~PB1);
	
	assign pbIns1[31:27] = 5'b00000;
	assign pbIns1[26:22] = 5'b00001;
	assign pbIns1[21:17] = 5'b00001;
	assign pbIns1[16:12] = 5'b00000;
	assign pbIns1[11:7] = 5'b00001;
	assign pbIns1[6:2] = 5'b00101;
	assign pbIns1[1:0] = 2'b00;
	
	assign pbIns2[31:27] = 5'b00000;
	assign pbIns2[26:22] = 5'b00001;
	assign pbIns2[21:17] = 5'b00001;
	assign pbIns2[16:12] = 5'b00000;
	assign pbIns2[11:7] = 5'b00001;
	assign pbIns2[6:2] = 5'b00100;
	assign pbIns2[1:0] = 2'b00;
	
	my_dff PB1ff(PB1, aclr, clock, high_enable, PB1Out);
	my_dff PB21ff(PB2, aclr, clock, high_enable, PB2Out);
	
	Mux3 #(32) insSel(pbIns2, pbIns1, imem_outIn, insPbsel, imem_outInA);
	assign insOut = insOut2;// & stallHigh;
	
	assign jOp = imem_out[27] & ~imem_out[28] & ~imem_out[29] & ~imem_out[30]  & ~imem_out[31];
endmodule

