module part4(LEDR,KEY,SW,Clk);
	input [2:0]SW;
	input Clk;
	input [1:0]KEY; // 1 for signal to show code 0 for reset
	output reg LEDR;
	wire reset;
	wire [25:0] HALFSEC;
	wire [3:0]INDEX;
	reg half;
	reg [13:0] SIGNAL;
	reg [2:0]y_Q;
	reg [2:0]Y_D;
	parameter A=3'b000,B=3'b001,C=3'b010,D=3'b011,E=3'b100,F=3'b101,G=4'b110,H=3'b111;
	
	always@(SW)
	begin 
		case(SW)
			A: Y_D=A;
			B: Y_D=B;
			C: Y_D=C;
			D: Y_D=D;
			E: Y_D=E;
			F: Y_D=E;
			G: Y_D=G;
			H: Y_D=H;
		endcase
	end
	
	always@(posedge KEY[1]) begin
				y_Q = Y_D;
				case (y_Q)
				0: SIGNAL = 14'b00101110000000; // A
				1: SIGNAL = 14'b00111010101000; // B
				2: SIGNAL = 14'b00111010111010; // C
				3: SIGNAL = 14'b00111010100000; // D
				4: SIGNAL = 14'b00100000000000; // E
				5: SIGNAL = 14'b00101011101000; // F
				6: SIGNAL = 14'b00111011101000; // G
				7: SIGNAL = 14'b00101010100000; // H
				default : SIGNAL=14'bxxxxxxxxxxxx;
				endcase
	end
	counter_k_bit ins1(HALFSEC,Clk,KEY[0]);
	defparam ins1.n=26;
	defparam ins1.k=25000000;//25000000
	
	always @(negedge Clk) begin
		if(HALFSEC==24999999) half=1;//24999999
		else half=0;
	end
	
	assign reset=KEY[1] && KEY[0];
	
	counter_k_bit ins2(INDEX,half,reset);
	defparam  ins2.n=4;
	defparam  ins2.k=14;
	
	always begin
	   case (INDEX)
      0:LEDR = SIGNAL[13];
      1:LEDR= SIGNAL[12];
      2:LEDR= SIGNAL[11];
      3:LEDR= SIGNAL[10];
      4:LEDR= SIGNAL[9];
      5:LEDR= SIGNAL[8];
      6:LEDR= SIGNAL[7];
      7:LEDR= SIGNAL[6];
      8:LEDR= SIGNAL[5];
      9:LEDR= SIGNAL[4];
      10:LEDR= SIGNAL[3];
      11:LEDR= SIGNAL[2];
      12:LEDR= SIGNAL[1];
      13:LEDR= SIGNAL[0];
    endcase
	end
	
	
	endmodule 
	

module counter_k_bit(CONTENT,Clk,Reset);	
		parameter n=4;
		parameter k=10;
		input Clk,Reset;
		output reg[n-1:0] CONTENT;
		always @(posedge Clk or negedge Reset)
		begin 
			if(!Reset) CONTENT <= 0;
			else begin
				CONTENT<=CONTENT+1'b1;
				if(CONTENT>=k-1) CONTENT <= 0;
			end
		end
		
		endmodule