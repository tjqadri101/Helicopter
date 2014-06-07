 
// this is the register file
module regFile(clock, ctrl_writeEnable, ctrl_reset, ctrl_writeReg, ctrl_readRegA, ctrl_readRegB, data_writeReg, data_readRegA, data_readRegB);
   input clock, ctrl_writeEnable, ctrl_reset;
   input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
   input [31:0] data_writeReg;
   output [31:0] data_readRegA, data_readRegB;
   wire [31:0] decoded, enabled;
   wire [31:0] r31, r30, r29, r28, r27, r26, r25, r24, r23, r22,r21, r20, r19, r18, r17, r16, r15, r14, r13, r12; // register files
   wire [31:0] r11, r10, r9, r8, r7, r6, r5, r4, r3, r2, r1, r0; // register files
   genvar i;
   
   Dec5to32 dec1(.a(ctrl_writeReg), .b(decoded)); // one-hot decoding the control signal for writing register
   
   generate
		for(i =0; i <= 31; i =i+1) begin: decblock
			assign enabled[i] = decoded[i] & ctrl_writeEnable; //AND register write enable signal with 
		
		end													   // one-hot register number to right to by decoding ctrl_writeReg
   endgenerate
   
   // writing to registers
   register reg0(.d(data_writeReg), .aclr(ctrl_reset), .clk(clock), .write_Enable(1'b0), .out(r0));
   register reg1(.d(data_writeReg), .aclr(ctrl_reset), .clk(clock), .write_Enable(enabled[1]), .out(r1));
   register reg2(.d(data_writeReg), .aclr(ctrl_reset), .clk(clock), .write_Enable(enabled[2]), .out(r2));
   register reg3(.d(data_writeReg), .aclr(ctrl_reset), .clk(clock), .write_Enable(enabled[3]), .out(r3));
   //shiftRegister reg4(.d(data_writeReg), .aclr(ctrl_reset), .clk(clock), .write_Enable(1'b1), .out(r4));
  register reg4(.d(data_writeReg), .aclr(ctrl_reset), .clk(clock), .write_Enable(enabled[4]), .out(r4));
   register reg5(.d(data_writeReg), .aclr(ctrl_reset), .clk(clock), .write_Enable(enabled[5]), .out(r5));
   register reg6(.d(data_writeReg), .aclr(ctrl_reset), .clk(clock), .write_Enable(enabled[6]), .out(r6));
   register reg7(.d(data_writeReg), .aclr(ctrl_reset), .clk(clock), .write_Enable(enabled[7]), .out(r7));
   //register reg8(.d(data_writeReg), .aclr(ctrl_reset), .clk(clock), .write_Enable(enabled[8]), .out(r8));
   shiftRegister reg8(ctrl_reset, clock, 1'b1, r8);
   register reg9(.d(data_writeReg), .aclr(ctrl_reset), .clk(clock), .write_Enable(enabled[9]), .out(r9));
   register reg10(.d(data_writeReg), .aclr(ctrl_reset), .clk(clock), .write_Enable(enabled[10]), .out(r10));
   register reg11(.d(data_writeReg), .aclr(ctrl_reset), .clk(clock), .write_Enable(enabled[11]), .out(r11));
   register reg12(.d(data_writeReg), .aclr(ctrl_reset), .clk(clock), .write_Enable(enabled[12]), .out(r12));
   register reg13(.d(data_writeReg), .aclr(ctrl_reset), .clk(clock), .write_Enable(enabled[13]), .out(r13));
   register reg14(.d(data_writeReg), .aclr(ctrl_reset), .clk(clock), .write_Enable(enabled[14]), .out(r14));
   register reg15(.d(data_writeReg), .aclr(ctrl_reset), .clk(clock), .write_Enable(enabled[15]), .out(r15));
   register reg16(.d(data_writeReg), .aclr(ctrl_reset), .clk(clock), .write_Enable(enabled[16]), .out(r16));
   register reg17(.d(data_writeReg), .aclr(ctrl_reset), .clk(clock), .write_Enable(enabled[17]), .out(r17));
   register reg18(.d(data_writeReg), .aclr(ctrl_reset), .clk(clock), .write_Enable(enabled[18]), .out(r18));
   register reg19(.d(data_writeReg), .aclr(ctrl_reset), .clk(clock), .write_Enable(enabled[19]), .out(r19));
    register reg20(.d(data_writeReg), .aclr(ctrl_reset), .clk(clock), .write_Enable(enabled[20]), .out(r20));
   register reg21(.d(data_writeReg), .aclr(ctrl_reset), .clk(clock), .write_Enable(enabled[21]), .out(r21));
   register reg22(.d(data_writeReg), .aclr(ctrl_reset), .clk(clock), .write_Enable(enabled[22]), .out(r22));
   register reg23(.d(data_writeReg), .aclr(ctrl_reset), .clk(clock), .write_Enable(enabled[23]), .out(r23));
   register reg24(.d(data_writeReg), .aclr(ctrl_reset), .clk(clock), .write_Enable(enabled[24]), .out(r24));
   register reg25(.d(data_writeReg), .aclr(ctrl_reset), .clk(clock), .write_Enable(enabled[25]), .out(r25));
   register reg26(.d(data_writeReg), .aclr(ctrl_reset), .clk(clock), .write_Enable(enabled[26]), .out(r26));
   register reg27(.d(data_writeReg), .aclr(ctrl_reset), .clk(clock), .write_Enable(enabled[27]), .out(r27));
   register reg28(.d(data_writeReg), .aclr(ctrl_reset), .clk(clock), .write_Enable(enabled[28]), .out(r28));
   register reg29(.d(data_writeReg), .aclr(ctrl_reset), .clk(clock), .write_Enable(enabled[29]), .out(r29));
   register reg30(.d(data_writeReg), .aclr(ctrl_reset), .clk(clock), .write_Enable(enabled[30]), .out(r30));
   register reg31(.d(data_writeReg), .aclr(ctrl_reset), .clk(clock), .write_Enable(enabled[31]), .out(r31));
   
   // reading from registers
   Mux32to1 #(32) rs1val(r31, r30, r29, r28, r27, r26, r25, r24, r23, r22,r21, r20, r19, r18, r17, r16, r15, r14, r13, r12,
						 r11, r10, r9, r8, r7, r6, r5, r4, r3, r2, r1, r0, ctrl_readRegA, data_readRegA);
   Mux32to1 #(32) rs2val(r31, r30, r29, r28, r27, r26, r25, r24, r23, r22,r21, r20, r19, r18, r17, r16, r15, r14, r13, r12,
						 r11, r10, r9, r8, r7, r6, r5, r4, r3, r2, r1, r0, ctrl_readRegB, data_readRegB);						
endmodule


////A register with 32 parallel [1-b] D-F/Fs
module register(d, aclr, clk, write_Enable, out);
		input clk, write_Enable, aclr;
		input [31:0] d;
		output [31:0] out;
		wire [31:0] x;
		genvar i;
	 generate
		for (i = 0; i <= 31; i = i + 1) begin: myblock
				my_dff dFF(d[i], aclr, clk, write_Enable, x[i]) ;
				assign out[i] = x[i];
		end 
	 endgenerate

endmodule

// d flip-flop with asynchronous clear
module my_dff(d, aclr, clk, write_Enable, f);
	input d, clk, write_Enable, aclr;
	output f;
	reg f;
	
	initial begin
        f = 0;
    end
	
	always @(posedge clk or posedge aclr) begin
		if(aclr == 1)
			f=0;
		else 	
			if(write_Enable == 1) 
				  f = d;  
	end	
endmodule



//32:1 multiplexer with binary select made with ORing 4:1 multiplexers (k bit width)
module Mux32to1(a31, a30, a29, a28, a27, a26, a25, a24, a23, a22, a21, a20, a19, a18, a17, a16, a15, 
	            a14, a13, a12, a11, a10, a9, a8, a7, a6, a5, a4, a3, a2, a1, a0, sb, b);
	  
		parameter k = 1;
		input [k-1:0] a31, a30, a29, a28, a27, a26, a25, a24, a23, a22, a21, a20, a19, a18, a17, a16, a15; 
		input [k-1:0] a14, a13, a12, a11, a10, a9, a8, a7, a6, a5, a4, a3, a2, a1, a0; 
		input [4:0] sb; //binary select
		output [k-1:0] b;
		wire [31:0] s; //one-hot select
		// 4:1 multiplexer outputs
		wire [k-1:0] ba8, ba7, ba6, ba5, ba4, ba3, ba2, ba1;   
		
		Dec5to32 d(.a(sb), .b(s));  // get one-hot select   
	
		assign b = ba1 | ba2 | ba3 |ba4 |ba5 | ba6 | ba7 | ba8;     
		
		Mux4b #(k) m1(a3, a2, a1, a0, s[3:0], ba1);
		Mux4b #(k) m2(a7, a6, a5, a4, s[7:4], ba2);
		Mux4b #(k) m3(a11, a10, a9, a8, s[11:8], ba3);
		Mux4b #(k) m4(a15, a14, a13, a12, s[15:12], ba4);
		Mux4b #(k) m5(a19, a18, a17, a16, s[19:16], ba5);
		Mux4b #(k) m6(a23, a22, a21, a20, s[23:20], ba6);
		Mux4b #(k) m7(a27, a26, a25, a24, s[27:24], ba7);
		Mux4b #(k) m8(a31, a30, a29, a28, s[31:28], ba8);
		
endmodule



// 4:1 multiplexer(arbitrary width)
module Mux4b(a3, a2, a1, a0, s, b);
	parameter k = 1;
	input [k-1:0] a0, a1, a2, a3; //inputs
	input [3:0] s; // one-hot select
	output [k-1:0] b;
	
	assign b = ({k{s[3]}} & a3) | ({k{s[2]}} & a2) | ({k{s[1]}} & a1) | ({k{s[0]}} & a0);
endmodule


// 5 to 32 bit decoder where output is one hot
// uses a 2 to 4 decoder and a 3 to 8 decoder as pre-decoders i.e. building blocks to reduce logical effort
// combines pre-decoder output with 32 AND gates
module Dec5to32(a,b);
	input [4:0] a;
	output [31:0] b;
	wire [3:0] x; // output of 2 to 4 pre-decoder
	wire [7:0] y; // output of 3 to 8 pre-decoder
	

	//instantiate pre decoders
	Dec d0(.a(a[1:0]), .b(x));
	Dec #(3,8) d1(.a(a[4:2]), .b(y));
	
	//combine pre-decoder outputs with AND gates
	assign b[3:0] = x & {4{y[0]}};
	assign b[7:4] = x & {4{y[1]}};
	assign b[11:8] = x & {4{y[2]}};
	assign b[15:12] = x & {4{y[3]}};
	assign b[19:16] = x & {4{y[4]}};
	assign b[23:20] = x & {4{y[5]}};
	assign b[27:24] = x & {4{y[6]}};
	assign b[31:28] = x & {4{y[7]}};
endmodule //Dec5to32	



//n -> m Decoder
//a - binary output (n bits wide)
//b - one hot output (m bits wide)
module Dec(a,b);
	parameter n = 2;
	parameter m = 4;
	
	input [n-1:0] a;
	output [m-1:0] b;
	
	assign b = 1 << a;
endmodule

