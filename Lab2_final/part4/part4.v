module part4(X,Y,HEX0,HEX1);
	input 	[3:0]X,Y;
	output	[6:0]HEX0,HEX1;
	wire [3:0]num;
	wire carry;
	
	sum4bits 	inst0 (.A(X), .B(Y), .C_IN(0), .SUM(num), .C_OUT(carry));
	display7SEG	inst1 (.num(num), .carry(carry), .hex0(HEX0), .hex1(HEX1));
	
endmodule