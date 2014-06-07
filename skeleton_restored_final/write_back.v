module write_back(pcWbackIn, jalWbackIn, aclr, clock, data_ReadInFrMem, rdFrMem, regWrFrMem, 
					m2RegFrMem, ALUResultFrMem,data_WBack, rd_WBack, reg_WBack);

input aclr, clock, m2RegFrMem, regWrFrMem, jalWbackIn;
input [31:0] data_ReadInFrMem, ALUResultFrMem, pcWbackIn;
input[4:0] rdFrMem;
output[31:0] data_WBack;
output reg_WBack;
output[4:0] rd_WBack;
wire[4:0] cons31;
wire[31:0] data_WBack1;


Mux2bin #(32) dataWBackMux(ALUResultFrMem, data_ReadInFrMem, m2RegFrMem, data_WBack1);

//assign pcWbackOut = pcWbackIn;
//assign jalWbackOut = jalWbackIn;
//assign rd_WBack = rdFrMem;
assign reg_WBack = regWrFrMem;


assign cons31 = 5'd31;


Mux2bin #(32) muxDataWreg(data_WBack1,pcWbackIn, jalWbackIn, data_WBack);
Mux2bin #(5) muxWreg(rdFrMem, cons31, jalWbackIn, rd_WBack);




endmodule