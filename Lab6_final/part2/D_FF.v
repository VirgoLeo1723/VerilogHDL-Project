module D_FF(CLK, RESET, D, Q);
	parameter n=1;
	input 	CLK, RESET;
	input 	[n-1:0]D;
	output	reg[n-1:0]Q;
	
	always @(posedge CLK or negedge RESET) begin
		if (!RESET) Q<=0;
		else if (CLK) Q<=D;
	end
endmodule