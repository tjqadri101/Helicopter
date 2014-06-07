module LedMatrixRegister(branchCtrl4, clock, aclr, playLeds, row1Leds, row2LedsA, row3LedsA, row4LedsA);
	input clock, aclr, branchCtrl4;
	input [31:0] row1Leds, playLeds;
	output [31:0] row2LedsA, row3LedsA, row4LedsA;
	//output colDet;
	wire [31:0] row2Leds, row3Leds, row4Leds, row1inter, row2inter, row3inter;
	wire notZero;
	
	
	register row2LedsReg(row1Leds, aclr, clock,branchCtrl4, row2Leds);
	assign row2LedsA = row2Leds;
	register row3LedsReg(row2Leds, aclr, clock,branchCtrl4, row3Leds);
	assign row3LedsA = row3Leds;
	register row4LedsReg(row3Leds, aclr, clock,branchCtrl4 , row4Leds);
	assign row4LedsA = row4Leds;
	//assign notZero = row4Leds[5] | row4Leds[4] | row4Leds[3] | row4Leds[2] | row4Leds[1] | row4Leds[0];
   
endmodule