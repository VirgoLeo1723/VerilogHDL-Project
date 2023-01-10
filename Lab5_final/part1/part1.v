module part1 (CLK, RESET, ROLLOVER, COUNTER);
	input		CLK, RESET;
	output	ROLLOVER;
	output	[5:0]COUNTER;
	
	counter k_bits (.CLK(CLK), .RESET(RESET), .K(20) , .rollover(ROLLOVER), .Q(COUNTER));
	defparam k_bits.n = 5;
	
endmodule
module counter (CLK, RESET, K, rollover, Q);
	parameter n=4;
	
	input		[n-1:0]K;
	input 	CLK, RESET;
	
	output 	reg [n-1:0]Q;
	output	reg rollover;
	
	always @(posedge CLK) begin	
		if (Q==(K-2)) rollover=1;
		else rollover = 0;
	end
	
	always @(posedge CLK or negedge RESET) begin
		if (!RESET) Q<=0;
		else 
			if (rollover) Q<=0;
			else Q<=Q+1;
	end
endmodule