
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