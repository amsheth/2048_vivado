module game(
input logic rst,
input logic clk,
output logic [3:0]number,
input logic [7:0]keycode
);
logic [3:0]x,y,newloc;

reg [10:0] randCount;
//Counter for Random Number
always @ (posedge clk)
	begin
		if (rst)
			randCount <=0;
		else if (randCount == 11'b11111111111)
			randCount <=0;
		else randCount <= randCount + 1;
	
	end
logic [3:0]tiles[3:0][3:0];
logic [3:0]prev=4'b1111;
always_ff @ (posedge clk) begin

if (rst) begin
	for(int i=0;i<4;i++)begin
		for(int j=0;j<4;j++) begin
		tiles[i][j]=4'b1111;
		end
	end
end
if (keycode==7'h7) begin
for (int i=0;i<4;i++)begin
	for (int j=0;j<4;j++)begin 
		if (tiles[i][j]!=4'b1111)begin 
			if (tiles[i][j]==prev)begin
			tiles[i][j]=tiles[i][j]+1;
			tiles[x][y]=4'b1111;
			prev=4'b1111;
			end
			else begin
			prev=tiles[i][j];
			x=i;
			y=j;
			end
		end
	end 
	tiles[newloc][3]=4'b0000;
end
end

else if (keycode==7'h1a) begin


end

else if (keycode==7'h16) begin

end

else if (keycode==7'h4) begin


end
end
endmodule