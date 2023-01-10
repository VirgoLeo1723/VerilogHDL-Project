module test(CLK, START, RESET, DATA_IN, ADDR_0, ADDR_1, FOUND);
	parameter 	INIT=3'b000, BEGIN=3'b001, FIND=3'b010, END=3'b011, WAIT=3'b100;
	input				CLK, START, RESET;
	input		[7:0] DATA_IN;
	
	output	[6:0] ADDR_0, ADDR_1;
	output	reg	FOUND;
	
	reg				done;
	reg		[7:0] data_temp;
	reg		[2:0] status		/*synthesis keep*/;
	reg		[4:0] left, right	/*synthesis keep*/;
	reg		[4:0]	address_out /*synthesis keep*/;
	
	wire		[7:0]	value_out	/*synthesis keep*/;
	
	ram32x8 (
	.address(address_out),
	.clock(CLK),
	.data(),
	.wren(),
	.q(value_out));
	
	control7SEG inst0 (.IN(address_out[3:0]), .OUT(ADDR_0));
	control7SEG inst1 (.IN(address_out[4])  , .OUT(ADDR_1));
	
	//Datapath
	always @(posedge CLK) begin
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
	always @(posedge CLK) begin
		case (status)
			INIT: begin
				data_temp 	<= data_in;
				left			<= 5'b00000;
				right			<= 5'b11111;
				address_out <= 5'b00000;
				
				done			<= 0;
				FOUND			<= 0;
			end
			BEGIN: begin
				address_out <= (left+right)/2;
			end
			WAIT: begin
			
			end
			FIND: begin
				if (data_temp > value_out) 		left 	<= address_out+1;
				else if (data_temp < value_out)  right <= address_out-1;
				else if (date_temp == value_out)begin 
					done	<= 1;
					FOUND <= 1;
				end
				else if (left >= right) begin
					done 	<= 1;
					FOUND <= 0;
				end
//				if (value_out == DATA_IN) begin
//					done 		<= 1;
//					FOUND 	<= 1;
//				end 
//				else begin
//				if (left == right) begin
//						done 		<= 1;
//						FOUND 	<= 0;
//					end 
//					else begin
//						if (DATA_IN > value_out) 
//							left 		<= address_out +1;
//						else 
//							right 	<= address_out -1;
//					end
//				end
			end
		
		endcase
	end
	
	
endmodule


