module sub8bits(X,Y,SUB,CARRY);
	input		[7:0]X,Y;
	output	[7:0]SUB;
	output	CARRY;
	
	assign {CARRY,SUB} = Y-X;
endmodule