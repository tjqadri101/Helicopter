#Helicopter
==========


This project was the final project for my course "ECE 350L: Digital Systems". The grading rubric was as follows:
35% (0) it must work correctly,
15% (1) the processor must be used to implement the core hardware functionality with the exception of specialized FSMs, logic, or memory,
10% (2) some form of meaningful, external user input must be implemented (e.g., keyboard, mouse, button, etc.),
10% (3) some form of meaningful, external user output must be implemented (e.g., VGA, LCD, audio, etc.),
30% (4) documentation describing the design, specification and example assembly programs for the I/O interface, and all other relevant information required to understand and evaluate your design.

We decided to follow the suggested design goal: 
## An arcade-style or handheld game(s), typical 2D with scenery and collision detection, moving objects, etc. Usual interfaces include a controller (some buttons) and a custom display (LED arrays).

My partner Jonathan Reshef and I designed a version of the 2D Helicopter game which was displayed on a LED matrix and played via push-buttons on the Altera DE2 FPGA board. The processor to control this game was made in Verilog via the Altera Quartus software. An ALU module and a register file module (which had 32 registers) were built earlier in the semester and were later modified slightly when they were incorporated into the initial processor module. The readme files (pdf) for these initial modules can be found on the project page. A pdf for the ISA for the processor is also included on the project page. The initial processor (built for a hw assignment) was also modified to fulfill the needs of the final game and the readme for the original processor can also be found on the project page.

The FinalProject.Readme summarizes the features of the final game as well as its mechanics. All the modules used (apart from memory elements) were written in structural rather than behavioral verilog. The testProc.v file in the Helicopter_final folder is the top-level file for the final game. A link to a video showing a demo run is included below. 

[Demo Video](https://drive.google.com/file/d/0BztExegssaFSTWpSWnlGeU1qYms/edit?usp=sharing)
