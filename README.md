# AES
Implementation of the AES encryption on the software using C++ and a hardware implementation using VHDL.  

For the VHDL design, The overall resources consumption, using Xilinx Vivado's Synthesizer for a Zynq board:  
• 1433 SLice LUTs. (0.47%)  
• Slice FFs: 384. (0.06%)  
Achieved maximum frequency of 225 MHz.   

Achieved (comparatively) low-area design using one stage that represents a round as a feedback loop, hence utilizing less SBoxes and therefore better area utilization.  

Previous design contained ten-stage pipelined datapath that could process blocks in a pipelined fashion, but was approximately six times larger area-wise because each round had its own SBoxes.   
Implemented fully parallel KeyExpansion step as described in the following paper: https://eprint.iacr.org/2016/789.pdf   
MixColumns step is also accelerated using bitwise operations to carry out arithmetic over the Galois Field instead of precomuting and using a lookup table, which would be much slower and much more area-hogging.   
