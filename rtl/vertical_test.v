`timescale 1ns / 1ps


/********************************************\
-- Hardware RGB image generator for VGA monitors
-- Nexsys A7 board (4-bit DACs)
\********************************************/

module vertical_test(
	input  	     clk,		 // 100 MHz
	input  	     rst,
	output       VGA_HS,	 // Horizontal sync
	output       VGA_VS,	 // Vertical sync
	output [3:0] VGA_R,		 // Red channel
	output [3:0] VGA_G,		 // Green channel
	output [3:0] VGA_B		 // Blue channel
);

	wire pixel_clk;
	wire dena;
	
	reg  [7:0] frame_cnt;
	reg  [3:0] red, green, blue;

    assign VGA_R = red;
    assign VGA_G = green;
    assign VGA_B = blue;    

	// CLK Divider 25MHz
	BUFR #(
	   .BUFR_DIVIDE("4"),   	// Values: "BYPASS, 1, 2, 3, 4, 5, 6, 7, 8"
	   .SIM_DEVICE("7SERIES")   // Must be set to "7SERIES"
	)
	BUFR_inst (
	   .O(pixel_clk),     // 1-bit output: Clock output port
	   .CE(1'b1),         // 1-bit input: Active high, clock enable (Divided modes only)
	   .CLR(1'b0),  	  // 1-bit input: Active high, asynchronous clear (Divided modes only)
	   .I(clk)        	  // 1-bit input: Clock buffer input driven by an IBUF, MMCM or local interconnect
	);
	
	// VGA Controller
	vga_controller VGA_CNT(
		.pixel_clk(pixel_clk),
		.rst(rst),
		.VGA_HS(VGA_HS),
		.VGA_VS(VGA_VS),
		.data_en(dena)
	);
	
	
	// Hardware Image Generator
	always @(posedge VGA_CNT.Vact, posedge rst)
	begin
		if(rst)
		begin
			frame_cnt  <= 0;
		end
		else
		begin
			if( frame_cnt == 179)	// 480 lines/rows
				frame_cnt  <= 0;	
			else
				frame_cnt <= frame_cnt + 1;
		end
	end


	always @(*)
	begin
		if( dena )
		begin
			if(frame_cnt < 60)
			begin
				red   <= 4'b1111;
				green <= 4'b0000;
				blue  <= 4'b0000;
			end
			else if( frame_cnt < 120 )
			begin
				red   <= 4'b0000;
				green <= 4'b1111;
				blue  <= 4'b0000;			
			end
			else
			begin
				red   <= 4'b0000;
				green <= 4'b0000;
				blue  <= 4'b1111;				
			end
		end
		else
		begin
			red   <= 4'b0000;
			green <= 4'b0000;
			blue  <= 4'b0000;			
		end
	end
endmodule
