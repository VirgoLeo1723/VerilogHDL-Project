module part3 (CLK, RESET, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	input		CLK, RESET;
	output	[6:0]HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	wire		[19:0]Q /*synthesis keep*/;
	wire		clk0, clk1, clk2, clk3 /*synthesis keep*/;
	reg 		clk1_bus, clk2_bus, clk3_bus /*synthesis keep*/;
	
	counter sub_clk (.CLK(CLK), .RESET(RESET), .K(500000), .rollover(clk0), .Q());
	defparam sub_clk.n = 19;

	counter bcd_1 (.CLK(clk0), .RESET(RESET), .K(100) , .rollover(clk1), . Q(Q[6:0]));
	defparam bcd_1.n = 7;
	counter bcd_2 (.CLK(clk1), .RESET(RESET), .K(60) , .rollover(clk2), . Q(Q[12:7]));
	defparam bcd_2.n = 6;
	counter bcd_3 (.CLK(clk2), .RESET(RESET), .K(60) , .rollover(clk3), . Q(Q[18:13]));
	defparam bcd_3.n = 6;
	
	display7SEG inst0 (.in(Q[6:0]%10), 		.out(HEX0));
	display7SEG inst1 (.in(Q[6:0]/10), 		.out(HEX1));
	display7SEG inst2 (.in(Q[12:7]%10), 	.out(HEX2));
	display7SEG inst3 (.in(Q[12:7]/10), 	.out(HEX3));
	display7SEG inst4 (.in(Q[18:13]%10), 	.out(HEX4));
	display7SEG inst5 (.in(Q[18:13]/10), 	.out(HEX5));
				
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
	input 	[3:0]in /*systhesis keep*/;
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