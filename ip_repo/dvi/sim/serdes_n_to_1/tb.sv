//
// Testbench for serdes_n_to_1
//

timeunit 1ns;
timeprecision 100ps;


module tb;

   localparam GCLK_PERIOD = 20ns;
   localparam IOCLK_PERIOD = 4ns;
   localparam RESET_TIME = 10us;
   
   logic 			ioclk ;		// IO Clock network
   logic 			serdesstrobe ;	// Parallel data capture strobe
   logic 			reset ;		// Reset
   logic 			gclk ;		// Global clock
   logic [4:0] 		datain ;  	// Data for logic
   logic 			iob_data_out ;	// logic data
   
   serdes_5_to_1 UUT
	 (
	  .*
	  );

   initial begin : GCLK_GEN
	  gclk = 1'b0;
	  forever #(GCLK_PERIOD/2) gclk = ~gclk;
   end
	  
   initial begin : IOCLK_GEN
	  ioclk = 1'b0;
	  forever #(IOCLK_PERIOD/2) ioclk = ~ioclk;
   end

   initial begin : TEST
	  datain = 5'b10100;
	  serdesstrobe = 1'b0;
	  
	  // Reset UUT
	  reset = 1'b1;
	  #(RESET_TIME) reset = 1'b0;

	  
	  
	  // Wait some time for test
	  #100us;
	  $finish;
   end
   
   
endmodule // tb
