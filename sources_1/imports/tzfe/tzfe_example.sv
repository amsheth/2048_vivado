module tzfe_example (
	input logic start,menu,
	input logic vga_clk,frame_clk, check_over,checkWin,
	input logic [9:0] DrawX, DrawY,movey,
	input logic blank,
	input logic [191:0]MatrixCopy,
	input logic [16:0] score,
	output logic [3:0] red, green, blue
);




logic start,menu;
logic vga_clk,frame_clk, check_over,checkWin;
logic [9:0] DrawX, DrawY,movey;
logic blank;
logic [191:0]MatrixCopy;
logic [16:0] score;
logic [3:0] red, green, blue;

logic [17:0] frontrom_address,backrom_address;
logic [9:0] number_address;
logic [3:0] rom_q;
logic [3:0] rom_Q;
logic [0:0] Rom_q;
logic [11:0] value,Drawx,Drawy;

logic [13:0] title_address;
logic [0:0] title_q;
logic [17:0] end_address;
logic [1:0] endrom_q;
logic [17:0] over_address;
logic [0:0] overrom_q;
logic [9:0] score_address;
logic [0:0] score_q;
logic [16:0] menu_address;
logic [0:0] menu_q;

logic [3:0] menu_red, menu_green, menu_blue;
logic [3:0] scorer, scoge, scobe;
logic [3:0] over_red, over_green, over_blue;
logic [3:0] endred, endgreen, endblue;
logic [3:0] Palette_Red, Palette_Green, Palette_Blue;
logic [3:0] palette_red, palette_green, palette_blue;
logic [3:0] Palette_red, Palette_green, Palette_blue;
logic [3:0] palette_Red, palette_Green, palette_Blue;

logic [8:0]blck1,blck2,blck3,blck4;
logic [1:0]x,y;
logic [4:0] number;
logic [11:0] Matrix[15:0];
logic [3:0]i;

logic [16:0]saved;
logic [16:0]savedsec;
logic [16:0]savedtri;
logic [16:0]savedquart;
logic [16:0]savedpent;
logic [16:0]savedhex;
logic [16:0]savedhept;
logic [16:0]savedoct;
logic [16:0]savednon;
logic [16:0]saveddeca;


logic negedge_vga_clk;
//logic [3:0]z,t,h,s;
/////////////////////////////////Score////////////////////////
int num,zero,ten,hund,thous,regnum,regzero,regten,reghund,regthous,Regnum,Regzero,Regten,Reghund,Regthous;
int num3,zero3,ten3,hund3,thous3,regnum3,regzero3,regten3,reghund3,regthous3,Regnum3,Regzero3,Regten3,Reghund3,Regthous3;
int num6,zero6,ten6,hund6,thous6,regnum6,regzero6,regten6,reghund6,regthous6,Regnum6,Regzero6,Regten6,Reghund6,Regthous6;
assign num=score;
assign zero=num%10;
assign ten=((num%100))/10;
assign hund=(num%1000)/100;
assign thous=((num%10000))/1000; //(hund*100+ten*10+zero)
assign regnum=saved;
assign regzero=regnum%10;
assign regten=((regnum%100))/10;
assign reghund=((regnum%1000))/100;
assign regthous=((regnum%10000))/1000;
assign Regnum=savedsec;
assign Regzero=Regnum%10;
assign Regten=((Regnum%100))/10;
assign Reghund=((Regnum%1000))/100;
assign Regthous=((Regnum%10000))/1000;

assign num3=savedtri;
assign zero3=num3%10;
assign ten3=((num3%100))/10;
assign hund3=((num3%1000))/100;
assign thous3=((num3%10000))/1000; //(hund*100+ten*10+zero)
assign regnum3=savedquart;
assign regzero3=regnum3%10;
assign regten3=((regnum3%100))/10;
assign reghund3=((regnum3%1000))/100;
assign regthous3=((regnum3%10000))/1000;
assign Regnum3=savedpent;
assign Regzero3=Regnum3%10;
assign Regten3=((Regnum3%100))/10;
assign Reghund3=((Regnum3%1000))/100;
assign Regthous3=((Regnum3%10000))/1000;



assign num6=savedhex;
assign zero6=num6%10;
assign ten6=((num6%100))/10;
assign hund6=((num6%1000))/100;
assign thous6=((num6%10000))/1000; //(hund*100+ten*10+zero)
assign regnum6=savedhept;
assign regzero6=regnum6%10;
assign regten6=((regnum6%100))/10;
assign reghund6=((regnum6%1000))/100;
assign regthous6=((regnum6%10000))/1000;
assign Regnum6=savedoct;
assign Regzero6=Regnum6%10;
assign Regten6=((Regnum6%100))/10;
assign Reghund6=((Regnum6%1000))/100;
assign Regthous6=((Regnum6%10000))/1000;

/////////////////////////////////Matrix///////////////////////
// read from ROM on negedge, set pixel on posedge
assign negedge_vga_clk = ~vga_clk;
assign blck1=9'd15;
assign blck2=9'd130;
assign blck3=9'd245;
assign blck4=9'd360;
assign Matrix[0] = MatrixCopy[11:0];
assign Matrix[1] = MatrixCopy[23:12];
assign Matrix[2] = MatrixCopy[35:24];
assign Matrix[3] = MatrixCopy[47:36];
assign Matrix[4] = MatrixCopy[59:48];
assign Matrix[5] = MatrixCopy[71:60];
assign Matrix[6] = MatrixCopy[83:72];
assign Matrix[7] = MatrixCopy[95:84];
assign Matrix[8] = MatrixCopy[107:96];
assign Matrix[9] = MatrixCopy[119:108];
assign Matrix[10] = MatrixCopy[131:120];
assign Matrix[11] = MatrixCopy[143:132];
assign Matrix[12] = MatrixCopy[155:144];
assign Matrix[13] = MatrixCopy[167:156];
assign Matrix[14] = MatrixCopy[179:168];
assign Matrix[15] = MatrixCopy[191:180];
/////////////////////////////////Display////////////////////////





assign backrom_address = ((DrawX * 480) / 480) + (((DrawY * 480) / 480) * 480);
always_ff @ (posedge vga_clk) begin
case (Matrix[i])
2 :begin
x=2'b0;
y=2'b0;
end
4 :begin
x=2'b1;
y=2'b0;
end
8 :begin
x=2'b10;
y=2'b0;
end
16 :begin
x=2'b11;
y=2'b0;
end
32 :begin
x=2'b00;
y=2'b01;
end
64 :begin
x=2'b01;
y=2'b01;
end
128 :begin
x=2'b10;
y=2'b01;
end
256 :begin
x=2'b11;
y=2'b01;
end
512:begin
x=2'b00;
y=2'b10;
end
1024 :begin
x=2'b01;
y=2'b00;
end
2048 :begin
x=2'b10;
y=2'b10;
end
0 :begin
x=2'b11;
y=2'b10;
end
default :begin
x=2'b11;
y=2'b10;
end 
endcase
//
//	reg_11 save1(.Clk(vga_clk), .Load(savedsec<saved), .Reset(0), .D(saved),.Q(savedsec));
//	reg_11 save2(.Clk(vga_clk), .Load(saved<score), .Reset(0), .D(score),.Q(saved));
	
	
	if ((saved<score)&&(start||check_over||checkWin)) begin
	saveddeca<=savednon;
	savednon<=savedoct;
	savedoct<=savedhept;
	savedhept<=savedhex;
	savedhex<=savedpent;
	savedpent<=savedquart;
	savedquart<=savedtri;
	savedtri<=savedsec;
	savedsec<=saved;
	saved<=score;
	end
	else if ((savedsec<score)&&(saved>score)&&(start||check_over||checkWin)) begin
	saveddeca<=savednon;
	savednon<=savedoct;
	savedoct<=savedhept;
	savedhept<=savedhex;
	savedhex<=savedpent;
	savedpent<=savedquart;
	savedquart<=savedtri;
	savedtri<=savedsec;
	savedsec<=score;
	end
	else if ((savedtri<score)&&(savedsec>score)&&(start||check_over||checkWin)) begin
	saveddeca<=savednon;
	savednon<=savedoct;
	savedoct<=savedhept;
	savedhept<=savedhex;
	savedhex<=savedpent;
	savedpent<=savedquart;
	savedquart<=savedtri;
	savedtri<=score;
	end
	else if ((savedquart<score)&&(savedtri>score)&&(start||check_over||checkWin)) begin
	saveddeca<=savednon;
	savednon<=savedoct;
	savedoct<=savedhept;
	savedhept<=savedhex;
	savedhex<=savedpent;
	savedpent<=savedquart;
	savedquart<=score;
	end
	else if ((savedpent<score)&&(savedquart>score)&&(start||check_over||checkWin)) begin
	saveddeca<=savednon;
	savednon<=savedoct;
	savedoct<=savedhept;
	savedhept<=savedhex;
	savedhex<=savedpent;
	savedpent<=score;
	end
	else if ((savedhex<score)&&(savedpent>score)&&(start||check_over||checkWin)) begin
	saveddeca<=savednon;
	savednon<=savedoct;
	savedoct<=savedhept;
	savedhept<=savedhex;
	savedhex<=score;
	end
	else if ((savedhept<score)&&(savedhex>score)&&(start||check_over||checkWin)) begin
	saveddeca<=savednon;
	savednon<=savedoct;
	savedoct<=savedhept;
	savedhept<=score;
	end
	else if ((savedoct<score)&&(savedhept>score)&&(start||check_over||checkWin)) begin
	saveddeca<=savednon;
	savednon<=savedoct;
	savedoct<=score;
	end

	if (DrawX<481)begin
		red <= palette_red;
		green <= palette_green;
		blue <= palette_blue;
		end
	if (~blank) begin
	red <= 4'h0;
	green <= 4'h0;
	blue <= 4'h0;
	end
	else if (menu)begin
	menu_address <= ((DrawX * 320) / 640) + (((DrawY * 240) / 480) * 320);
	red <= menu_red;
	green <= menu_green;
	blue <= menu_blue;
	end
	else if (check_over) begin
	over_address <= ((DrawX * 320) / 640) + (((DrawY * 240) / 480) * 320);
	red <= over_red;
	green <= over_green;
	blue <= over_blue;
	end
	else if (checkWin) begin
	end_address <= ((DrawX * 320) / 640) + ((((DrawY) * 240) / 480) * 320);
	red<=endred;
	green<=endgreen;
	blue<=endblue;
//	Palette_red<=0;
//	palette_red<=0;
//	palette_Red<=0;	
//	Palette_Red<=0;
//	palette_Green<=0;
//	Palette_green<=0;
//	palette_green<=0;
//	Palette_Green<=0;
//	palette_Blue<=0;
//	Palette_blue<=0;
//	palette_blue<=0;
//	Palette_Blue<=0;
	end

	else begin
	 if (DrawX>480) begin
		red <= 4'hf;
		green <= 4'he;
		blue <= 4'hc;
		if (DrawY>10&&DrawY<64)begin
		title_address <= ((DrawX * 160) / 160) + ((((DrawY-10) * 53) / 53) * 160);
		red<=Palette_Red;
		green <= Palette_Green;
		blue <= Palette_Blue;
		end
		if (DrawX>500&&DrawY>75&&DrawY<=100&&DrawX<600) begin
		score_address <= (((80+DrawX-500) * 80) / 200) + ((((DrawY-75) * 11) / 25) * 80) ;
		red<=scorer;
		green <= scoge;
		blue <= scobe;
		end
		if (DrawX>528&&DrawY>110&&DrawY<=132&&DrawX<544)begin
		number_address <= ((((thous)*16+DrawX -528)* 80) / 160) + ((((DrawY -110)* 11) / 22) * 80);
		red<=Palette_red;
		green <= Palette_green;
		blue <= Palette_blue;
		end
		if (DrawX>545&&DrawY>110&&DrawY<=132&&DrawX<561)begin
		number_address <= ((((hund)*16+DrawX -545)* 80) / 160	) + ((((DrawY -110)* 11) / 22) * 80);
		red<=Palette_red;
		green <= Palette_green;
		blue <= Palette_blue;
		end
		if (DrawX>562&&DrawY>110&&DrawY<=132&&DrawX<578)begin
		number_address <= ((((ten)*16+DrawX -562)* 80) / 160) + ((((DrawY -110)* 11) / 22) * 80);
		red<=Palette_red;
		green <= Palette_green;
		blue <= Palette_blue;
		end
		if (DrawX>579&&DrawY>110&&DrawY<=132&&DrawX<595)begin
		number_address <= ((((zero)*16+DrawX -579)* 80) / 160) + ((((DrawY -110)* 11) / 22) * 80);
		red<=Palette_red;
		green <= Palette_green;
		blue <= Palette_blue;
		end
		
		if (DrawX>480&&DrawY>170&&DrawY<=192&&DrawX<640) begin
		score_address <= (((DrawX-480) * 80) / 640) + ((((DrawY-170) * 11) / 22) * 80);//(((DrawX-480) * 80) / 160) + ((((DrawY-170) * 11) / 22) * 80) ;
		red<=scorer;
		green <= scoge;
		blue <= scobe;
		end
		
		
		if (DrawX>528&&DrawY>200&&DrawY<=222&&DrawX<544)begin
		number_address <= ((((regthous)*16+DrawX -528)* 80) / 160) + ((((DrawY -200)* 11) / 22) * 80);
		red<=Palette_red;
		green <= Palette_green;
		blue <= Palette_blue;
		end
		if (DrawX>545&&DrawY>200&&DrawY<=222&&DrawX<561)begin
		number_address <= ((((reghund)*16+DrawX -545)* 80) / 160	) + ((((DrawY -200)* 11) / 22) * 80);
		red<=Palette_red;
		green <= Palette_green;
		blue <= Palette_blue;
		end
		if (DrawX>562&&DrawY>200&&DrawY<=222&&DrawX<578)begin
		number_address <= ((((regten)*16+DrawX -562)* 80) / 160) + ((((DrawY -200)* 11) / 22) * 80);
		red<=Palette_red;
		green <= Palette_green;
		blue <= Palette_blue;
		end
		if (DrawX>579&&DrawY>200&&DrawY<=222&&DrawX<595)begin
		number_address <= ((((regzero)*16+DrawX -579)* 80) / 160) + ((((DrawY -200)* 11) / 22) * 80);
		red<=Palette_red;
		green <= Palette_green;
		blue <= Palette_blue;
		end
		
		
		if (DrawX>528&&DrawY>230&&DrawY<=252&&DrawX<544)begin
		number_address <= ((((Regthous)*16+DrawX -528)* 80) / 160) + ((((DrawY -230)* 11) / 22) * 80);
		red<=Palette_red;
		green <= Palette_green;
		blue <= Palette_blue;
		end
		if (DrawX>545&&DrawY>230&&DrawY<=252&&DrawX<561)begin
		number_address <= ((((Reghund)*16+DrawX -545)* 80) / 160	) + ((((DrawY -230)* 11) / 22) * 80);
		red<=Palette_red;
		green <= Palette_green;
		blue <= Palette_blue;
		end
		if (DrawX>562&&DrawY>230&&DrawY<=252&&DrawX<578)begin
		number_address <= ((((Regten)*16+DrawX -562)* 80) / 160) + ((((DrawY -230)* 11) / 22) * 80);
		red<=Palette_red;
		green <= Palette_green;
		blue <= Palette_blue;
		end
		if (DrawX>579&&DrawY>230&&DrawY<=252&&DrawX<595)begin
		number_address <= ((((Regzero)*16+DrawX -579)* 80) / 160) + ((((DrawY -230)* 11) / 22) * 80);
		red<=Palette_red;
		green <= Palette_green;
		blue <= Palette_blue;
		end
		
		if (DrawX>528&&DrawY>260&&DrawY<=282&&DrawX<544)begin
		number_address <= ((((thous3)*16+DrawX -528)* 80) / 160) + ((((DrawY -260)* 11) / 22) * 80);
		red<=Palette_red;
		green <= Palette_green;
		blue <= Palette_blue;
		end
		if (DrawX>545&&DrawY>260&&DrawY<=282&&DrawX<561)begin
		number_address <= ((((hund3)*16+DrawX -545)* 80) / 160	) + ((((DrawY -260)* 11) / 22) * 80);
		red<=Palette_red;
		green <= Palette_green;
		blue <= Palette_blue;
		end
		if (DrawX>562&&DrawY>260&&DrawY<=282&&DrawX<578)begin
		number_address <= ((((ten3)*16+DrawX -562)* 80) / 160) + ((((DrawY -260)* 11) / 22) * 80);
		red<=Palette_red;
		green <= Palette_green;
		blue <= Palette_blue;
		end
		if (DrawX>579&&DrawY>260&&DrawY<=282&&DrawX<595)begin
		number_address <= ((((zero3)*16+DrawX -579)* 80) / 160) + ((((DrawY -260)* 11) / 22) * 80);
		red<=Palette_red;
		green <= Palette_green;
		blue <= Palette_blue;
		end
		if (DrawX>528&&DrawY>290&&DrawY<=312&&DrawX<544)begin
		number_address <= ((((regthous3)*16+DrawX -528)* 80) / 160) + ((((DrawY -290)* 11) / 22) * 80);
		red<=Palette_red;
		green <= Palette_green;
		blue <= Palette_blue;
		end
		if (DrawX>545&&DrawY>290&&DrawY<=312&&DrawX<561)begin
		number_address <= ((((reghund3)*16+DrawX -545)* 80) / 160	) + ((((DrawY -290)* 11) / 22) * 80);
		red<=Palette_red;
		green <= Palette_green;
		blue <= Palette_blue;
		end
		if (DrawX>562&&DrawY>290&&DrawY<=312&&DrawX<578)begin
		number_address <= ((((regten3)*16+DrawX -562)* 80) / 160) + ((((DrawY -290)* 11) / 22) * 80);
		red<=Palette_red;
		green <= Palette_green;
		blue <= Palette_blue;
		end
		if (DrawX>579&&DrawY>290&&DrawY<=312&&DrawX<595)begin
		number_address <= ((((regzero3)*16+DrawX -579)* 80) / 160) + ((((DrawY -290)* 11) / 22) * 80);
		red<=Palette_red;
		green <= Palette_green;
		blue <= Palette_blue;
		end
		if (DrawX>528&&DrawY>320&&DrawY<=342&&DrawX<544)begin
		number_address <= ((((Regthous3)*16+DrawX -528)* 80) / 160) + ((((DrawY -320)* 11) / 22) * 80);
		red<=Palette_red;
		green <= Palette_green;
		blue <= Palette_blue;
		end
		if (DrawX>545&&DrawY>320&&DrawY<=342&&DrawX<561)begin
		number_address <= ((((Reghund3)*16+DrawX -545)* 80) / 160	) + ((((DrawY -320)* 11) / 22) * 80);
		red<=Palette_red;
		green <= Palette_green;
		blue <= Palette_blue;
		end
		if (DrawX>562&&DrawY>320&&DrawY<=342&&DrawX<578)begin
		number_address <= ((((Regten3)*16+DrawX -562)* 80) / 160) + ((((DrawY -320)* 11) / 22) * 80);
		red<=Palette_red;
		green <= Palette_green;
		blue <= Palette_blue;
		end
		if (DrawX>579&&DrawY>320&&DrawY<=342&&DrawX<595)begin
		number_address <= ((((Regzero3)*16+DrawX -579)* 80) / 160) + ((((DrawY -320)* 11) / 22) * 80);
		red<=Palette_red;
		green <= Palette_green;
		blue <= Palette_blue;
		end
		if (DrawX>528&&DrawY>350&&DrawY<=372&&DrawX<544)begin
		number_address <= ((((thous6)*16+DrawX -528)* 80) / 160) + ((((DrawY -350)* 11) / 22) * 80);
		red<=Palette_red;
		green <= Palette_green;
		blue <= Palette_blue;
		end
		if (DrawX>545&&DrawY>350&&DrawY<=372&&DrawX<561)begin
		number_address <= ((((hund6)*16+DrawX -545)* 80) / 160	) + ((((DrawY -350)* 11) / 22) * 80);
		red<=Palette_red;
		green <= Palette_green;
		blue <= Palette_blue;
		end
		if (DrawX>562&&DrawY>350&&DrawY<=372&&DrawX<578)begin
		number_address <= ((((ten6)*16+DrawX -562)* 80) / 160) + ((((DrawY -350)* 11) / 22) * 80);
		red<=Palette_red;
		green <= Palette_green;
		blue <= Palette_blue;
		end
		if (DrawX>579&&DrawY>350&&DrawY<=372&&DrawX<595)begin
		number_address <= ((((zero6)*16+DrawX -579)* 80) / 160) + ((((DrawY -350)* 11) / 22) * 80);
		red<=Palette_red;
		green <= Palette_green;
		blue <= Palette_blue;
		end
		if (DrawX>528&&DrawY>380&&DrawY<=402&&DrawX<544)begin
		number_address <= ((((regthous6)*16+DrawX -528)* 80) / 160) + ((((DrawY -380)* 11) / 22) * 80);
		red<=Palette_red;
		green <= Palette_green;
		blue <= Palette_blue;
		end
		if (DrawX>545&&DrawY>380&&DrawY<=402&&DrawX<561)begin
		number_address <= ((((reghund6)*16+DrawX -545)* 80) / 160	) + ((((DrawY -380)* 11) / 22) * 80);
		red<=Palette_red;
		green <= Palette_green;
		blue <= Palette_blue;
		end
		if (DrawX>562&&DrawY>380&&DrawY<=402&&DrawX<578)begin
		number_address <= ((((regten6)*16+DrawX -562)* 80) / 160) + ((((DrawY -380)* 11) / 22) * 80);
		red<=Palette_red;
		green <= Palette_green;
		blue <= Palette_blue;
		end
		if (DrawX>579&&DrawY>380&&DrawY<=402&&DrawX<595)begin
		number_address <= ((((regzero6)*16+DrawX -579)* 80) / 160) + ((((DrawY -380)* 11) / 22) * 80);
		red<=Palette_red;
		green <= Palette_green;
		blue <= Palette_blue;
		end
//				if (DrawX>528&&DrawY>410&&DrawY<=432&&DrawX<544)begin
//		number_address <= ((((Regthous6)*16+DrawX -528)* 80) / 160) + ((((DrawY -410)* 11) / 22) * 80);
//		red<=Palette_red;
//		green <= Palette_green;
//		blue <= Palette_blue;
//		end
//		if (DrawX>545&&DrawY>410&&DrawY<=432&&DrawX<561)begin
//		number_address <= ((((Reghund6)*16+DrawX -545)* 80) / 160	) + ((((DrawY -410)* 11) / 22) * 80);
//		red<=Palette_red;
//		green <= Palette_green;
//		blue <= Palette_blue;
//		end
//		if (DrawX>562&&DrawY>410&&DrawY<=432&&DrawX<578)begin
//		number_address <= ((((Regten6)*16+DrawX -562)* 80) / 160) + ((((DrawY -410)* 11) / 22) * 80);
//		red<=Palette_red;
//		green <= Palette_green;
//		blue <= Palette_blue;
//		end
//		if (DrawX>579&&DrawY>410&&DrawY<=432&&DrawX<595)begin
//		number_address <= ((((Regzero6)*16+DrawX -579)* 80) / 160) + ((((DrawY -410)* 11) / 22) * 80);
//		red<=Palette_red;
//		green <= Palette_green;
//		blue <= Palette_blue;
//		end
//				if (DrawX>528&&DrawY>440&&DrawY<=252&&DrawX<544)begin
//		number_address <= ((((Regthous)*16+DrawX -528)* 80) / 160) + ((((DrawY -440)* 11) / 22) * 80);
//		red<=Palette_red;
//		green <= Palette_green;
//		blue <= Palette_blue;
//		end
//		if (DrawX>545&&DrawY>440&&DrawY<=252&&DrawX<561)begin
//		number_address <= ((((Reghund)*16+DrawX -545)* 80) / 160	) + ((((DrawY -440)* 11) / 22) * 80);
//		red<=Palette_red;
//		green <= Palette_green;
//		blue <= Palette_blue;
//		end
//		if (DrawX>562&&DrawY>440&&DrawY<=252&&DrawX<578)begin
//		number_address <= ((((Regten)*16+DrawX -562)* 80) / 160) + ((((DrawY -440)* 11) / 22) * 80);
//		red<=Palette_red;
//		green <= Palette_green;
//		blue <= Palette_blue;
//		end
//		if (DrawX>579&&DrawY>440&&DrawY<=252&&DrawX<595)begin
//		number_address <= ((((Regzero)*16+DrawX -579)* 80) / 160) + ((((DrawY -440)* 11) / 22) * 80);
//		red<=Palette_red;
//		green <= Palette_green;
//		blue <= Palette_blue;
//		end

//		
		
		
		
		
		
	end
	
	if (DrawX>blck1&&DrawY>blck1&&DrawX<(blck1+100)&&DrawY<(blck1+100)) begin
	i<=0;
	frontrom_address<=(((x*100+DrawX-blck1) *400) / 400) + ((((y*100+DrawY-blck1) * 300) / 300) * 400);
	red <= palette_Red;
	green <= palette_Green;
	blue <= palette_Blue;
	end
	if (DrawX>blck1&&DrawY>blck2&&DrawX<(blck1+100)&&DrawY<(blck2+100)) begin
	i<=1;
	frontrom_address<=(((x*100+DrawX-blck1) *400) / 400) + ((((y*100+DrawY-blck2) * 300) / 300) * 400);
	red <= palette_Red;
	green <= palette_Green;
	blue <= palette_Blue;
	end
	if (DrawX>blck1&&DrawY>blck3&&DrawX<(blck1+100)&&DrawY<(blck3+100)) begin
	i<=2;
	frontrom_address<=(((x*100+DrawX-blck1) *400) / 400) + ((((y*100+DrawY-blck3) * 300) / 300) * 400);
	red <= palette_Red;
	green <= palette_Green;
	blue <= palette_Blue;
	end
	if (DrawX>blck1&&DrawY>blck4&&DrawX<(blck1+100)&&DrawY<(blck4+100)) begin
	i<=3;
	frontrom_address<=(((x*100+DrawX-blck1) *400) / 400) + ((((y*100+DrawY-blck4) * 300) / 300) * 400);
	red <= palette_Red;
	green <= palette_Green;
	blue <= palette_Blue;
	end
	if (DrawX>blck2&&DrawY>blck1&&DrawX<(blck2+100)&&DrawY<(blck1+100)) begin
	i<=4;
	frontrom_address<=(((x*100+DrawX-blck2) *400) / 400) + ((((y*100+DrawY-blck1) * 300) / 300) * 400);
	red <= palette_Red;
	green <= palette_Green;
	blue <= palette_Blue;
	end
	if (DrawX>blck2&&DrawY>blck2&&DrawX<(blck2+100)&&DrawY<(blck2+100)) begin
	i<=5;
	frontrom_address<=(((x*100+DrawX-blck2) *400) / 400) + ((((y*100+DrawY-blck2) * 300) / 300) * 400);
	red <= palette_Red;
	green <= palette_Green;
	blue <= palette_Blue;
	
	end
	if (DrawX>blck2&&DrawY>blck3&&DrawX<(blck2+100)&&DrawY<(blck3+100)) begin
	i<=6;
	frontrom_address<=(((x*100+DrawX-blck2) *400) / 400) + ((((y*100+DrawY-blck3) * 300) / 300) * 400);
	red <= palette_Red;
	green <= palette_Green;
	blue <= palette_Blue;
	end
	if (DrawX>blck2&&DrawY>blck4&&DrawX<(blck2+100)&&DrawY<460) begin
	i<=7;
	frontrom_address<=(((x*100+DrawX-blck2) *400) / 400) + ((((y*100+DrawY-blck4) * 300) / 300) * 400);
	red <= palette_Red;
	green <= palette_Green;
	blue <= palette_Blue;
	end
	if (DrawX>blck3&&DrawY>blck1&&DrawX<(blck3+100)&&DrawY<(blck1+100)) begin
	frontrom_address<=(((x*100+DrawX-blck3) *400) / 400) + ((((y*100+DrawY-blck1) * 300) / 300) * 400);
	red <= palette_Red;
	green <= palette_Green;
	blue <= palette_Blue;
	i<=8;
	end
	if (DrawX>blck3&&DrawY>blck2&&DrawX<(blck3+100)&&DrawY<(blck2+100)) begin
	i<=9;
	frontrom_address<=(((x*100+DrawX-blck3) *400) / 400) + ((((y*100+DrawY-blck2) * 300) / 300) * 400);
	red <= palette_Red;
	green <= palette_Green;
	blue <= palette_Blue;
	end
	if (DrawX>blck3&&DrawY>blck3&&DrawX<(blck3+100)&&DrawY<(blck3+100)) begin
	i<=10;
	frontrom_address<=(((x*100+DrawX-blck3) *400) / 400) + ((((y*100+DrawY-blck3) * 300) / 300) * 400);
	red <= palette_Red;
	green <= palette_Green;
	blue <= palette_Blue;
	end
	if (DrawX>blck3&&DrawY>blck4&&DrawX<(blck3+100)&&DrawY<460) begin
	i<=11;
	frontrom_address<=(((x*100+DrawX-blck3) *400) / 400) + ((((y*100+DrawY-blck4) * 300) / 300) * 400);
	red <= palette_Red;
	green <= palette_Green;
	blue <= palette_Blue;
	end
	if (DrawX>blck4&&DrawY>blck1&&DrawX<460&&DrawY<(blck1+100)) begin
	i<=12;
	frontrom_address<=(((x*100+DrawX-blck4) *400) / 400) + ((((y*100+DrawY-blck1) * 300) / 300) * 400);
	red <= palette_Red;
	green <= palette_Green;
	blue <= palette_Blue;
	end
	if (DrawX>blck4&&DrawY>blck2&&DrawX<460&&DrawY<230) begin
	i<=13;
	frontrom_address<=(((x*100+DrawX-blck4) *400) / 400) + ((((y*100+DrawY-blck2) * 300) / 300) * 400);
	red <= palette_Red;
	green <= palette_Green;
	blue <= palette_Blue;
	end
	if (DrawX>blck4&&DrawY>blck3&&DrawX<460&&DrawY<(blck3+100)) begin
	i<=14;
	frontrom_address<=(((x*100+DrawX-blck4) *400) / 400) + ((((y*100+DrawY-blck3) * 300) / 300) * 400);
	red <= palette_Red;
	green <= palette_Green;
	blue <= palette_Blue;
	end
	if (DrawX>blck4&&DrawY>blck4&&DrawX<(blck4+100)&&DrawY<(blck4+100)) begin
	i<=15;
	frontrom_address<=(((x*100+DrawX-blck4) *400) / 400) + ((((y*100+DrawY-blck4) * 300) / 300) * 400);
	red <= palette_Red;
	green <= palette_Green;
	blue <= palette_Blue;
	end
		
end
end



///////////////////////////rom and palettes//////////////
blk_mem_gen_0 blk_mem_gen_0(
	.clka   (negedge_vga_clk),
	.addra (frontrom_address),
	.douta       (rom_Q)
);

tiles_palette tiles_palette (
	.index (rom_Q),
	.red   (palette_Red),
	.green (palette_Green),
	.blue  (palette_Blue)
);
tzfe_rom tzfe_rom (
	.clka   (negedge_vga_clk),
	.addra (backrom_address),
	.douta       (rom_q)
);

tzfe_palette tzfe_palette (
	.index (rom_q),
	.red   (palette_red),
	.green (palette_green),
	.blue  (palette_blue)
);

numbers_rom numbers_rom (
	.clka   (negedge_vga_clk),
	.addra (number_address),
	.douta      (Rom_q)
);

numbers_palette numbers_palette (
	.index (Rom_q),
	.red   (Palette_red),
	.green (Palette_green),
	.blue  (Palette_blue)
);
title_rom title_rom (
	.clka   (negedge_vga_clk),
	.addra (title_address),
	.douta       (title_q)
);

title_palette title_palette (
	.index (title_q),
	.red   (Palette_Red),
	.green (Palette_Green),
	.blue  (Palette_Blue)
);
endgame_rom endgame_rom (
	.clka   (negedge_vga_clk),
	.addra (end_address),
	.douta       (endrom_q)
);

endgame_palette endgame_palette (
	.index (endrom_q),
	.red   (endred),
	.green (endgreen),
	.blue  (endblue)
);

gameover_rom gameover_rom (
	.clka   (negedge_vga_clk),
	.addra (over_address),
	.douta       (overrom_q)
);

gameover_palette gameover_palette (
	.index (overrom_q),
	.red   (over_red),
	.green (over_green),
	.blue  (over_blue)
);
TOP_rom TOP_rom (
	.clka   (negedge_vga_clk),
	.addra (score_address),
	.douta       (score_q)
);

TOP_palette TOP_palette (
	.index (score_q),
	.red   (scorer),
	.green (scoge),
	.blue  (scobe)
);

MENU_rom MENU_rom (
	.clka   (negedge_vga_clk),
	.addra (menu_address),
	.douta       (menu_q)
);

MENU_palette MENU_palette (
	.index (menu_q),
	.red   (menu_red),
	.green (menu_green),
	.blue  (menu_blue)
);
endmodule
