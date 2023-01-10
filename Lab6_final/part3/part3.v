module part3(CLK, IN,EA,EB,P);
	input		CLK, EA, EB;
	input		[7:0]IN;
	output	[15:0]P;
	
	wire	[7:0] A,B;
	wire	[15:0]SUM;
	wire	[7:0] adder1_in0, adder1_in1;
	wire	[7:0] adder2_in0, adder2_in1;
	wire 	[7:0] adder3_in0, adder3_in1;
	wire	[7:0] adder4_in0, adder4_in1;
	wire	[7:0] adder5_in0, adder5_in1;
	wire 	[7:0] adder6_in0, adder6_in1;
	wire	[7:0] adder7_in0, adder7_in1;

	D_FF	inputa_ff (.CLK(CLK), .EN(EA), .D(IN),  .Q(A));
	D_FF	inputb_ff (.CLK(CLK), .EN(EB), .D(IN),  .Q(B));
	D_FF	output_ff (.CLK(CLK), .EN(1),  .D(SUM), .Q(P));
	
	multiply_Nx1	inst0		(.A(A), .B(B[0]), .P({adder1_in0[6:0],SUM[0]}));
	multiply_Nx1	inst1		(.A(A), .B(B[1]), .P(adder1_in1));
	multiply_Nx1	inst2		(.A(A), .B(B[2]), .P(adder2_in1));
	multiply_Nx1	inst3		(.A(A), .B(B[3]), .P(adder3_in1));
	multiply_Nx1	inst4		(.A(A), .B(B[4]), .P(adder4_in1));
	multiply_Nx1	inst5		(.A(A), .B(B[5]), .P(adder5_in1));
	multiply_Nx1	inst6		(.A(A), .B(B[6]), .P(adder6_in1));
	multiply_Nx1	inst7		(.A(A), .B(B[7]), .P(adder7_in1));
	
	sumNbits	adder1 (.A(adder1_in0), .B(adder1_in1), .C_IN(0) ,.SUM({adder2_in0[2:0],SUM[1]}) ,.C_OUT(adder2_in0[3]));
	sumNbits adder2 (.A(adder2_in0), .B(adder2_in1), .C_IN(0) ,.SUM({adder3_in0[2:0],SUM[2]}) ,.C_OUT(adder3_in0[3]));
	sumNbits adder3 (.A(adder3_in0), .B(adder3_in1), .C_IN(0) ,.SUM({adder4_in0[2:0],SUM[3]}) ,.C_OUT(adder4_in0[3]));
	sumNbits	adder4 (.A(adder4_in0), .B(adder4_in1), .C_IN(0) ,.SUM({adder5_in0[2:0],SUM[4]}) ,.C_OUT(adder5_in0[3]));
	sumNbits adder5 (.A(adder5_in0), .B(adder5_in1), .C_IN(0) ,.SUM({adder6_in0[2:0],SUM[5]}) ,.C_OUT(adder6_in0[3]));
	sumNbits adder6 (.A(adder6_in0), .B(adder6_in1), .C_IN(0) ,.SUM({adder7_in0[2:0],SUM[6]}) ,.C_OUT(adder7_in0[3]));
	sumNbits	adder7 (.A(adder7_in0), .B(adder7_in1), .C_IN(0) ,.SUM(SUM[14:7]) 					,.C_OUT(SUM[15]));
	
	defparam inputa_ff.n_bits = 8;
	defparam inputb_ff.n_bits = 8;
	defparam output_ff.n_bits = 16;
	
	defparam inst0.n_bits = 8;
	defparam inst1.n_bits = 8;
	defparam inst2.n_bits = 8;
	defparam inst3.n_bits = 8;
	defparam inst4.n_bits = 8;
	defparam inst5.n_bits = 8;
	defparam inst6.n_bits = 8;
	defparam inst7.n_bits = 8;
	
	defparam	adder1.n_bits = 8;
	defparam	adder2.n_bits = 8;
	defparam	adder3.n_bits = 8;
	defparam	adder4.n_bits = 8;
	defparam	adder5.n_bits = 8;
	defparam	adder6.n_bits = 8;
	defparam	adder7.n_bits = 8;
	

	
endmodule

module D_FF(CLK, EN, D, Q);
	parameter n_bits = 4;
	input		CLK, EN;
	input 	[n_bits-1:0]D;
	output	reg[n_bits-1:0]Q;
	
	always @(posedge CLK) begin
		if (EN) Q<=D;
	end
	
endmodule

module multiply_Nx1(A,B,P);
	parameter	n_bits = 4;
	input		[n_bits-1:0]A;
	input		B;
	output	[n_bits-1:0]P;
	
	assign 	P = A & {n_bits{B}};
endmodule

module sumNbits(A,B,C_IN,SUM,C_OUT);
	parameter	n_bits = 4;
	input		[3:0]A,B;
	input		C_IN;
	output	[3:0]SUM;
	output	C_OUT;
	
	assign {C_OUT,SUM} = A+B+C_IN;
	
endmodule

