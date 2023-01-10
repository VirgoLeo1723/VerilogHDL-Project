module part2(CLK, RESET, IN, OUT, STATE);
	input		CLK, RESET, IN;
	output	OUT;
	output	[8:0]STATE;
	
	reg		[3:0]YQ, YD;
	parameter 	A = 4'b0000, 
					B = 4'b0001, 
					C = 4'b0010, 
					D = 4'b0011, 
					E = 4'b0100, 
					F = 4'b0101, 
					G = 4'b0110, 
					H = 4'b0111, 
					I = 4'b1000;
	
	always @(IN, YQ) begin
		case (YQ)
			A: begin if (IN) YD = F; else YD = B; end
			B: begin if (IN) YD = F; else YD = C; end
			C: begin if (IN) YD = F; else YD = D; end
			D: begin if (IN) YD = F; else YD = E; end
			E: begin if (IN) YD = F; else YD = E; end
			F: begin if (IN) YD = G; else YD = B; end
			G: begin if (IN) YD = H; else YD = B; end
			H: begin if (IN) YD = I; else YD = B; end
			I: begin if (IN) YD = I; else YD = B; end
			default: YD = 4'bxxxx;
		endcase
	end
	
	always @(posedge CLK) begin
		if (RESET) YQ<=YD;
		else YQ<=A;
	end
	
	change_signal inst0 (.in(YQ), .out(STATE));
	assign OUT = (YQ==E) | (YQ==I);
	
endmodule

module change_signal(in, out);
	input		[3:0]in;
	output	[8:0]out;
	
	assign out = (in==0) ? 9'b000000001: 
					 (in==1) ? 9'b000000010: 
					 (in==2) ? 9'b000000100: 
					 (in==3) ? 9'b000001000: 
					 (in==4) ? 9'b000010000: 
					 (in==5) ? 9'b000100000: 
					 (in==6) ? 9'b001000000: 
					 (in==7) ? 9'b010000000: 9'b100000000;
endmodule

