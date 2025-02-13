`timescale 1ns / 1ps



module vertical_test_tb();

	reg  clk      = 0;
	reg  rst 	  = 0;
	wire VGA_HS;
	wire VGA_VS;
    wire [3:0] VGA_R;
    wire [3:0] VGA_G;
    wire [3:0] VGA_B;    
    
    vertical_test VER(
        .clk(clk),
        .rst(rst),
        .VGA_HS(VGA_HS),
        .VGA_VS(VGA_VS),
        .VGA_R(VGA_R),
        .VGA_G(VGA_G),
        .VGA_B(VGA_B)
    );
    
    always #5 clk = ~clk;
    
    initial
    begin
        rst = 0;        
        repeat(20) @(posedge clk);
        rst = 1;
        repeat(20) @(posedge clk);
        rst = 0;        
        
        repeat(1000) @(posedge clk);
    end

endmodule
