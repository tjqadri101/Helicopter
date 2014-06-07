module scoreCounter(clock, aclr, branchCtrl, collision, hex4, hex3, hex2, hex1);//, counterOut);
	input clock,aclr, branchCtrl, collision;
	output [6:0] hex1, hex2, hex3, hex4;
	wire coutCounterAdd, counterEnable;
	wire [31:0] counter, counter_next, consTen;
	//output [31:0] counterOut;
	
	assign counterEnable = branchCtrl & ~collision;
	assign consTen =  32'h1;
	CLA pcadd10(counter, consTen, 1'b0, counter_next,  coutCounterAdd);
	register counterReg(counter_next, aclr, clock, counterEnable, counter);
//
//	SSD ssd1(counter[3:0], hex1);
//	SSD ssd2(counter[7:4], hex2);
//	SSD ssd3(counter[11:8], hex3);
//	SSD ssd4(counter[15:12],  hex4);
	Hexadecimal_To_Seven_Segment ssd1(counter[3:0], hex1);
	Hexadecimal_To_Seven_Segment ssd2(counter[7:4], hex2);
	Hexadecimal_To_Seven_Segment ssd3(counter[11:8], hex3);
	Hexadecimal_To_Seven_Segment ssd4(counter[15:12], hex4);
	//assign counterOut = counter;


endmodule