`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.02.2019 18:00:10
// Design Name: 
// Module Name: tb
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

`timescale 1ns / 1ps

module tb;
   localparam V_FRAMEBF_ADDR = 32'h43C0_0000;
   localparam CONTROL_ADDR = V_FRAMEBF_ADDR + 0;
   localparam WIDTH_ADDR = V_FRAMEBF_ADDR + 'h10;
   localparam HEIGHT_ADDR = V_FRAMEBF_ADDR + 'h18;
   localparam STRIDE_ADDR = V_FRAMEBF_ADDR + 'h20;
   localparam MEMVIDFRM_ADDR = V_FRAMEBF_ADDR + 'h28;
   localparam PLANE1_ADDR = V_FRAMEBF_ADDR + 'h30;

   localparam WIDTH = 640;
   localparam HEIGHT = 480;
   localparam PIXEL_SIZE = 4;
   
   localparam MEM_ADDR = 'h10_0000;
   localparam MEM_SIZE = WIDTH * HEIGHT * PIXEL_SIZE;
   
   logic clk, resetn;
   wire  FIXED_IO_ps_clk, FIXED_IO_ps_porb, FIXED_IO_ps_srstb; 

   wire  vid_clk;
   wire [23:0] vid_data;
   wire        vid_hsync, vid_vsync;
   reg 	       resp;

   assign FIXED_IO_ps_clk = clk;
   assign FIXED_IO_ps_porb = resetn,
	 FIXED_IO_ps_srstb = resetn;

   initial begin : CLK_GEN
	  clk = 1'b0;
	  forever #15ns clk = ~clk;
   end
   
`define A tb.design_1_i.design_1_i.processing_system7_0.inst

   initial begin : TEST
      $display("TEST start");
      resetn = 1'b0;
      repeat(20) @(posedge clk);
      resetn = 1'b1;
      repeat(5) @(posedge clk);

      `A.fpga_soft_reset(32'h1);
      `A.fpga_soft_reset(32'h0);

      #1us;

      `A.write_data(WIDTH_ADDR, 4, 640, resp);
      `A.write_data(HEIGHT_ADDR,4, 480, resp);
      `A.write_data(STRIDE_ADDR,4, 0, resp);
      `A.write_data(MEMVIDFRM_ADDR,4, 20, resp);
      `A.write_data(PLANE1_ADDR,4, PLANE1_ADDR, resp);      
      `A.write_data(CONTROL_ADDR,4, 'h81, resp);
      
      #50ms;
      
      $finish;
      
   end

   design_1_wrapper  design_1_i
     (.DDR_addr(),
        .DDR_ba(),
        .DDR_cas_n(),
        .DDR_ck_n(),
        .DDR_ck_p(),
        .DDR_cke(),
        .DDR_cs_n(),
        .DDR_dm(),
        .DDR_dq(),
        .DDR_dqs_n(),
        .DDR_dqs_p(),
        .DDR_odt(),
        .DDR_ras_n(),
        .DDR_reset_n(),
        .DDR_we_n(),
        .FIXED_IO_ddr_vrn(),
        .FIXED_IO_ddr_vrp(),
        .FIXED_IO_mio(),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb)
	  );

   

endmodule
