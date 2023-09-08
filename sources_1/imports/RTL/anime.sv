module anime(input frame_clk,
output[9:0] movey);
logic[10:0] textpos,textsize,textmax,textmin;
assign textmin=0;
assign textsize=0;
assign textmax=480;
endmodule
