module part2(CLK, D, Q, Q_n);
	input		D, CLK;
	output	Q, Q_n;
	
	wire Qa, Qb /* synthesis keep */;
	//RS_latch inst0(CLK, ~D, D, Qa, Qb);
	wire s_g, r_g;
	
	assign s_g = ~(D & CLK);
	assign r_g = ~(~D & CLK);
	assign Qa  = ~(Qb & s_g);
	assign Qb  = ~(Qa & r_g);
	
	assign Q = Qa;
	assign Q_n = Qb;
	
endmodule
