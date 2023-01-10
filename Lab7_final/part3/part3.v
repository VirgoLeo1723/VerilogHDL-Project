module part3(CLK, RESET, IN, OUT);
	input 	CLK, RESET, IN; 
	output	OUT;
	wire 		out0, out1;
	
	assign OUT = out0 | out1;
	
	detector	detect0 (CLK, RESET, ~IN, out0); 
	detector detect1 (CLK, RESET,  IN, out1);
	
endmodule

module detector(CLK, RESET, IN, OUT);
	input 	CLK, RESET, IN;
	output	OUT;
	
	wire	ff0_out, ff1_out, ff2_out, ff3_out;
	wire	ff0_in, ff1_in, ff2_in, ff3_in; 
	
	D_FF state0 (.CLK(CLK), .RESET(RESET), .D(IN), .Q(ff1_in));
	D_FF state1 (.CLK(CLK), .RESET(RESET), .D(ff1_in), .Q(ff2_in));
	D_FF state2 (.CLK(CLK), .RESET(RESET), .D(ff2_in), .Q(ff3_in));
	D_FF state3 (.CLK(CLK), .RESET(RESET), .D(ff3_in), .Q(ff3_out));

	assign OUT = ff1_in & ff2_in & ff3_in & ff3_out;
	
	
endmodule

module D_FF(CLK, RESET, D, Q);
	input		CLK, RESET,D;
	output	reg Q;
	
	always @(posedge CLK or negedge RESET) begin
		if (!RESET) Q<=0;
		else Q<=D;
	end
	
endmodule