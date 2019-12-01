`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:48:52 11/30/2019 
// Design Name: 
// Module Name:    VGA_Sync 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module VGA_Sync(
    input iClk,
    input iNRst,
    output oPixelTick,
    output oHSync,
    output oVSync,
    output oVideoOn,
    output [15:0] oPixelX,
    output [15:0] oPixelY
    );
	 
/* Horizontal display pixel size */	 
localparam HD = 640;

/* Horizontal front(left) border */
localparam HF = 48;

/* Horizontal back(right) border */
localparam HB = 16;

/* Horizontal retrace */
localparam HR = 96;

/* Vertical display pixel size */
localparam VD = 480;

/* Vertical front(top) border */
localparam VF = 10;

/* Vertical back(bottom) border */
localparam VB = 33;

/* Vertical retrace */
localparam VR = 2;



reg  [2:0]  clk_counter_reg;
wire [2:0]  clk_counter_next;
reg         pixel_tick;
reg  [15:0] h_counter_reg;
reg  [15:0] h_counter_next;
reg         h_sync_reg;
wire        h_sync_next;
wire        h_end;
reg  [15:0] v_counter_reg;
reg  [15:0] v_counter_next;
reg         v_sync_reg;
wire        v_sync_next;
wire        v_end;

initial
begin
	pixel_tick      = 1'b0;
	clk_counter_reg = 3'b000;
	h_counter_reg   = 15'd0;
	h_counter_next  = 15'd0;
	v_counter_reg   = 15'd0;
	v_counter_next  = 15'd0;
end


always @(posedge iClk)
begin
	if(~iNRst)
	begin
		h_counter_reg   <= 0;
		v_counter_reg   <= 0;
		clk_counter_reg <= 0;
	end
	else
	begin
		clk_counter_reg <= clk_counter_next;
		h_counter_reg   <= h_counter_next;
		v_counter_reg   <= v_counter_next;
		h_sync_reg      <= h_sync_next;
		v_sync_reg      <= v_sync_next;
		if(clk_counter_reg == 3'b001)
		begin
		   clk_counter_reg <= 3'b000;
			pixel_tick      <= ~pixel_tick;
		end
	end
end

assign clk_counter_next = clk_counter_reg + 1;

assign h_end = (h_counter_reg == (HD + HF + HB + HR - 1));
assign v_end = (v_counter_reg == (VD + VF + VB + VR - 1));

always @(posedge pixel_tick)
begin
	if(h_end)
	begin
		h_counter_next = 0;
	end
	else
	begin
		h_counter_next = h_counter_reg + 1;
	end
end

always @(posedge pixel_tick)
begin
	if(h_end)
	begin
		if(v_end)
		begin
			v_counter_next = 0;
		end
		else
		begin
			v_counter_next = v_counter_reg + 1;
		end
	end
end

assign h_sync_next = (h_counter_reg >= (HD + HB) && h_counter_reg <= (HD + HB + HR - 1));
assign v_sync_next = (v_counter_reg >= (VD + VB) && v_counter_reg <= (VD + VB + VR - 1));

assign oVideoOn   = (h_counter_reg < HD) && (v_counter_reg < VD);
assign oPixelX    = h_counter_reg;
assign oPixelY    = v_counter_reg;
assign oPixelTick = pixel_tick;
assign oHSync     = h_sync_reg;
assign oVSync     = v_sync_reg;

endmodule
