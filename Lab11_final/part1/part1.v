module part1(CLK, RESET, S, DATA_IN, DONE, RESULT);
	parameter 	INIT=2'b00, BEGIN=2'b01, END=2'b11;
	
	input					CLK, RESET, S;
	input			[7:0] DATA_IN;	
	output reg			DONE;
	output 		[6:0] RESULT;
	
	reg		[1:0]	status = INIT 	/*synthesis keep*/;
	reg  		[7:0] a					/*synthesis keep*/;
	reg		[3:0] count;	
	reg		[26:0]Q;
	reg				flag;
	
	control7SEG inst (.IN(count), .OUT(RESULT));
	
	// 1 second
	always @(posedge CLK) begin
		if (Q == 50000000) flag<=1;
		else flag <= 0;
		
		if (!RESET | Q>50000000)  Q<= 0;
		else Q <= Q + 1;
	end
	
	//Datapath
	always @(posedge flag) begin
			case (status)
				INIT: 	if (S==1'b1) 	status <= BEGIN;
				BEGIN: 	if (a==0) 		status <= END;
				END: 		if (S==1'b0)	status <= INIT;
				default: status <= INIT;
			endcase
	end
	
	//FSM Control
	always @(posedge flag) begin
		case (status)
			INIT: begin
				count 	<= 0;
				DONE		<= 0;
				a 			<= DATA_IN;
			end
			BEGIN: begin
				if (a[0]==1'b1) count <= count + 1;
				a			<= a>>1;
			end
			END: begin
				DONE		<= 1;
			end
			default: status <= INIT;
		endcase
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

