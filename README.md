#Helicopter
==========


This project was the final project for my course "ECE 350L: Digital Systems". My partner Jonathan Reshef and I designed a version of the 2D Helicopter game which was displayed on a LED matrix and played via push-buttons on the Altera DE2 FPGA board. The processor to control this game was made in Verilog via the Altera Quartus software. An ALU module and a register file module (which had 32 registers) were built earlier in the semester and were later modified slightly when they were incorporated into the initial processor module. The readme files (pdf) for these initial modules can be found on the project page. A pdf for the ISA for the processor is also included on the project page. The initial processor (built for a hw assignment) was also modified to fulfill the needs of the final game and the readme for the original processor can also be found on the project page.

The FinalProject.Readme summarizes the features of the final game as well as its mechanics. All the modules used (apart from memory elements) were written in structural rather than behavioral verilog. The testProc.v file in the Helicopter_final folder is the top-level file for the final game. A demo run is included below. 

[Demo Video](https://drive.google.com/file/d/0BztExegssaFSTWpSWnlGeU1qYms/edit?usp=sharing)
