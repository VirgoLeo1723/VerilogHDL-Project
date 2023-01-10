module display7SEG(in,out);
	input 	[3:0]in /*systhesis keep*/;
	output	reg[6:0]out;
	always @(in) begin
		if (in == 1) out = 7'b0000110;
		if (in == 2) out = 7'b0100100;
		if (in == 3) out = 7'b0110000;
		if (in == 4) out = 7'b0011001;
		if (in == 5) out = 7'b0010010;
		if (in == 6) out = 7'b0000010;
		if (in == 7) out = 7'b1111000;
		if (in == 8) out = 7'b0000000;
		if (in == 9) out = 7'b0001110;
		if (in == 0) out = 7'b1000000;
	end
endmodule