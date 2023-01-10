module pro(CLK,D_IN, RUN, RESET, DONE, BUS);
	input		[8:0]		D_IN;
	input					CLK, RESET, RUN;
	output	[8:0] 	BUS /*synthesis keep*/;
	output				DONE;
	
	wire		[8:0] 	reg0_out, reg1_out, reg2_out, reg3_out, reg4_out, reg5_out, reg6_out, reg7_out, regA_out, regG_out /*synthesis keep*/;
	wire		[8:0]		addsub_out /*synthesis keep*/;
	wire		[9:0]		reg_en /*synthesis keep*/;
	wire		[9:0]		multi_select /*synthesis keep*/;
	wire		[8:0] 	CODE /*synthesis keep*/;
	wire					MODE /*synthesis keep*/;
	
	regn	reg0 (.CLK(CLK), .EN(reg_en[0]), .IN(BUS), .OUT(reg0_out));
	regn	reg1 (.CLK(CLK), .EN(reg_en[1]), .IN(BUS), .OUT(reg1_out));
	regn	reg2 (.CLK(CLK), .EN(reg_en[2]), .IN(BUS), .OUT(reg2_out));
	regn	reg3 (.CLK(CLK), .EN(reg_en[3]), .IN(BUS), .OUT(reg3_out));
	regn	reg4 (.CLK(CLK), .EN(reg_en[4]), .IN(BUS), .OUT(reg4_out));
	regn	reg5 (.CLK(CLK), .EN(reg_en[5]), .IN(BUS), .OUT(reg5_out));
	regn	reg6 (.CLK(CLK), .EN(reg_en[6]), .IN(BUS), .OUT(reg6_out));
	regn	reg7 (.CLK(CLK), .EN(reg_en[7]), .IN(BUS), .OUT(reg7_out));
	regn	regA (.CLK(CLK), .EN(reg_en[8]), .IN(BUS), .OUT(regA_out));
	regn	regG (.CLK(CLK), .EN(reg_en[9]), .IN(addsub_out), .OUT(regG_out));
	regn	regI (.CLK(CLK), .EN(RUN), .IN(D_IN), .OUT(CODE));
	
	multiplexer inst0 (.IN0(reg0_out), .IN1(reg1_out), .IN2(reg2_out), .IN3(reg3_out), .IN4(reg4_out), 
							 .IN5(reg5_out), .IN6(reg6_out), .IN7(reg7_out), .IN8(regG_out), .IN9(D_IN), 
							 .SELECT(multi_select), .OUT(BUS));
							 
	addsub		inst1 (.MODE(MODE), .IN0(regA_out), .IN1(BUS), .OUT(addsub_out));
	
	control		inst2	(.CLK(CLK), .RUN(RUN), .RESET(RESET), .DONE(DONE), .CODE(CODE),
							 .REG_EN(reg_en), .MULTI_SELECT(multi_select), .MODE(MODE));
endmodule

module control(CLK, CODE, RUN, RESET, DONE, MODE, REG_EN, MULTI_SELECT);
	parameter MV=3'b000, MVI=3'b001, ADD=3'b010, SUB=3'b011, LDY=3'b100, UDX=3'b101, LDI=3'b110;  
	input		[8:0]		CODE;
	input					RUN, RESET, CLK;
	
	output	reg [9:0]	REG_EN;
	output	reg [9:0]	MULTI_SELECT;
	output	reg			DONE, MODE;
	
	reg		[2:0]		fsm_in, fsm_out /*synthesis keep */;

	
	//FSM
	always @(posedge CLK) begin
		fsm_out <= fsm_in;
	end
	
	always @(CODE) begin
		case (fsm_out)
			MV: fsm_in = CODE [8:6];
			MVI:fsm_in = LDI;
			ADD:fsm_in = LDY;
			SUB:fsm_in = LDY;
			LDY:fsm_in = UDX;
			UDX:fsm_in = CODE [8:6];
			default: fsm_in = CODE [8:6];
		endcase
	end
	
	//Control
	always @(fsm_in) begin
			if (fsm_in==MV) begin 
				MULTI_SELECT = {10{1'b0}} | (1<<CODE[2:0]);
				REG_EN 		 = {10{1'b0}} | (1<<CODE[5:3]);
				DONE			 = 1 ;
			end else 
			if (fsm_in==MVI) begin
				MULTI_SELECT = {10{1'b0}} | (1<<9);
				REG_EN 		 = {10{1'b0}} | (1<<CODE[5:3]);
				DONE			 = 0 ;
			end else
			if (fsm_in==LDI) begin
				REG_EN 		 = {10{1'b0}} | (0<<CODE[5:3]);
				DONE			 = 1 ;
			end else 
			if (fsm_in==ADD | fsm_in==SUB) begin
				MULTI_SELECT = {10{1'b0}} | (1<<CODE[5:3]);
				REG_EN 		 = {10{1'b0}} | (1<<8);
				DONE			 = 0 ;
			end else 
			if (fsm_in==LDY) begin
				MULTI_SELECT = {10{1'b0}} | (1<<CODE[2:0]);
				REG_EN 		 = {10{1'b0}} | (1<<9);
				DONE			 = 0 ;
			end else
			if (fsm_in==UDX) begin
				MULTI_SELECT = {10{1'b0}} | (1<<8);
				REG_EN 		 = {10{1'b0}} | (1<<CODE[5:3]);
				DONE			 = 1 ; 
			end
			
			if (fsm_in==ADD) MODE = 1'b0 ;
			if (fsm_out==SUB)MODE = 1'b1 ;
			
		end

endmodule

module multiplexer(IN0, IN1, IN2, IN3, IN4, IN5, IN6, IN7, IN8, IN9, SELECT, OUT);
	input		[8:0] 	IN0, IN1, IN2, IN3, IN4, IN5, IN6, IN7, IN8, IN9;
	input		[9:0]		SELECT;
	output	[8:0]		OUT /*synthesis keep*/;
	
	assign	OUT = IN0 & {9{SELECT[0]}} |
						IN1 & {9{SELECT[1]}} |
						IN2 & {9{SELECT[2]}} |
						IN3 & {9{SELECT[3]}} |
						IN4 & {9{SELECT[4]}} |
						IN5 & {9{SELECT[5]}} |
						IN6 & {9{SELECT[6]}} |
						IN7 & {9{SELECT[7]}} |
						IN8 & {9{SELECT[8]}} |
						IN9 & {9{SELECT[9]}} ;
endmodule

module addsub(MODE, IN0, IN1, OUT);
	parameter ADD=1'b0, SUB=1'b1;
	
	input		[8:0]	IN0, IN1 /*synthesis keep*/;
	input				MODE;
	output 	reg[8:0]	OUT;
	
	
	always @(IN0, IN1) begin
		if (MODE==ADD) OUT = IN1 + IN0;
		else OUT = IN1 - IN0;
	end
	
	
endmodule

module regn(IN, EN, CLK, OUT);
parameter n = 9;
	input 	[n-1:0] IN;
	input 	EN, CLK;
	output 	reg [n-1:0] OUT;
		
	always @(posedge CLK)
		if (EN)
			OUT <= IN;
endmodule