module part4(D, CLK, Qa, Qb, Qc);
	input		[3:0]D;
	input 	CLK;
	output	[3:0]Qa, Qb, Qc;
	
	D_latch 	inst1 (.CLK(CLK), .D(D), .Q(Qa));
	D_FF_P	inst2 (.CLK(CLK), .D(D), .Q(Qb));
	D_FF_N	inst3 (.CLK(CLK), .D(D), .Q(Qc));
endmodule

module D_latch(CLK, D, Q);
	input		[3:0] D;
	input		CLK;
	output	reg[3:0] Q;
	
	always @ (D,CLK) 
		if (CLK) 
			Q = D;
	
endmodule

module D_FF_P(CLK, D, Q);
	input		[3:0] D;
	input		CLK;
	output	reg[3:0] Q;
	
	always @(posedge CLK) Q<=D;
	
endmodule

module D_FF_N(CLK, D, Q);
	input		[3:0] D;
	input		CLK;
	output	reg[3:0] Q;
	
	always @(negedge CLK) Q<=D;
endmodule