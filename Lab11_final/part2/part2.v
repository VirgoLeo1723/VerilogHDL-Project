module part2(CLK, START, RESET, DATA_IN, ADDR_0, ADDR_1, FOUND);
	parameter 	INIT=3'b000, BEGIN=3'b001, FIND=3'b010, END=3'b011, WAIT=3'b100;
	input				CLK, START, RESET;
	input		[7:0] DATA_IN;
	
	output	[6:0] ADDR_0, ADDR_1;
	output	reg	FOUND;
	
	reg				done, flag;
	reg		[2:0] status		/*synthesis keep*/;
	reg		[4:0] left, right	/*synthesis keep*/;
	reg		[4:0]	address_out /*synthesis keep*/;
	reg		[7:0] data_temp;
	reg		[26:0]Q;
	
	wire		[7:0]	value_out	/*synthesis keep*/;
	
	ram32x8 isnt_mem(
	.address(address_out),
	.clock(CLK),
	.data(),
	.wren(),
	.q(value_out));
	
	control7SEG inst0 (.IN(address_out[3:0]), .OUT(ADDR_0));
	control7SEG inst1 (.IN(address_out[4])  , .OUT(ADDR_1));
	
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
			INIT:		if (START==1)		status <= BEGIN;
			BEGIN: begin	
						if (done==1) 		status <= END;
						else					status <= WAIT;
					 end
			WAIT:								status <= FIND;
			FIND:								status <= BEGIN;
			END:		if (START==0)		status <= INIT;
		endcase
	end
	
	//FSM Control
	always @(posedge flag) begin
		case (status)
			INIT: begin
				data_temp 	<= DATA_IN;
				left			<= 5'b00000;
				right			<= 5'b11111;
				address_out <= 5'b00000;
				
				done			<= 0;
				FOUND			<= 0;
			end
			BEGIN: begin
				address_out <= (left+right)/2;
			end
			FIND: begin
				if (data_temp > value_out) 		left 	<= address_out+1;
				else if (data_temp < value_out)  right <= address_out-1;
				else if (data_temp == value_out)begin 
					done	<= 1;
					FOUND <= 1;
				end
				else if (left >= right) begin
					done 	<= 1;
					FOUND <= 0;
				end
			end
		
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



