module games( // , Done

input Clk, Reset,Start,Ack, btn1, btn2, btn3,btn4, 
output [191:0] MatrixCopy,
output check_over,checkWin,
output [16:0]score);


logic Clk, Reset,Start,Ack, btn1, btn2, btn3,btn4;
logic [191:0] MatrixCopy;
logic check_over,checkWin;
logic [16:0]score;


reg [11:0] Matrix[15:0];

logic [15:0] randCount;
reg [1:0] counterMove, counterMerge;
reg [3:0] buttonValue; 
reg [5:0] state;
reg flagDone;  
reg flagstate1,flagstate2,flagGen, flagGenState;
logic [11:0] gameend;
assign gameend=512;

reg [3:0] randNum,randNumFirstGen;
wire SymClk;
wire DPB, MCEN, CCEN, DbtnU, DbtnD, DbtnL, DbtnR;
sync s1(.Clk, .d(btn2),.q(DbtnL));
sync s2(.Clk, .d(btn4),.q(DbtnD));
sync s3(.Clk, .d(btn3),.q(DbtnR));
sync s4(.Clk, .d(btn1),.q(DbtnU));
integer i,j;


localparam
INI 	= 6'b000001,
Gen1 	= 6'b000010,
Gen2    = 6'b000100,
Move	= 6'b001000,
Merge	= 6'b010000,
Done	= 6'b100000;


assign check_over = ((Matrix[0] != Matrix[1]) && (Matrix[0] != Matrix[4]) && (Matrix[1] != Matrix[5]) && (Matrix[1] != Matrix[2]) &&(Matrix[2] != Matrix[6]) &&
	(Matrix[2] != Matrix[3]) && (Matrix[3] != Matrix[7]) && (Matrix[4] != Matrix[5]) && (Matrix[4] != Matrix[8]) && (Matrix[5] != Matrix[9]) && 
	(Matrix[5] != Matrix[6]) && (Matrix[6] != Matrix[7]) && (Matrix[6] != Matrix[10]) && (Matrix[7] != Matrix[11]) && (Matrix[8] != Matrix[9]) && 
	(Matrix[8] != Matrix[12]) && (Matrix[9] != Matrix[10]) && (Matrix[9] != Matrix[13]) && (Matrix[10] != Matrix[14]) && (Matrix[10] != Matrix[11]) && 
	(Matrix[11] != Matrix[15]) && (Matrix[12] != Matrix[13]) && (Matrix[13] != Matrix[14]) && (Matrix[14] != Matrix[15])&&(Matrix[0] != 0)&&
	(Matrix[1] != 0)&&(Matrix[2] != 0)&&(Matrix[3] != 0)&&(Matrix[4] != 0)&&(Matrix[5] != 0)
	&&(Matrix[6] != 0)&&(Matrix[7] != 0)&&(Matrix[8] != 0)&&(Matrix[9] != 0)&&(Matrix[10] != 0)
	&&(Matrix[11] != 0)&&(Matrix[12] != 0)&&(Matrix[13] != 0)&&(Matrix[14] != 0)&&(Matrix[15] != 0));

assign checkWin = ((Matrix[0] == gameend) || (Matrix[1] == gameend) || (Matrix[2] == gameend) || (Matrix[3] == gameend) || (Matrix[4] == gameend) || (Matrix[5] == gameend) || (Matrix[6] == gameend) || (Matrix[7] == gameend) || 
(Matrix[8] == gameend) || (Matrix[9] == gameend) || (Matrix[10] == gameend) || (Matrix[11] == gameend) || (Matrix[12] == gameend) || (Matrix[13] == gameend) || (Matrix[14] == gameend) || (Matrix[15] == gameend));
	

assign MatrixCopy = {Matrix[15],Matrix[14],Matrix[13],Matrix[12],Matrix[11],Matrix[10],Matrix[9],
						Matrix[8],Matrix[7],Matrix[6],Matrix[5],Matrix[4],Matrix[3],Matrix[2],Matrix[1],Matrix[0]};




	
//Counter for Random Number

always_ff @ (posedge Clk)
	begin
		if (Reset)
			randCount <=0;
		else if (randCount == 11'b11111111111)
			randCount <=0;
		else randCount <= randCount + 1;
	
	end

always_ff @ (posedge Clk) 
	begin
		if (Reset)
			begin
				state <= INI;
				 for(i=0; i<16; i= i+1) 
					begin
						Matrix[i] <= 0;
						score <=0;
					end
			end
		else
			begin
				case(state)
					INI:
						begin
							//state transition
							if (Start)
								state <= Gen1;
							//RTL
							randNum <= randCount[3:0];
							randNumFirstGen <= randCount[7:4];
							
							flagGen <= 1;
							flagGenState <=0;
							buttonValue <=0;
							flagDone <=0;
							
							for(i=0; i<16; i= i+1) 
								begin
									Matrix[i] <= 0;
								end		
						end
						
						
					Gen1:
						begin
							//state transition
							state <= Gen2;
						
							//RTL
							Matrix[randNumFirstGen] <= 2;
							
						end
						
					
					Gen2:
				
						begin
							//state transition
							if ((check_over || checkWin) && (flagGenState))
								state <= Done;
							if (((check_over==0)&& (flagGenState))||((Matrix[randNum] == 0) && (flagGenState)))  
								
								state <= Move;
							//RTL
							randNum <= randCount[3:0];
							if ((Matrix[randNum] == 0) && (flagGen))   
								begin
									Matrix[randNum] <= 2;       
									flagGen <= 0;
								end
						
								
							if (DbtnU) buttonValue <= 4'b0001;
							if (DbtnD) buttonValue <= 4'b0010;
							if (DbtnL) buttonValue <= 4'b0100;
							if (DbtnR) buttonValue <= 4'b1000;
							if (DbtnU|| DbtnL || DbtnR || DbtnD ) flagGenState <=1;
							flagstate1 <=0;
							flagstate2 <=0;
							counterMove <= 0;
							counterMerge <=0;
						end
						
					Move:
						begin
							//state transition
							if (flagstate1 ==1 )
								state <= Merge;							
								
							//RTL
							counterMove = 0;
							//UP MOVE
							if (buttonValue == 4'b0001)  //UP Pressed
								begin
									for (i = 0; i < 4; i = i + 1)				
										begin	
											
											for (j = 0; j < 4; j = j + 1)
												begin
													if (Matrix[i+4*j] == 0)
														counterMove = counterMove + 1;			
													else if (counterMove != 0)
														begin
															Matrix[i+4*j-4*counterMove] = Matrix[i+4*j];
															Matrix[i+4*j] = 0;
														end
													if (j == 3) counterMove = 0;
												end
										end
									flagstate1<=1;
									
								end
								
							//DOWN MOVE
							if (buttonValue == 4'b0010)  //DOWN Pressed
								begin
									for (i = 0; i < 4; i = i + 1)				
										begin	
											
											for (j = 3; j >= 0; j = j - 1)
												begin
													if (Matrix[i+4*j] == 0)
														counterMove = counterMove + 1;			
													else if (counterMove != 0)
														begin
															Matrix[i+4*j+4*counterMove] = Matrix[i+4*j];
															Matrix[i+4*j] = 0;
														end
													if (j == 0) counterMove = 0;
												end
										end
									flagstate1<=1;
									
								end
								
								//LEFT MOVE
							if (buttonValue == 4'b0100)  //LEFT Pressed
								begin
									for (j = 0; j < 4; j = j + 1)				
										begin	
											
											for (i = 0; i < 4; i = i + 1)
												begin
													if (Matrix[i+4*j] == 0)
														counterMove = counterMove + 1;			
													else if (counterMove != 0)
														begin
															Matrix[i+4*j-counterMove] = Matrix[i+4*j];
															Matrix[i+4*j] = 0; 
														end
													if (i == 3) counterMove = 0;
												end
										end
									flagstate1<=1;
								end
								
								//RIGHT MOVE
							if (buttonValue == 4'b1000)  //LEFT Pressed
								begin
									for (j = 0; j < 4; j = j + 1)				
										begin	
											
											for (i = 3; i >= 0; i = i - 1)
												begin
													if (Matrix[i+4*j] == 0)
														counterMove = counterMove + 1;			
													else if (counterMove != 0)
														begin
															Matrix[i+4*j+counterMove] = Matrix[i+4*j];
															Matrix[i+4*j] = 0; 
														end
													if (i == 0) counterMove = 0;
												end
										end
									flagstate1<=1;
								end
							
						flagGen <= 1; 
						
						end
						
					Merge:
						begin
							//state transition
							if ((flagstate2 == 1))
								state <= Gen2;   
							
							//RTL
							counterMerge = 0;
							//UP Merge 
							if (buttonValue == 4'b0001) 
								begin
										for (i = 0; i <4; i = i + 1)	
											begin
												for (j = 0; j < 3; j = j + 1)
													begin
														if (Matrix[i+4*j] == Matrix[i+4*j+4])
														begin
																Matrix[i+4*j] = 2*Matrix[i+4*j];
																score = score +Matrix[i+4*j];
																counterMerge = counterMerge + 1;	
																Matrix[i+4*j+4] = 0;
														end
														if ((counterMerge != 0) && (Matrix[i+4*j+4] != 0))
															begin
																Matrix[i+4*j] = Matrix[i+4*j+4];
																Matrix[i+4*j+4] = 0;
															end
														if (j == 2) counterMerge = 0;
													end
											end
										flagstate2 <= 1;	
								end
														
							//Down Merge
							if (buttonValue == 4'b0010) 
								begin
										for (i = 0; i <4; i = i + 1)	
											begin
												for (j = 3; j >0; j = j - 1)
													begin
														if (Matrix[i+4*j] == Matrix[i+4*j-4])
														begin
																Matrix[i+4*j] = 2*Matrix[i+4*j];
																score = score +Matrix[i+4*j];
																counterMerge = counterMerge + 1;	
																Matrix[i+4*j-4] = 0;
														end
														if ((counterMerge != 0) && (Matrix[i+4*j-4] != 0))
															begin
																Matrix[i+4*j] = Matrix[i+4*j-4];
																Matrix[i+4*j-4] = 0;
															end
														if (j == 1) counterMerge = 0;
													end
											end	
										flagstate2 <= 1;	
								end
								
								
								//LEFT Merge
							if (buttonValue == 4'b0100) 
								begin
										for (j = 0; j <4; j = j + 1)	
											begin
												for (i = 0; i < 3; i = i + 1)
													begin
														if (Matrix[i+4*j] == Matrix[i+4*j+1])
														begin
																Matrix[i+4*j] = 2*Matrix[i+4*j];
																score = score +Matrix[i+4*j];
																counterMerge = counterMerge + 1;	
																Matrix[i+4*j+1] = 0;
														end
														if ((counterMerge != 0) && (Matrix[i+4*j+1] != 0))
															begin
																Matrix[i+4*j] = Matrix[i+4*j+1];
																Matrix[i+4*j+1] = 0;
															end
														if (i == 2) counterMerge = 0;
													end
											end	
										flagstate2 <= 1;	
								end
								
							//Right Merge	
							if (buttonValue == 4'b1000)
								begin
										for (j = 0; j <4; j = j + 1)	
											begin
												for (i = 3; i > 0; i = i - 1)
													begin
														if (Matrix[i+4*j] == Matrix[i+4*j-1])
														begin
																Matrix[i+4*j] = 2*Matrix[i+4*j];
																score = score +Matrix[i+4*j];
																counterMerge = counterMerge + 1;	
																Matrix[i+4*j-1] = 0;
														end
														if ((counterMerge != 0) && (Matrix[i+4*j-1] != 0))
															begin
																Matrix[i+4*j] = Matrix[i+4*j-1];
																Matrix[i+4*j-1] = 0;
															end
														if (i == 1) counterMerge = 0;
													end
											end	
										flagstate2 <= 1;	
								end
						
						buttonValue <= 0;
						flagGenState <=0;
						end
						
						
						
					Done:
						begin
						//state transition
						if (Ack)
							state <= INI;
							
						//RTL
						flagDone <=1;
						
						
						end
					
				endcase		
			end				
							
	end					
						

				
			
			
endmodule
