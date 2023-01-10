module part2(num, hex0, hex1);
	input 	[3:0]num;
	output	[6:0]hex0, hex1;
	
	wire		[3:0]A_out;
	wire		[3:0]com_out;
	
	wire		[3:0]seg7_1_in;
	wire		[3:0]seg7_0_in;
	
	circuitA 		inst1	(.A_in(num), .A_out(A_out));
	comparew9 		inst2	(.com_in(num), .com_out(com_out));
	
	multi_4bits 	inst3	(.out(seg7_0_in), .in0(num), .in1(A_out), .s(com_out));
	one_to_4bits 	inst4	(.out(seg7_1_in), .in(com_out));

	b2d_7seg (seg7_0_in, hex0);
	b2d_7seg (seg7_1_in, hex1);
	
endmodule

module circuitA(A_in, A_out);
	input		[3:0]A_in;
	output	[3:0]A_out;
	
	assign	A_out[3] = 0;
	
	assign 	A_out[2] = A_in[2]& A_in[1];
	
	assign	A_out[1] = A_in[2]&~A_in[1];
	
	assign 	A_out[0] = A_in[2]& A_in[0]  
					      +~A_in[2]&~A_in[0];
						
endmodule

module comparew9(com_in, com_out);
	input 	[3:0]com_in;
	output	com_out;
	assign 	com_out = com_in[3] & (com_in[2]|com_in[1]);
endmodule

module b2d_7seg (X, SSD);
       input [3:0] X;
       output [6:0] SSD;
       assign SSD[0] = ((~X[3] & ~X[2] & ~X[1] &  X[0]) | (~X[3] &  X[2] & ~X[1] & ~X[0]));
       assign SSD[1] = ((~X[3] &  X[2] & ~X[1] &  X[0]) | (~X[3] &  X[2] &  X[1] & ~X[0]));
       assign SSD[2] =  (~X[3] & ~X[2] &  X[1] & ~X[0]);
       assign SSD[3] = ((~X[3] & ~X[2] & ~X[1] &  X[0]) | (~X[3] &  X[2] & ~X[1] & ~X[0]) | (~X[3] &  X[2] & X[1] & X[0]) | (X[3] & ~X[2] & ~X[1] & X[0]));
       assign SSD[4] = ~((~X[2] & ~X[0]) | (X[1] & ~X[0]));
       assign SSD[5] = ((~X[3] & ~X[2] & ~X[1] &  X[0]) | (~X[3] & ~X[2] &  X[1] & ~X[0]) | (~X[3] & ~X[2] & X[1] & X[0]) | (~X[3] & X[2] & X[1] & X[0]));
       assign SSD[6] = ((~X[3] & ~X[2] & ~X[1] &  X[0]) | (~X[3] & ~X[2] & ~X[1] & ~X[0]) | (~X[3] &  X[2] & X[1] & X[0]));
endmodule

module multi_4bits(out, in0, in1, s);
	input		[3:0]in0,in1;
	input		s;
	output	[3:0]out;
	
	assign out = (in0&{4{~s}})|(in1&{4{s}}); 
endmodule

module one_to_4bits(in,out);
	input		in;
	output	[3:0]out;
	assign 	out = (4'b0000) | in;
endmodule