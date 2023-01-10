module circuitA(A_in, A_out);
	input		[3:0]A_in;
	output	[3:0]A_out;
	
	assign	A_out[3] = 0;
	
	assign 	A_out[2] = A_out[2]& A_out[1];
	
	assign	A_out[1] = A_out[2]&~A_out[1];
	
	assign 	A_out[0] = A_out[2]& A_out[0]  
					      +~A_out[2]&~A_out[0];
						
endmodule