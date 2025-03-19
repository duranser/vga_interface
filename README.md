# vga_interface
* **The Video Graphics Array (VGA)** is a standard interface for analog video monitors. The default VGA mode operates at a resolution of 640 × 480 pixels with a refresh rate of 60 Hz, meaning the screen is refreshed 60 times per second. Each pixel is composed of three colors—red (R), green (G), and blue (B)—with their intensity determined by an analog voltage ranging from 0V to 0.7V. The pixel signals are initially generated digitally and then converted to analog signals using digital-to-analog converters (DACs). These analog voltages create the image frames displayed on a video monitor.
* Pin configurations of a VGA connector can be seen below:
  
  ![image](https://github.com/user-attachments/assets/261bb38c-c773-4814-9925-0f5cb46d8796) [1]

* The default VGA frequency is 25 MHz. It includes five control signals: **Hsync** (horizontal synchronization), **Vsync** (vertical synchronization), **Hactive** (the portion of Hsync during which pixels are displayed), **Vactive** (the portion of Vsync during which lines of pixels are displayed), and **DENA** (display enable).
* **Hsync** and **Vsync** control when a new frame begins. **Hactive** and **Vactive** define the time intervals during which image pixels are displayed on the screen. Finally, **DENA** (display enable) manages turning the pixel signals on and off. These control signals—Hsync, Vsync, Hactive, Vactive, and DENA—determine the timing and configuration of the VGA mode.
* The waveform for horizontal timing diagram, based on pixel clock (pixel_clk), consist of four parts, each measured in pixels (i.e., clock cycles): **Hpulse** (width of the horizontal synchronization pulse), **HBP** (horizontal back porch), **Hactive** (active line display interval), and **HFP** (horizontal front porch)
* The vertical timing diagram also consists of four parts, each measured in lines or Hsync cycles: **Vpulse** (width of the vertical synchronization pulse), **VBP** (vertical back porch), **Vactive** (active column display interval), and **VFP** (vertical front porch).
* Timing diagrams of the control signals can be seen below:
  <img src="https://github.com/user-attachments/assets/6d725b34-5fea-4cbe-99f1-b1f7c210f8a6" width=70% height=70%> [2]

  <img src="https://github.com/user-attachments/assets/7a9260e8-35bf-4a9f-8ab8-165a72b3de25" width=70% height=70%> [2]

## Horizontal Test
* When the **Hactive** signal is high and **DENA** is enable, the VGA controller drives each pixel in a single line, consisting of 640 pixels.
* **horizontal_test.v** tests the **Hsync** and **Hactive** control signals. The expected result is a hardware generated image of which 1-160 lines are red, 161-320 lines are green, and 321-480 lines are blue colors.
  
  <img src="https://github.com/user-attachments/assets/13a0e440-5838-4fa0-b81d-0f47ebb24c8f" width=30% height=30%>


## Vertical Test
* When the **Vactive** signal is high and **DENA** is enable, the VGA controller drives each frame, which consists of 480 lines, with each line containing 640 pixels.
* **vertical_test.v** tests the **Vsync** and **Vactive** control signals. The expected result is hardware generated frames which are solid red, green, and blue colors. The frames should cycle between red, green, and blue every second.

  <img src="https://github.com/user-attachments/assets/f2f4162b-fb1c-4eb9-9bbe-56867807040f" width=25% height=25%>


## References
1. Nexys A7 Reference Manual, https://digilent.com/reference/programmable-logic/nexys-a7/reference-manual.
2. V. A. Pedroni, Circuit Design with VHDL. TheMit Press, 2010.

