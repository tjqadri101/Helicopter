//Linear shift register with output of size 32 where upper 26 bits are always low. Only lower 6 bits are shifter
module shiftRegister(aclr, clk, write_Enable, out);
		input clk, write_Enable, aclr;
		//input [31:0] d;
		output [31:0] out;
		wire [5:0] x, y;
		wire linear_feedback, reset, zero;
		genvar i;
	//assign zero = ~(d[5] | d[4] | d[3] | d[2] | d[1] | d[0]);	
	assign linear_feedback =  (~(x[5] ^ x[0])); //& (zero)) | ((~(d[5] ^ d[0])) & (~zero));
	assign reset = x[5] & x[4] & x[3] & x[2] & x[1] & x[0];
	 generate
		for (i = 1; i <= 5; i = i + 1) begin: myblock
				my_dff dFF6(x[i-1], aclr | reset, clk , write_Enable, x[i]) ;
				assign out[i] = x[i];
		end 
	 endgenerate
			my_dff dFF62(linear_feedback, aclr, clk, write_Enable, x[0]);
			assign out[0] = x[0];
			
	assign out[31:6] = {26{1'b0}};		
endmodule
