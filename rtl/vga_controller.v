`timescale 1ns / 1ps


module vga_controller #(
	// horizontal timing parameters (default 640x480x60)
	parameter HPULSE  = 96,				// Hsync pulse
	parameter HBP     = 48,				// Back Porch
	parameter HACTIVE = 640,			// Horizontal pixels
	parameter HFP	  = 16,				// Front Porch
	parameter H1      = HPULSE,		
	parameter H2      = HPULSE+HBP,
	parameter H3      = HPULSE+HBP+HACTIVE,
	parameter H4      = HPULSE+HBP+HACTIVE+HFP,
	// vertical timing parameters (default 640x480x60)
	parameter VPULSE  = 2,             // Vsync pulse
	parameter VBP     = 33,            // Back Porch
	parameter VACTIVE = 480,           // Vertical pixels
	parameter VFP     = 10,            // Front Porch
	parameter V1      = VPULSE,
	parameter V2      = VPULSE+VBP,
	parameter V3      = VPULSE+VBP+VACTIVE,
	parameter V4      = VPULSE+VBP+VACTIVE+VFP
)(
	input  	 pixel_clk,		 // 25 MHz default
	input  	 rst,
	output   VGA_HS,
	output   VGA_VS,
	output   data_en
);
	reg  [$clog2(H4)-1:0] hcnt;
	reg  [$clog2(V4)-1:0] vcnt;
	reg  Hsync;
	reg  Vsync;
	reg  Hact;
	reg  Vact;
	
	assign VGA_HS = Hsync;
	assign VGA_VS = Vsync;
	assign data_en = Hact & Vact;

	// VGA Driver
	always @(posedge pixel_clk, posedge rst)
	begin
		if( rst )
		begin
			hcnt    <= 0;
			Hsync   <= 0;
			Hact    <= 0;
		end
		else 
		begin
			hcnt <= hcnt + 1;
			case( hcnt )
				H1: Hsync <= 1'b1;
				H2: Hact  <= 1'b1;
				H3: Hact  <= 1'b0;
				H4: begin 
				      Hsync <= 1'b0;		
				      hcnt  <= 0;
				    end
			   default: begin
			         Hsync <= Hsync;	
			         Hact  <= Hact;
			   end			
			endcase
		end
	end

	always @(negedge Hsync, posedge rst)
	begin
		if(rst)
		begin
			vcnt    <= 0;
			Vsync   <= 0;
			Vact    <= 0;		
		end
		else
		begin
			vcnt <= vcnt + 1;
			case( vcnt )
				V1: Vsync   <= 1'b1;
				V2: Vact    <= 1'b1;
				V3: Vact    <= 1'b0;
				V4: begin 
				      Vsync <= 1'b0;		
				      vcnt  <= 0;
				    end
			   default: begin
			         Vsync <= Vsync;	
			         Vact  <= Vact;
			   end		
			endcase						
		end
	end

endmodule