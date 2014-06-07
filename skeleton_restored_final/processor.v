module processor(clock, reset, ps2_key_pressed, ps2_out, lcd_write, lcd_data, RD_DEST);

	input 			clock, reset, ps2_key_pressed;
	input 	[7:0]	ps2_out;
	output 			lcd_write;
	output 	[31:0] 	lcd_data;
	wire 	[31:0] 	pc_one1, instruction, PC_Final;
	output [4:0] RD_DEST; 
	wire fdCheck1, fdCheck2, stallCheck ;
	// your processor here
					
					
	pipeProcessor myProcessor(reset, clock, pc_one1, instruction, lcd_write, lcd_data, RD_DEST, PC_Final, fdCheck1, fdCheck2, stallCheck);				
 
endmodule
