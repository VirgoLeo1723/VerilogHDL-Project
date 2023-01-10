module choose_signal(select, in0, in1, out);
	parameter n_bits = 1;
	input		select;
	input		[n_bits-1:0]in0, in1;
	output	[n_bits-1:0]out;
	
	assign out = (in0&~select)|(in1&select);
	
endmodule