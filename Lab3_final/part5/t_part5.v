module t_part5(Num,CLK,C_out,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
	input 	[7:0]Num;
	input 	CLK;
	
	output	C_out;
	output	[6:0]HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;
	
	wire 		[7:0]A,B 		/* synthesis keep */;
	reg		[8:0]state		/* synthesis keep */;
	
	wire		[7:0]Sum;
	
	D_latch		numa	(.CLK(CLK), .D(Num), .Q(A));
	D_latch		numb	(.CLK(~CLK), .D(Num), .Q(B));
	
//	sum8bits		sum	(.A(A), .B(B), .C_IN(0), .SUM(Sum), .C_OUT(C_out));
//	
//	seg7_control 	seg0	(.SEG7_IN(A[3:0]), .SEG7_OUT(HEX0));
//	seg7_control 	seg1	(.SEG7_IN(A[7:4]), .SEG7_OUT(HEX1));
//	
//	seg7_control 	seg2	(.SEG7_IN(B[3:0]), .SEG7_OUT(HEX2));
//	seg7_control 	seg3	(.SEG7_IN(B[7:4]), .SEG7_OUT(HEX3));
//	
//	seg7_control 	seg4	(.SEG7_IN(Sum[3:0]), .SEG7_OUT(HEX4));
//	seg7_control 	seg5	(.SEG7_IN(Sum[7:4]), .SEG7_OUT(HEX5));
endmodule

module t_D_latch(CLK, D, Q);
	input		[7:0] D;
	input		CLK;
	output	reg[7:0] Q;
	
	always @ (D,CLK) 
		if (CLK) 
			Q = D;
	
endmodule