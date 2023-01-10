module multi_4bits(out, in0, in1, s);
	input		[3:0]in0,in1;
	input		s;
	output	[3:0]out;
	
	assign out = (in0&~s)|(in1&s); 
endmodule