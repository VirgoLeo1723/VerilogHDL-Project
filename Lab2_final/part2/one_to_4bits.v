module one_to_4bits(in,out);
	input		in;
	output	[3:0]out;
	assign 	out = (2'b0000) & in;
endmodule