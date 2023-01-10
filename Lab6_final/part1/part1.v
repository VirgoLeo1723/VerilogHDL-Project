module part1(CLK, RESET, IN, IN_LSB, IN_MSB, OUT_LSB, OUT_MSB, SUM, CARRY, OVERFLOW);
	input		CLK, RESET;
	input		[7:0]IN;
	output	[7:0]SUM;
	output	[6:0]IN_LSB, IN_MSB, OUT_LSB, OUT_MSB;
	output	OVERFLOW, CARRY;
	
	reg	[7:0]A,S;
	wire	[7:0]sum_ff_out, input_ff_out, sum_ff_in; 
	
	always begin
		A = IN;
		S = sum_ff_out;
	end
	
	assign SUM = sum_ff_in;
	
	D_FF input_ff		(.CLK(CLK), .RESET(RESET), .D(A), 					.Q(input_ff_out));
	D_FF overflow_ff 	(.CLK(CLK), .RESET(RESET), .D(overflow_ff_in), 	.Q(OVERFLOW));
	D_FF carry_ff		(.CLK(CLK), .RESET(RESET), .D(carry_ff_in), 		.Q(CARRY));
	D_FF sum_ff			(.CLK(CLK), .RESET(RESET), .D(sum_ff_in), 		.Q(sum_ff_out));
	
	defparam input_ff.n = 8;
	defparam sum_ff.n = 8;
	defparam	overflow_ff.n = 8;
	
	sum4bits			inst0	(.X(input_ff_out), .Y(sum_ff_out), .SUM(sum_ff_in), .CARRY(carry_ff_in));
	overflow_bits 	inst1	(.X(input_ff_out), .Y(sum_ff_in),  .SUM(sum_ff_out), .OVERFLOW(overflow_ff_in));
	
	display7SEG		A_lsb (.in(A[3:0]),.out(IN_LSB));
	display7SEG		A_msb (.in(A[7:4]),.out(IN_MSB));
	display7SEG		S_lsb (.in(S[3:0]),.out(OUT_LSB));
	display7SEG		S_msb (.in(S[7:4]),.out(OUT_MSB));
	

	
endmodule

module D_FF(CLK, RESET, D, Q);
	parameter n=1;
	input 	CLK, RESET;
	input 	[n-1:0]D;
	output	reg[n-1:0]Q;
	
	always @(posedge CLK or negedge RESET) begin
		if (!RESET) Q<=0;
		else if (CLK) Q<=D;
	end
endmodule

module sum4bits(X,Y,SUM,CARRY);
	input		[7:0]X,Y;
	output	[7:0]SUM;
	output	CARRY;
	
	assign {CARRY,SUM} = X+Y;
endmodule

module overflow_bits(X,Y,SUM,OVERFLOW);
	input 	[7:0]X,Y,SUM;
	output	OVERFLOW;
	
	assign OVERFLOW = (X>=128 | Y>=128 | SUM>=128);
	
endmodule

module display7SEG(in,out);
	input 	[3:0]in /*systhesis keep*/;
	output	reg[6:0]out;
	always @(in) begin
		if (in == 1) out = 7'b0000110;
		if (in == 2) out = 7'b0100100;
		if (in == 3) out = 7'b0110000;
		if (in == 4) out = 7'b0011001;
		if (in == 5) out = 7'b0010010;
		if (in == 6) out = 7'b0000010;
		if (in == 7) out = 7'b1111000;
		if (in == 8) out = 7'b0000000;
		if (in == 9) out = 7'b0001110;
		if (in == 0) out = 7'b1000000;
	end
endmodule