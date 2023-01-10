module display7SEG(num, carry , hex0, hex1);
	input 	[3:0]num;
	input 	carry;
	output	[6:0]hex0, hex1;
	
	wire		[3:0]A_out;
	wire 		[3:0]num_plus6;
	wire		select;
	wire		com_out;
	
	
	wire		[3:0]seg7_1_in;
	wire		[3:0]seg7_0_in;
	
	circuitA 		inst0	(.A_in(num), .A_out(A_out));
	comparew9 		inst1	(.com_in(num), .com_out(com_out));
	
	or select_char_1 		(select,carry,com_out);
	
	multi_4bits 	inst4	(.out(seg7_0_in), .in0(num), .in1(A_out), .s(select));
	one_to_4bits 	inst5	(.out(seg7_1_in), .in(select));
	
	seg7_control 	inst6	(.SEG7_IN(seg7_0_in), .SEG7_OUT(hex0));
	seg7_control 	inst7	(.SEG7_IN(seg7_1_in), .SEG7_OUT(hex1));
	
	
endmodule


module circuitA(A_in, A_out);
	input		[3:0]A_in;
	output	[3:0]A_out;
	
	sum4bits inst0 (.A(A_in), .B(4'b0110), .C_IN(1'b0), .C_OUT(), .SUM(A_out));
						
endmodule



module comparew9(com_in, com_out);
	input 	[3:0]com_in;
	output	com_out;
	assign 	com_out = com_in[3]&(com_in[2]|com_in[1]);
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

module multi_4bits(out, in0, in1, s);
	input		[3:0]in0,in1;
	input		s;
	output	[3:0]out;
	
	assign out = (in0 & {4{~s}})|(in1& {4{s}}); 
endmodule

module one_to_4bits(in,out);
	input		in;
	output	[3:0]out;
	assign 	out = (2'b0001) & in;
endmodule
