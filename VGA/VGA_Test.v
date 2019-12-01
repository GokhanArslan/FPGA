`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Gokhan Arslan
//
// Create Date:   13:32:26 12/01/2019
// Design Name:   VGA_Top
// Module Name:   VGA_Test
// Project Name:  VGA
// Target Device:  Xilinx Spartan-6 XC6SLX9
// Tool versions:  
// Description: Verilog test fixture module
//
// Verilog Test Fixture created by ISE for module: VGA_Top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module VGA_Test;

	// Inputs
	reg iClk;
	reg iNRst;
	reg [7:0] iSw;

	// Outputs
	wire oHSync;
	wire oVSync;
	wire [7:0] oRGB;
	wire [7:0] oLED;

	// Instantiate the Unit Under Test (UUT)
	VGA_Top uut (
		.iClk(iClk), 
		.iNRst(iNRst), 
		.iSw(iSw), 
		.oHSync(oHSync), 
		.oVSync(oVSync), 
		.oRGB(oRGB), 
		.oLED(oLED)
	);

	initial begin
		// Initialize Inputs
		iClk = 0;
		iNRst = 1;
		iSw = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		while(1)
		begin
			iClk = ~iClk;
			#5;
		end
	end
      
endmodule

