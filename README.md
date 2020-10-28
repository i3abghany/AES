# AES
Implementation of the AES encryption on the software using C++ and a hardware implementation using VHDL.

For the VHDL design, The overall resources consumption, using Xilinx Vivado's Synthesizer for a Zynq board: <br>
• 1433 SLice LUTs. (0.47%) <br>
• Slice FFs: 304. (0.06%). <br>
Achieved maximum frequency of 333 Mhz. <br>

Achieved (comparatively) low-area design using one stage that represents a round as a feedback loop, hence utilizing less SBoxes and therefore better area utilization. <br>

Previous design contained ten-stage pipelined datapath that could process blocks in a pipelined fashion, but was approximately six times larger area-wise because each round had its own SBoxes. <br>
Implemented fully parallel KeyExpansion step as described in the following paper: https://eprint.iacr.org/2016/789.pdf <br>
MixColumns step is also accelerated using bitwise operations to carry out arithmetic over the Galois Field instead of precomuting and using a lookup table, which would be much slower and much more area-hogging. <br> 
