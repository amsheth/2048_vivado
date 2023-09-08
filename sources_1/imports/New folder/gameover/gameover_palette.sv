module gameover_palette (
	input logic [0:0] index,
	output logic [3:0] red, green, blue
);

localparam [0:1][11:0] palette = {
	{4'h0, 4'h0, 4'h0},
	{4'hE, 4'h3, 4'h1}
};

assign {red, green, blue} = palette[index];

endmodule
