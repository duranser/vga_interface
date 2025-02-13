`timescale 1ns / 1ps



module vga_controller_tb();

	reg  pixel_clk = 0;
	reg  rst 	   = 0;
	wire VGA_HS;
	wire VGA_VS;
	wire data_en;

    vga_controller VGA(
        .pixel_clk(pixel_clk),
        .rst(rst),
        .VGA_HS(VGA_HS),
        .VGA_VS(VGA_VS),
        .data_en(data_en)
    );
    
    always #20 pixel_clk = ~pixel_clk;
    
    initial
    begin
        rst = 0;        
        repeat(20) @(posedge pixel_clk);
        rst = 1;
        repeat(20) @(posedge pixel_clk);
        rst = 0;        
        
        repeat(1000) @(posedge pixel_clk);
    end

endmodule
