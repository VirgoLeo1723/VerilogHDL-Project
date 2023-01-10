module part5(A,B,C_IN,S0,S1);
	input C_IN;
	input [3:0]A, B;
	output[1:0]S0,S1;
	
	wire[4:0]sum;
	
	reg[1:0]S0,S1;
	
	reg[3:0]tmp;
	reg[1:0]carry;
	
	assign sum = A+B+C_IN;
	
	always @(A or B) begin
		

		if (sum>9) begin
			carry <= 1;
			tmp <= 10;
		end
		else begin
			carry <= 0;
			tmp <= 0;
		end
		
		S0 <= sum - tmp;
		S1 <= carry;
		
	end
	
endmodule