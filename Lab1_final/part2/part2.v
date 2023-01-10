module part2(out, X, Y,S);
	output	[3:0]out;
	input		[3:0]X,Y;
	input		S;
	
	assign out = ({4{S}}&X) | ({4{~S}}&Y);
	
endmodule