module full_adder(a,b,c_i,s,c_o);
	input 	a,b,c_i;
	output	s, c_o;
	
	assign 	s 		= c_i ^ (a^b);
	assign 	c_0	= (c_i & (a^b)) | (b & ~(a^b));

endmodule 