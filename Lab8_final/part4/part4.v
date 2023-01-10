module part4(CLK, RESET, WREN, ADDRESS_W, DATA_IN,
					display_in,		display_out,
					display_addr0, display_addr1,
					display_addw0, display_addw1					);
				
	input 	CLK, RESET, WREN;
	input		[4:0] ADDRESS_W;
	input		[3:0] DATA_IN;
	
	output	[6:0]display_in, display_out;	
	output	[6:0]display_addr0, display_addr1;
	output	[6:0]display_addw0, display_addw1;
	
	wire		[3:0]DATA_OUT;
	wire 		[6:0]ADDRESS_R;
	wire		SUB_CLK;
	
	counter subclk (.CLK(CLK), .RESET(RESET), .Q(), .K(50000000), .rollover(SUB_CLK), .EN());
	defparam subclk.n = 26;
	
	counter counter (.CLK(SUB_CLK), .RESET(RESET), .Q(ADDRESS_R), .K(32), .rollover(), .EN(WREN));
	defparam counter.n = 5;
	
	ram32x4 (.clock(CLK), .data(DATA_IN), .rdaddress(ADDRESS_R), .wraddress(ADDRESS_W), .wren(WREN), .q(DATA_OUT));
	
	control7SEG 	displayin	(.IN(DATA_IN), 			.OUT(display_in));
	control7SEG 	displayout	(.IN(DATA_OUT), 			.OUT(display_out));
	control7SEG 	displayadd0	(.IN(ADDRESS_R%16), 	.OUT(display_addr0));
	control7SEG 	displayadd1 (.IN(ADDRESS_R/16), 		.OUT(display_addr1));
	control7SEG		displayadd2 (.IN(ADDRESS_W%16), 	.OUT(display_addw0));
	control7SEG		displayadd3 (.IN(ADDRESS_W/16), 		.OUT(display_addw1));	
	
	
endmodule

module counter (CLK, RESET, Q, K, rollover, EN);
	parameter n=4;
	
	input		[n-1:0]K;
	input 	CLK, RESET, EN;
	
	output	reg [n-1:0]Q /*systhesis keep*/;
	output	reg rollover;
	
	always @(posedge CLK) begin	
		if (Q==(K-1)) rollover<=1;
		else rollover <= 0;
	end
	
	always @(posedge CLK or negedge RESET) begin
		if (!RESET) Q<=0;
		else if (!EN) Q<=Q+1;
	end
endmodule


module control7SEG (IN,OUT);
	input 		[3:0] IN;
	output reg 	[6:0] OUT;
	
	always begin
		case(IN)
			0:OUT=7'b1000000;
			1:OUT=7'b1111001;
			2:OUT=7'b0100100;
			3:OUT=7'b0110000;
			4:OUT=7'b0011001;
			5:OUT=7'b0010010;
			6:OUT=7'b0000010;
			7:OUT=7'b1111000;
			8:OUT=7'b0000000;
			9:OUT=7'b0011000;
			10:OUT=7'b0001000;
			11:OUT=7'b0000011;
			12:OUT=7'b1000110;
			13:OUT=7'b0100001;
			14:OUT=7'b0000110;
			15:OUT=7'b0001110;
		endcase
	end
endmodule				




