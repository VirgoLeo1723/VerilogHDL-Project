module overflow_bits(X,Y,TEMP,OVERFLOW);
	input 	[7:0]X,Y,TEMP;
	output	OVERFLOW;
	
	assign OVERFLOW = (X>=128 | Y>=128 | TEMP>=128);
	
endmodule