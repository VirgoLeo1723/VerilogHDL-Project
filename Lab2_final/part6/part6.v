module part6(num, hex0, hex1);
	input [5:0]num;
	output[6:0]hex0, hex1;
	
	seg7_control inst0(.SEG7_IN(num%10), .SEG7_OUT(hex0));
	seg7_control inst1(.SEG7_IN(num/10), .SEG7_OUT(hex1));
	
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