module part2(CLK, RESET, ADD_SUB, IN, IN_LSB, IN_MSB, OUT_LSB, OUT_MSB, RESULT, CARRY, OVERFLOW);
	input		CLK, RESET, ADD_SUB;
	input		[7:0]IN;
	output	[7:0]RESULT;
	output	[6:0]IN_LSB, IN_MSB, OUT_LSB, OUT_MSB;
	output	OVERFLOW, CARRY;
	
	wire	[7:0]A,S;
	wire	[7:0]sum_ff_out, input_ff_out, sum_ff_in, sub_ff_in, sub_ff_out; 
	wire 	carry_ff_in0, carry_ff_in1, overflow_ff_in0, overflowff_in1;
	wire	carry_ff_in, overflow_ff_in;
	
	
	assign A = IN;
	
	
	D_FF input_ff		(.CLK(CLK), .RESET(RESET), .D(A), 					.Q(input_ff_out));
	D_FF overflow_ff 	(.CLK(CLK), .RESET(RESET), .D(overflow_ff_in), 	.Q(OVERFLOW));
	D_FF carry_ff		(.CLK(CLK), .RESET(RESET), .D(carry_ff_in), 		.Q(CARRY));
	D_FF sum_ff			(.CLK(CLK), .RESET(RESET), .D(sum_ff_in), 		.Q(sum_ff_out));
	D_FF sub_ff			(.CLK(CLK), .RESET(RESET), .D(sub_ff_in), 		.Q(sub_ff_out));
	
	defparam input_ff.n = 8;
	defparam sum_ff.n = 8;
	defparam	overflow_ff.n = 1;
	
	choose_signal	result	(.select(ADD_SUB), .in0(sum_ff_in),			.in1(sub_ff_in), 			.out(RESULT));
	choose_signal	carry 	(.select(ADD_SUB), .in0(overflow_ff_in0), .in1(overflow_ff_in1),	.out(overflow_ff_in));
	choose_signal	overflow (.select(ADD_SUB), .in0(carry_ff_in0), 	.in1(carry_ff_in1), 		.out(carry_ff_in));
	choose_signal	num_in	(.select(ADD_SUB), .in0(sum_ff_out), 		.in1(sub_ff_out), 		.out(S));
	
	defparam result.n_bits = 8;
	defparam num_in.n_bits = 8;

	
	sum8bits			inst0	(.X(input_ff_out), .Y(sum_ff_out), .SUM(sum_ff_in), .CARRY(carry_ff_in0));
	sub8bits			inst1	(.X(input_ff_out), .Y(sub_ff_out), .SUB(sub_ff_in), .CARRY(carry_ff_in1));
	overflow_bits 	sum	(.X(input_ff_out), .Y(sum_ff_in),  .TEMP(sum_ff_out), .OVERFLOW(overflow_ff_in0));
	overflow_bits 	sub	(.X(input_ff_out), .Y(sub_ff_in),  .TEMP(sub_ff_out), .OVERFLOW(overflow_ff_in1));
	
	display7SEG		A_lsb (.in(A[3:0]),.out(IN_LSB));
	display7SEG		A_msb (.in(A[7:4]),.out(IN_MSB));
	display7SEG		S_lsb (.in(S[3:0]),.out(OUT_LSB));
	display7SEG		S_msb (.in(S[7:4]),.out(OUT_MSB));
	

	
endmodule








