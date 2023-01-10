module comparew9(com_in, com_out);
	input 	[3:0]com_in;
	output	com_out;
	assign 	com_out = com_in[3]&(com_in[2]|com_in[1]);
endmodule