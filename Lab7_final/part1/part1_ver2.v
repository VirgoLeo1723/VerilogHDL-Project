module part1_ver2(CLK, RESET, IN, OUT);
	input		CLK, RESET, IN;
	output	OUT;
	
	wire	ff0_in, ff0_out;
	wire	ff1_in, ff1_out;
	wire	ff2_in, ff2_out;
	wire	ff3_in, ff3_out;
	wire	ff4_in, ff4_out;
	wire	ff5_in, ff5_out;
	wire	ff6_in, ff6_out;
	wire	ff7_in, ff7_out;
	wire	ff8_in, ff8_out;
	
	D_FF state0 (.CLK(CLK), .RESET(RESET), .D(ff0_in), .Q(ff0_out));
	D_FF state1 (.CLK(CLK), .RESET(RESET), .D(ff1_in), .Q(ff1_out));
	D_FF state2 (.CLK(CLK), .RESET(RESET), .D(ff2_in), .Q(ff2_out));
	D_FF state3 (.CLK(CLK), .RESET(RESET), .D(ff3_in), .Q(ff3_out));
	D_FF state4 (.CLK(CLK), .RESET(RESET), .D(ff4_in), .Q(ff4_out));
	D_FF state5 (.CLK(CLK), .RESET(RESET), .D(ff5_in), .Q(ff5_out));
	D_FF state6 (.CLK(CLK), .RESET(RESET), .D(ff6_in), .Q(ff6_out));
	D_FF state7 (.CLK(CLK), .RESET(RESET), .D(ff7_in), .Q(ff7_out));
	D_FF state8 (.CLK(CLK), .RESET(RESET), .D(ff8_in), .Q(ff8_out));
	
	assign ff0_in = IN;
	assign ff1_in = ~(ff0_out | 0);
	assign ff2_in =   ff0_out & ff1_out & ff3_out & ffe;
	assign ff3_in =   ff2_out & ff2_in;
	
	assign OUT = ff3_out;
	
endmodule 

module D_FF(CLK, RESET, D, Q);
	input		CLK, RESET,D;
	output	reg Q;
	
	always @(posedge CLK or negedge RESET) begin
		if (!RESET) Q<=0;
		else Q<=D;
	end
endmodule