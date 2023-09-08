module title_palette (
	input logic [0:0] index,
	output logic [3:0] red, green, blue
);

localparam [0:1][11:0] palette = {
	{4'hF, 4'hE, 4'hC},
	{4'hb, 4'ha, 4'ha}
};

assign {red, green, blue} = palette[index];

endmodule
