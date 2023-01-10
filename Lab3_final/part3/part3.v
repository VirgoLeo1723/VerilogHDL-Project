module part3(CLK, D, Q, Q_n);
	input		D,CLK;
	output	Q, Q_n;
	
	wire 		Q_n_master, Q_n_slave 	/* synthesis keep */;	
	wire		Q_master, Q_slave 		/* synthesis keep */;
	
	D_latch	master (.CLK(~CLK),	.D(D), 			.Q(Q_master), 	.Q_n(Q_n_master));
	D_latch	slave	 (.CLK( CLK),	.D(Q_master),	.Q(Q_slave) , 	.Q_n(Q_n_slave));
	
	assign	Q 		= Q_slave;
	assign 	Q_n 	= Q_n_slave;
	
endmodule

module D_latch(CLK, D, Q, Q_n);
	input		D, CLK;
	output	Q, Q_n;
	
	wire Qa, Qb /* synthesis keep */;
	RS_latch inst0(CLK, ~D, D, Qa, Qb);
	assign Q = Qa;
	assign Q_n = Qb;
	
endmodule


module RS_latch(CLK, R, S, Qa, Qb);
	input		R, S, CLK;
	output	Qa, Qb;
	
	wire s_g, r_g /* synthesis keep */;
	assign s_g = ~(S & CLK);
	assign r_g = ~(R & CLK);
	assign Qa  = ~(Qb & s_g);
	assign Qb  = ~(Qa & r_g);
	
endmodule