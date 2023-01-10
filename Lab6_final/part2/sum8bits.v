module sum8bits(X,Y,SUM,CARRY);
	input		[7:0]X,Y;
	output	[7:0]SUM;
	output	CARRY;
	
	assign {CARRY,SUM} = X+Y;
endmodule