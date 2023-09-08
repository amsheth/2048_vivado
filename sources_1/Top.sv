`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/12/2023 11:07:40 PM
// Design Name: 
// Module Name: Top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Top(
      input     clk, 
      input     btn1,btn2,btn3,btn4,rst,start,
      ///////// KEY /////////
      //input    [ 1: 0]   KEY,

      ///////// SW /////////
      input    [ 15: 0]   SW,

      ///////// LEDR /////////
      output   [ 15: 0]   LED,

      ///////// HEX /////////
      output   [ 6: 0]   HEX,
      output   [ 7: 0]   HEXAN,
    );
endmodule
