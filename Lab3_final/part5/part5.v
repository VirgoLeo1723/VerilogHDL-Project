module part5(CLK, Num, Sum, C_out, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	input		[7:0]Num;
	input 	CLK;

	output	[6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	wire 	[7:0]A /*synthesis keep*/;
	wire	[7:0]B /*synthesis keep*/;
	output	[7:0]Sum;
	output 	C_out;
	
	
	D_latch 	inst1 (.CLK(CLK),  .D(Num), .Q(A));
	D_latch	inst2 (.CLK(~CLK), .D(Num), .Q(B));
	
	sum8bits		sum	(.A(A), .B(B), .C_IN(0), .SUM(Sum), .C_OUT(C_out));
	
	seg7_control 	seg0	(.SEG7_IN(A[3:0]), .SEG7_OUT(HEX0));
	seg7_control 	seg1	(.SEG7_IN(A[7:4]), .SEG7_OUT(HEX1));
	
	seg7_control 	seg2	(.SEG7_IN(B[3:0]), .SEG7_OUT(HEX2));
	seg7_control 	seg3	(.SEG7_IN(B[7:4]), .SEG7_OUT(HEX3));
	
	seg7_control 	seg4	(.SEG7_IN(Sum[3:0]), .SEG7_OUT(HEX4));
	seg7_control 	seg5	(.SEG7_IN(Sum[7:4]), .SEG7_OUT(HEX5));

endmodule

module D_latch(CLK, D, Q);
	input		[7:0] D;
	input		CLK;
	output reg [7:0] Q;
	
	always @ (D,CLK) 
		if (CLK) 
			Q = D;
	
endmodule


module sum8bits(A,B,C_IN,SUM,C_OUT);
	input		[7:0]A,B;
	input		C_IN;
	
	output 	[7:0]SUM;
	output	C_OUT;
	
	wire 		[7:0]temp_sum;
	wire		[3:0]msb,lsb;
	wire		c1, c2, c3, c4, c5, c6;
	
	sum4bits inst1	(.A(A[3:0]), .B(B[3:0]), .C_IN(0), .SUM(lsb), .C_OUT(c1));
	assign {c2,temp_sum[3:0]} = lsb>9 ? lsb+4'b0110 : {c1,lsb};
	assign c3 = c1 ^ c2;
	
	sum4bits inst2	(.A(A[7:4]), .B(B[7:4]), .C_IN(c3), .SUM(msb), .C_OUT(c4));
	assign {c5,temp_sum[7:4]} = msb>9 ? msb+4'b0110 : {c4,msb};
	assign C_OUT = c5 ^ c2;
	
	assign SUM = temp_sum;
		
	
	
endmodule

module sum4bits(A,B,C_IN,SUM,C_OUT);
	input		[3:0]A,B;
	input		C_IN;
	output	[3:0]SUM;
	output	C_OUT;
	
	wire		C_1, C_2, C_3;
	
	full_adder inst1 (.a(A[0]), .b(B[0]), .c_i(C_IN), .s(SUM[0]), .c_o(C1));
	full_adder inst2 (.a(A[1]), .b(B[1]), .c_i(C1), .s(SUM[1]), .c_o(C2));
	full_adder inst3 (.a(A[2]), .b(B[2]), .c_i(C2), .s(SUM[2]), .c_o(C3));
	full_adder inst4 (.a(A[3]), .b(B[3]), .c_i(C3), .s(SUM[3]), .c_o(C_OUT));
	
endmodule

module full_adder(a,b,c_i,s,c_o);
	input 	a,b,c_i;
	output	s, c_o;
	
	assign 	s 		= c_i ^ (a^b);
	assign 	c_o	= (c_i & (a^b)) | (b & ~(a^b));

endmodule 

module seg7_control(SEG7_IN, SEG7_OUT);
	input 	[3:0]SEG7_IN;
	output	[6:0]SEG7_OUT;
	
	assign SEG7_OUT[6] = 	(~SEG7_IN[3] &~SEG7_IN[2] &~SEG7_IN[1]) 
						        |( SEG7_IN[3] & SEG7_IN[2] &  SEG7_IN[1]);
						  
	assign SEG7_OUT[5] = 	( SEG7_IN[1] & SEG7_IN[0])
								  |(~SEG7_IN[3] & ~SEG7_IN[2] & SEG7_IN[0])
							     |(~SEG7_IN[3] & ~SEG7_IN[2] & SEG7_IN[1]);
						  
	assign SEG7_OUT[4] = 	( SEG7_IN[0])
						        |( SEG7_IN[2] & ~SEG7_IN[1]);
	
	assign SEG7_OUT[3] = 	(~SEG7_IN[3] & ~SEG7_IN[2] & ~SEG7_IN[1] &  SEG7_IN[0])
						        |( SEG7_IN[2] & ~SEG7_IN[1] & ~SEG7_IN[0])
						        |( SEG7_IN[2] &  SEG7_IN[1] &  SEG7_IN[0]);
						 
	assign SEG7_OUT[2] = 	(~SEG7_IN[2] &  SEG7_IN[1] & ~SEG7_IN[0]);
	
	assign SEG7_OUT[1] =    ( SEG7_IN[2] & ~SEG7_IN[1] &  SEG7_IN[0])
								  |( SEG7_IN[2] &  SEG7_IN[1] & ~SEG7_IN[0]);
	
	assign SEG7_OUT[0] = 	(~SEG7_IN[3] & ~SEG7_IN[2] & ~SEG7_IN[1] &  SEG7_IN[0])
								  |( SEG7_IN[2] & ~SEG7_IN[1] & ~SEG7_IN[0]);
	
	
endmodule

