//module part1(CLK, RESET, D_IN, DONE, RUN);
//	input		CLK, RESET, RUN;
//	input		[8:0]D_IN;
//	output	DONE;
//	
//	wire 		ime_out /*synthesis keep*/;
//	wire		ime_en  /*synthesis keep*/;
//	wire 		[2:0]alu_en;
//	wire		[7:0]mem_en;
//	wire		[9:0]mul_sl;
//	wire		[7:0]BUS;
//
//	control		inst0 	(	.CLK(CLK), .RESET(RESET), .CODE(ime_out), 
//									.alu_en(alu_en), .mem_en(mem_en), .mul_sl(mul_sl), .ime_en(ime_en), 
//									.DONE(DONE), .RUN(RUN) );
//	
//	ime_unit		ints1 	(	.CLK(CLK), .RESET(RESET), .EN(RUN), .IN(D_IN), 					.OUT(ime_out) 	);
//	mem_unit		inst2		(	.CLK(CLK), .RESET(RESET), .EN(mem_en), .IN({8{BUS}}), 			.OUT(mem_out)	);
//	multi_unit	inst3		(	.SELECT(mul_sl), 	.IN({D_IN,alu_out,mem_out}), 						.OUT(BUS) 		);
//	alu_unit		inst4		(	.CLK(CLK), .RESET(RESET), .EN(alu_en), .NUM1(BUS), .NUM2(BUS), .OUT(alu_out)	);
//endmodule
//
//module alu_unit(CLK, RESET, EN, NUM1, NUM2, OUT);
//	parameter	ADD=1'b0, SUB=1'b1;
//	parameter	A_EN=0, G_EN = 1, MODE = 2;
//	input		CLK, RESET;
//	input		[2:0]EN;
//	input		[8:0]NUM1, NUM2;
//	output	[8:0]OUT;
//	
//	wire		[8:0]A_OUT;
//	wire		[8:0]G_IN;
//	
//	D_FF	A_num	(.CLK(CLK), .RESET(RESET), .EN(EN[A_EN]), .D(NUM1), .Q(A_OUT));
//	D_FF	G_num (.CLK(CLK), .RESET(RESET), .EN(EN[G_EN]), .D(G_IN), .Q(OUT));
//
//	assign G_IN = (EN[MODE]==ADD) ? A_OUT+NUM2 : A_OUT-NUM2;
//endmodule
//
//module ime_unit(CLK, RESET, EN , IN, OUT);
//	input		CLK, EN, RESET;
//	input		[8:0]IN;
//	output	[8:0]OUT;
//	
//	D_FF ime 	(.CLK(CLK), .RESET(RESET), .EN(EN), .D(IN), .Q(OUT));
//
//endmodule
//
//module mem_unit(CLK, RESET, EN, IN, OUT);
//	parameter	REG0=0, REG1=1, REG2=2, REG3=3, REG4=4, REG5=5, REG6=6, REG7=7;  
//	input		CLK, RESET;
//	input		[7:0]	EN;
//	input		[71:0]IN;
//	output	[71:0]OUT;
//	
//	D_FF 	num0 	(.CLK(CLK), .RESET(RESET), .EN(EN[REG0]), .D(IN[8:0]), 	.Q(OUT[8:0]));
//	D_FF 	num1 	(.CLK(CLK), .RESET(RESET), .EN(EN[REG1]), .D(IN[17:9]), 	.Q(OUT[17:9]));
//	D_FF 	num2 	(.CLK(CLK), .RESET(RESET), .EN(EN[REG2]), .D(IN[26:18]), .Q(OUT[26:18]));
//	D_FF 	num3 	(.CLK(CLK), .RESET(RESET), .EN(EN[REG3]), .D(IN[35:27]), .Q(OUT[35:27]));
//	D_FF 	num4 	(.CLK(CLK), .RESET(RESET), .EN(EN[REG4]), .D(IN[44:36]), .Q(OUT[44:36]));
//	D_FF 	num5 	(.CLK(CLK), .RESET(RESET), .EN(EN[REG5]), .D(IN[53:45]), .Q(OUT[53:45]));
//	D_FF 	num6 	(.CLK(CLK), .RESET(RESET), .EN(EN[REG6]), .D(IN[62:54]), .Q(OUT[62:54]));
//	D_FF 	num7 	(.CLK(CLK), .RESET(RESET), .EN(EN[REG7]), .D(IN[71:63]), .Q(OUT[71:63]));
//	
//endmodule
//
//module multi_unit(SELECT, OUT, IN);
//	parameter	REG0=10'b0000000001, 
//					REG1=10'b0000000010, 
//					REG2=10'b0000000100, 
//					REG3=10'b0000001000, 
//					REG4=10'b0000010000, 
//					REG5=10'b0000100000, 
//					REG6=10'b0001000000, 
//					REG7=10'b0010000000, 
//					ALUO=10'b0100000000, 
//					D_IN=10'b1000000000;
//					
//	input		[9:0]SELECT;
//	input		[89:0]IN;
//	output	[8:0]OUT;
//	
//	assign 	OUT = (SELECT==REG0)?  IN[8:0]:
//						(SELECT==REG1)?  IN[17:9]:
//						(SELECT==REG2)?  IN[26:8]:
//						(SELECT==REG3)?  IN[35:27]:
//						(SELECT==REG4)?  IN[44:36]:
//						(SELECT==REG5)?  IN[53:45]:
//						(SELECT==REG6)?  IN[62:54]:
//						(SELECT==REG7)?  IN[71:63]:
//						(SELECT==ALUO)?  IN[80:72]: IN[89:81];
//
//endmodule
//
//module  control(CLK, RESET, CODE, RUN, DONE, alu_en, mem_en,  mul_sl, ime_en);
//					
//	parameter	BGN=3'b000, MV=3'b001, MVI=3'b010, ADD=3'b011, SUB=3'b100, LDY=3'b110, UPD=3'b111;
//	
//	input		CLK, RESET, RUN;
//	input		[8:0] CODE;
//	output	reg DONE;
//	output	ime_en;
//	output	reg [2:0]alu_en;
//	output	reg [7:0]mem_en;
//	output	reg [9:0]mul_sl;
//
//	wire		[2:0] Q_bus;
//	reg		[2:0] D_bus;
//	
//	D_FF fsm (.CLK(CLK), .RESET(RESET), .EN(), .Q(Q_bus), .D(D_bus));
//	
//	
//	
//	always @(posedge CLK) begin
//		case (Q_bus)
//			MV: begin
//				mul_sl <= {10{1'b0}} | (1<<CODE[2:0]-1);
//				mem_en <= { 8{1'b0}} | (1<<CODE[5:3]-1);
//				DONE 	 <= 1;
//			end
//			MVI: begin
//				mul_sl <= {10{1'b0}} | (1<<9);
//				mem_en <= { 8{1'b0}} | (1<<CODE[5:3]-1);
//				DONE 	 <= 1;
//			end
//			ADD: begin
//				mul_sl <= {10{1'b0}} | (1<<CODE[5:3]-1);
//				alu_en <= 3'b001;
//				DONE 	 <= 0;
//			end
//			SUB: begin
//				mul_sl <= {10{1'b0}} | (1<<CODE[5:3]-1);
//				alu_en <= 3'b101;
//				DONE 	 <= 0;
//			end
//			LDY: begin
//				mul_sl <= {10{1'b0}} | (1<<CODE[2:0]-1);
//				alu_en[1:0]  <= 2'b10;		
//				DONE <= 0;				
//			end
//			UPD: begin
//				mul_sl <= {10{1'b0}} | (1<<8);
//				mem_en <= { 8{1'b0}} | (1<<CODE[5:3]-1);
//				DONE 	 <= 1;
//			end
//			default: 
//				DONE 	 <=0 ;
//		endcase	
//	end
//	
//	// state of the machine                      
//	always @(RUN, Q_bus) begin
//		case (Q_bus)
//			ADD:begin
//				if (RUN) D_bus<=LDY;
//			end
//			SUB: begin
//				if (RUN) D_bus<=LDY;
//			end
//			LDY: begin
//				if (RUN) D_bus<=UPD;
//			end
//			default: D_bus<=CODE[8:6];
//			
//		
//		endcase
//	end
//	
//endmodule
//
//module D_FF(CLK, EN, RESET, Q, D);
//	input		CLK, EN, RESET;
//	input		[8:0]D;
//	output	reg [8:0]Q;
//	
//	always @(posedge CLK, negedge RESET)
//			if (!RESET) Q<=0;
//			else if (EN) Q<=D;
//	
//endmodule