//
// SERDES 5 to 1
//

module serdes_5_to_1
  (
   input 	   ioclk , // IO Clock network
   input 	   serdesstrobe , // Parallel data capture strobe
   input 	   reset , // Reset
   input 	   gclk , // Global clock
   input [4:0] datain , // Data for output
   output 	   iob_data_out 	// output data
   );
   
   OSERDESE2
	 #(
	   .DATA_RATE_OQ("SDR"),
	   .DATA_WIDTH(5),
	   .TRISTATE_WIDTH(1),
	   .INIT_OQ(5'b00000),
	   .SERDES_MODE("MASTER")
	   )
   serdes
	 (
	  .CLK(ioclk),
	  .CLKDIV(gclk),
	  .D1(datain[0]),
	  .D2(datain[1]),
	  .D3(datain[2]),
	  .D4(datain[3]),
	  .D5(datain[4]),
	  .D6(1'b0),
	  .D7(1'b0),
	  .D8(1'b0),
	  .OCE(1'b1),
	  .OFB(),
	  .OQ(iob_data_out),
	  .RST(reset),
	  .SHIFTIN1(1'b0),
	  .SHIFTIN2(1'b0),
	  .SHIFTOUT1(),
	  .SHIFTOUT2(),
	  .TBYTEIN(1'b0),
	  .TBYTEOUT(),
	  .TCE(1'b0),
	  .TFB(),
	  .TQ(),
	  .T1(1'b0),
	  .T2(1'b0),
	  .T3(1'b0),
	  .T4(1'b0)
	  );
   
	 
   
endmodule
   
