
module SSD(binary, segs);

`define SS_0 7'b0111111
`define SS_1 7'b0000110
`define SS_2 7'b1011011
`define SS_3 7'b1001111
`define SS_4 7'b1100110
`define SS_5 7'b1101101
`define SS_6 7'b1111101
`define SS_7 7'b0000111
`define SS_8 7'b1111111
`define SS_9 7'b1101111


input [3:0] binary;
output [6:0] segs;

reg [6:0] segs;

always@(*) begin
case(binary)
0: segs = ~(`SS_0);
1: segs = ~(`SS_1);
2: segs = ~(`SS_2);
3: segs = ~(`SS_3);
4: segs = ~(`SS_4);
5: segs = ~(`SS_5);
6: segs = ~(`SS_6);
7: segs = ~(`SS_7);
8: segs = ~(`SS_8);
9: segs = ~(`SS_9);
default: segs = ~(7'b0000000);
endcase
end

endmodule
