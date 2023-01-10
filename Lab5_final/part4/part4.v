module part4 (CLK, RESET, EN, code, led);
	input		CLK, RESET, EN;
	input		[2:0]code;
	output	led;

	reg 		[2:0]numb;
	wire		[12:0]decode	 /*synthesis keep*/;
	wire		time_start		 /*synthesis keep*/;
	
	
	
	counter 				sub_clk 	(.CLK(CLK), .RESET(RESET), .K(25000000), .rollover(time_start), .Q());
	translate_signal	inst0 	(.in(code), .out(decode));
	defparam sub_clk.n = 25;
	
	always @(posedge time_start) numb<=numb+1;
	assign led = decode[numb] & EN;
	
				
endmodule



module counter (CLK, RESET, K, Q, rollover);
	parameter n=4;
	
	input		[n-1:0]K;
	input 	CLK, RESET;
	
	output	reg [n-1:0]Q /*systhesis keep*/;
	output	reg rollover;
	reg over;
	
	always @(posedge CLK) begin	
		if (Q==(K-2)) rollover <= 1;
		else rollover <= 0;
	end
	
	always @(posedge CLK or negedge RESET) begin
		if (!RESET) Q<=0;
		else if (!rollover) Q<=Q+1;
			  else Q<=0;
	end
	
endmodule

module translate_signal(in, out);
	input		[3:0]in;
	output	reg [12:0]out;
	
	always begin
		if (in==0) out=13'b0000000111010;
		if (in==1) out=13'b0001010101110;
		if (in==2) out=13'b0101110101110;
		if (in==3) out=13'b0000010101110;
		if (in==5) out=13'b0001011101010;
		if (in==4) out=13'b0000000000010;
		if (in==6) out=13'b0001110111010;
		if (in==7) out=13'b0000010101010;
	end
endmodule