module  part4(OUT,C_IN);
	input 	[1:0]C_IN;
	output	[6:0]OUT;
	
	assign 	OUT = (C_IN==0) ? 7'b0100001: 
						(C_IN==1) ? 7'b0000110: 
						(C_IN==2) ? 7'b0100100:7'b1111011;
	

endmodule