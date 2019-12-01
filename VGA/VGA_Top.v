`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Gokhan Arslan
// 
// Create Date:    12:29:31 12/01/2019 
// Design Name: 
// Module Name:    VGA_Top 
// Project Name: 
// Target Devices: Xilinx Spartan-6 XC6SLX9
// Tool versions: 
// Description: VGA Top Module
//              Generates color signals according to pixel index for a test application 
//
// Dependencies: 
//
// Revision: 1.0.0
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module VGA_Top(
    input iClk,
    input iNRst,
    input [7:0] iSw,
    output oHSync,
    output oVSync,
    output [7:0] oRGB,
    output [7:0] oLED
    );

wire        video_on;
wire        pixel_tick;
reg  [7:0]  RGB_reg;
wire [15:0] pixel_x;
wire [15:0] pixel_y;

VGA_Sync vga_synchronizer_unit(.iClk(iClk),
                               .iNRst(iNRst),
										 .oPixelTick(pixel_tick),
										 .oHSync(oHSync),
										 .oVSync(oVSync),
										 .oVideoOn(video_on),
										 .oPixelX(pixel_x),
										 .oPixelY(pixel_y));

always @(posedge iClk)
begin
	if(~iNRst)
	begin
		RGB_reg <= 8'd0;
	end
	else
	begin
		//if(pixel_tick)
		begin
			if(pixel_x >= 0 && pixel_x < 160)
			begin
				RGB_reg[0] <= 1'b1;
				RGB_reg[1] <= 1'b1;
				RGB_reg[2] <= 1'b1;
				RGB_reg[3] <= 1'b0;
				RGB_reg[4] <= 1'b0;
				RGB_reg[5] <= 1'b0;
				RGB_reg[6] <= 1'b0;
				RGB_reg[7] <= 1'b0;
			end
			else if(pixel_x >= 160 && pixel_x < 320)
			begin
				RGB_reg[0] <= 1'b0;
				RGB_reg[1] <= 1'b0;
				RGB_reg[2] <= 1'b1;
				RGB_reg[3] <= 1'b1;
				RGB_reg[4] <= 1'b0;
				RGB_reg[5] <= 1'b0;
				RGB_reg[6] <= 1'b0;
				RGB_reg[7] <= 1'b0;
			end
			else if(pixel_x >= 320 && pixel_x < 480)
			begin
				RGB_reg[0] <= 1'b0;
				RGB_reg[1] <= 1'b0;
				RGB_reg[2] <= 1'b0;
				RGB_reg[3] <= 1'b1;
				RGB_reg[4] <= 1'b1;
				RGB_reg[5] <= 1'b0;
				RGB_reg[6] <= 1'b0;
				RGB_reg[7] <= 1'b0;
			end
			else if(pixel_x >= 480 && pixel_x < 640)
			begin
				RGB_reg[0] <= 1'b0;
				RGB_reg[1] <= 1'b0;
				RGB_reg[2] <= 1'b0;
				RGB_reg[3] <= 1'b0;
				RGB_reg[4] <= 1'b0;
				RGB_reg[5] <= 1'b1;
				RGB_reg[6] <= 1'b1;
				RGB_reg[7] <= 1'b1;
			end
		end
	end
end

assign oRGB = (video_on) ? RGB_reg : 8'd0;
assign oLED = iSw;

endmodule
