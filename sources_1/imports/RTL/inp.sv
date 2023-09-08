module inp(	input clk,
				input [7:0]keycode,
				//input [3:0]hex_num_4, hex_num_3,
				output btn1, btn2, btn3,btn4,rst,start,menu,
				output [1:0] count );

logic clk;
logic [7:0]keycode;
//input [3:0]hex_num_4, hex_num_3,
logic btn1, btn2, btn3,btn4,rst,start,menu;
logic [1:0] count;
//logic[1:0] count;	
//logic [7:0]keycode;
//assign keycode=(hex_num_4*10)+hex_num_3;
always_ff@(posedge clk) begin
if (count==1)begin 
btn1<=0;
btn2<=0;
btn3<=0;
btn4<=0;
rst<=0;
start<=0;
menu<=0;
count<=3;
end
else if (count==2)begin
	if (keycode==7'h16) begin
	btn3<=0;
	count<=2;
	end
	if (keycode==7'h1a) begin
	btn2<=0;
	count<=2;
	end
	if (keycode==7'h4) begin
	btn1<=0;
	count<=2;
	end
	if (keycode==7'h7) begin
	btn4<=0;
	count<=2;
	end 
	if (keycode==7'h15) begin
	rst<=1;
	menu<=1;
	count<=1;
	end
	if (keycode==7'h28) begin
	start<=1;
	menu<=1;
	count<=1;
	end
	if (keycode==7'h10) begin
	menu<=1;
	count<=1;
	end
end
else if (count==3) begin	
	if (keycode==7'h16) begin
	btn3<=1;
	count<=1;
	end
	if (keycode==7'h1a) begin
	btn2<=1;
	count<=1;
	end
	if (keycode==7'h4) begin
	btn1<=1;
	count<=1;
	end
	if (keycode==7'h7) begin
	btn4<=1;
	count<=1;
	end
	if (keycode==7'h15) begin
	rst<=1;
	count<=1;
	end
	if (keycode==7'h28) begin
	start<=1;
	count<=1;
	end
	if (keycode==7'h10) begin
	menu<=1;
	count<=2;
	end
end
else begin
	menu<=1;
	if (keycode==7'h15) begin
	rst<=1;
	menu<=1;
	count<=1;
	end
	if (keycode==7'h28) begin
	start<=1;
	menu<=1;
	count<=1;
	end

end
end
endmodule