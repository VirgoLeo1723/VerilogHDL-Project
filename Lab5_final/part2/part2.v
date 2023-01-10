module part2 (CLK, RESET, HEX0, HEX1, HEX2);
	input		CLK, RESET;
	output	[6:0]HEX0, HEX1, HEX2;
	
	wire		[11:0]Q /*synthesis keep*/;
	wire		clk1, clk2, clk3 /*synthesis keep*/;
	reg 		clk1_bus, clk2_bus, clk3_bus /*synthesis keep*/;
	
	counter bcd_0 (.CLK(CLK), 	.RESET(RESET), .K(50000000) , .rollover(clk1), . Q());
	defparam bcd_0.n = 26;
	
	counter bcd_1 (.CLK(clk1), .RESET(RESET), .K(10) , .rollover(clk2), . Q(Q[3:0]));
	defparam bcd_1.n = 5;
	counter bcd_2 (.CLK(clk2), .RESET(RESET), .K(10) , .rollover(clk3), . Q(Q[7:4]));
	defparam bcd_2.n = 5;
	counter bcd_3 (.CLK(clk3), .RESET(RESET), .K(10) , .rollover(), 		. Q(Q[11:8]));
	defparam bcd_3.n = 5;	
	
	display7SEG(.in(Q[3:0]), .out(HEX0));
	display7SEG(.in(Q[7:4]), .out(HEX1));
	display7SEG(.in(Q[11:8]), .out(HEX2));
	
endmodule
module counter (CLK, RESET, K, Q, rollover);
	parameter n=4;
	
	input		[n-1:0]K;
	input 	CLK, RESET;
	
	output	reg [n-1:0]Q /*systhesis keep*/;
	output	reg rollover;
	reg over;
	
	always @(posedge CLK) begin	
		if (Q==(K-2)) over<=1;
		else over <= 0;
		
		if (Q==(K-1)) rollover <= 1;
		else rollover <= 0;
	end
	
	always @(posedge CLK or negedge RESET) begin
		if (!RESET) Q<=0;
		else 
			if (!over) Q<=Q+1;
			else Q<=0;
	end
	
endmodule

module display7SEG(in,out);
	input 	[3:0]in;
	output	reg[6:0]out;
	always @(in) begin
		if (in == 1) out = 7'b1111001;
		if (in == 2) out = 7'b0100100;
		if (in == 3) out = 7'b0110000;
		if (in == 4) out = 7'b0011001;
		if (in == 5) out = 7'b0010010;
		if (in == 6) out = 7'b0000010;
		if (in == 7) out = 7'b1111000;
		if (in == 8) out = 7'b0000000;
		if (in == 9) out = 7'b0010000;
		if (in == 0) out = 7'b1000000;
	end
endmodule