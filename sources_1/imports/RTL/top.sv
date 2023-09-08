//-------------------------------------------------------------------------
//                                                                       --
//                                                                       --
//      For use with ECE 385 Lab 62                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------
module top (

      ///////// Clocks /////////
      input     MAX10_CLK1_50, 
      input     btn1,btn2,btn3,btn4,rst,start,
      ///////// KEY /////////
      //input    [ 1: 0]   KEY,

      ///////// SW /////////
      input    [ 9: 0]   SW,

      ///////// LEDR /////////
      output   [ 9: 0]   LEDR,

      ///////// HEX /////////
      output   [ 6: 0]   HEX,
      output   [ 3: 0]   HEXAN,

      ///////// SDRAM /////////
//      output             DRAM_CLK,
//      output             DRAM_CKE,
//      output   [12: 0]   DRAM_ADDR,
//      output   [ 1: 0]   DRAM_BA,
//      inout    [15: 0]   DRAM_DQ,
//      output             DRAM_LDQM,
//      output             DRAM_UDQM,
//      output             DRAM_CS_N,
//      output             DRAM_WE_N,
//      output             DRAM_CAS_N,
//      output             DRAM_RAS_N,

      ///////// VGA /////////
      output             VGA_HS,
      output             VGA_VS,
      output   [ 3: 0]   VGA_R,
      output   [ 3: 0]   VGA_G,
      output   [ 3: 0]   VGA_B

);


logic Reset_h, vssig, blank, sync, VGA_Clk;
///////// Clocks /////////
logic     MAX10_CLK1_50;

///////// KEY /////////
logic    [ 1: 0]   KEY;

///////// SW /////////
logic    [ 9: 0]   SW;

///////// LEDR /////////
logic   [ 9: 0]   LEDR;

///////// HEX /////////
logic   [ 6: 0]   HEX;
logic   [ 3: 0]   HEXAN;


///////// SDRAM /////////
//logic             DRAM_CLK,
//logic             DRAM_CKE,
//logic   [12: 0]   DRAM_ADDR,
//logic   [ 1: 0]   DRAM_BA,
//inout    [15: 0]   DRAM_DQ,
//logic             DRAM_LDQM,
//logic             DRAM_UDQM,
//logic             DRAM_CS_N,
//logic             DRAM_WE_N,
//logic             DRAM_CAS_N,
//logic             DRAM_RAS_N,

///////// VGA /////////
logic             VGA_HS;
logic             VGA_VS;
logic   [ 3: 0]   VGA_R;
logic   [ 3: 0]   VGA_G;
logic   [ 3: 0]   VGA_B;


//=======================================================
//  REG/WIRE declarations
//=======================================================
	logic SPI0_CS_N, SPI0_SCLK, SPI0_MISO, SPI0_MOSI, USB_GPX, USB_IRQ, USB_RST,Ack,btn1,btn2,btn3,btn4,check_over,checkWin,rst,start,menu;
	logic [3:0] hex_num_4, hex_num_3, hex_num_1, hex_num_0,x,y,z,number; //4 bit input hex digits
	logic [1:0] signs,count;
	logic [1:0] hundreds;
	logic [9:0] DrawX, DrawY, ballxsig, ballysig, ballsizesig,movey;
	logic [16:0] score;
	logic [7:0] Red, Blue, Green;
	logic [7:0] keycode;
	logic [191:0] MatrixCopy;

//=======================================================
//  Structural coding
//=======================================================

	
	assign Ack=SW[2];
	assign USB_GPX = 1'b0;//GPX is not needed for standard USB host - set to 0 to prevent interrupt
	

	
	//HEX drivers to convert numbers to HEX output
//	HexDriver hex_driver4 (score[15:12], HEX3[6:0]);
//	assign HEX3[7] = 1'b1;
	
//	HexDriver hex_driver3 (score[11:8], HEX2[6:0]);
//	assign HEX2[7] = 1'b1;
	
//	HexDriver hex_driver1 (score[7:4], HEX1[6:0]);
//	assign HEX1[7] = 1'b1;
	
//	HexDriver hex_driver0 (score[3:0], HEX0[6:0]);
    display_hex hex_driver (.clk(MAX10_CLK1_50),.reset(Reset_h), .hex(score), .dots(), .sevenseg(HEX), .sevenseg_an(HEXAN));
	assign LEDR[0] =menu;
	assign LEDR[1]=count[0];
	assign LEDR[2]=count[1];
	
	//fill in the hundreds digit as well as the negative sign
//	assign LEDR[0]=btn1;
//	assign LEDR[1]=btn2;
//	assign LEDR[2]=btn3;
//	assign LEDR[3]=btn4;
	
	//Assign one button to reset
	assign {Reset_h}=(SW[0]||~rst);

	//Our A/D converter is only 12 bit
//	assign VGA_R = Red[3:0];
//	assign VGA_B = Blue[3:0];
//	assign VGA_G = Green[3:0];
	
	
//	Lab62_soc u0 (
//		.clk_clk                           (MAX10_CLK1_50),  //clk.clk
//		.reset_reset_n                     (1'b1),           //reset.reset_n
//		.altpll_0_locked_conduit_export    (),               //altpll_0_locked_conduit.export
//		.altpll_0_phasedone_conduit_export (),               //altpll_0_phasedone_conduit.export
//		.altpll_0_areset_conduit_export    (),               //altpll_0_areset_conduit.export
//		.key_external_connection_wire_export    (KEY),            //key_external_connection.export

//		//SDRAM
//		.sdram_clk_clk(DRAM_CLK),                            //clk_sdram.clk
//		.sdram_wire_addr(DRAM_ADDR),                         //sdram_wire.addr
//		.sdram_wire_ba(DRAM_BA),                             //.ba
//		.sdram_wire_cas_n(DRAM_CAS_N),                       //.cas_n
//		.sdram_wire_cke(DRAM_CKE),                           //.cke
//		.sdram_wire_cs_n(DRAM_CS_N),                         //.cs_n
//		.sdram_wire_dq(DRAM_DQ),                             //.dq
//		.sdram_wire_dqm({DRAM_UDQM,DRAM_LDQM}),              //.dqm
//		.sdram_wire_ras_n(DRAM_RAS_N),                       //.ras_n
//		.sdram_wire_we_n(DRAM_WE_N),                         //.we_n

//		//USB SPI	
//		.spi0_wire_SS_n(SPI0_CS_N),
//		.spi0_wire_MOSI(SPI0_MOSI),
//		.spi0_wire_MISO(SPI0_MISO),
//		.spi0_wire_SCLK(SPI0_SCLK),
		
//		//USB GPIO
//		.usb_rst_wire_export(USB_RST),
//		.usb_irq_wire_export(USB_IRQ),
//		.usb_gpx_wire_export(USB_GPX),
		
//		//LEDs and HEX
//		.hex_digits_wire_export({hex_num_4, hex_num_3, hex_num_1, hex_num_0}),
//		.leds_wire_export(),
//		.keycode_wire_export(keycode)

		
//	 );
reg clock;
wire [24:0] clkmax;
assign clkmax=25'h0fffff;
reg [24:0] clkdiv;


always @(posedge MAX10_CLK1_50)
     begin
        if (clkdiv == clkmax)
	  begin
             clock <= ~clock;
             clkdiv <= 0;
	  end
	else
          clkdiv <= clkdiv + 25'b1;
     end



//instantiate a vga_controller, ball, and color_mapper here with the ports.
//vga_controller vga(.Clk(MAX10_CLK1_50),.Reset(Reset_h),.hs(VGA_HS),.vs(VGA_VS),.pixel_clk(VGA_Clk),.blank(blank),.sync(),.DrawX(drawxsig),.DrawY(drawysig));
vga_controller vga ( // the provided VGA controller from Lab 6 and 7
	.Clk       (MAX10_CLK1_50),
	.Reset     (1'b0),
	.hs        (VGA_HS),
	.vs        (VGA_VS),
	.pixel_clk (VGA_Clk),
	.blank     (blank),
	.sync      (),
	.DrawX     (DrawX),
	.DrawY     (DrawY)
);

tzfe_example pic (
	.vga_clk (VGA_Clk),
	.DrawX   (DrawX), 
	.DrawY   (DrawY),
	.blank   (blank),
	.red     (VGA_R),
	.green   (VGA_G),
	.blue    (VGA_B),
	.MatrixCopy(MatrixCopy),
	.check_over,.checkWin,.score,.start,.menu(SW[3]||menu),.movey,.frame_clk(VGA_VS)
);
anime move(.frame_clk(VGA_VS),.movey(movey));
//inp inpt(.clk(clock),.keycode,.btn1,.btn2,.btn3,.btn4,.rst,.start,.menu);

games game(.Reset(Reset_h),.Clk(clock),.Start(SW[1]||start),.Ack(SW[2]),.MatrixCopy(MatrixCopy),.btn1,.btn2,.btn3,.btn4,.check_over(check_over),.checkWin(checkWin),.score);

//color_mapper cm(.BallX(ballxsig),.BallY(ballysig),.DrawX(drawxsig),.DrawY(drawysig),.Ball_size(ballsizesig),.Red(Red),.Green(Green),.Blue(Blue));
endmodule