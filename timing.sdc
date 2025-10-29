## Generated SDC file "timing.sdc"

## Copyright (C) 1991-2013 Altera Corporation
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, Altera MegaCore Function License 
## Agreement, or other applicable license agreement, including, 
## without limitation, that your use is for the sole purpose of 
## programming logic devices manufactured by Altera and sold by 
## Altera or its authorized distributors.  Please refer to the 
## applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus II"
## VERSION "Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"

## DATE    "Thu Aug 14 20:22:06 2025"

##
## DEVICE  "EP4CGX110DF31C7"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {clk} -period 20.000 -waveform { 10.000 20.000 } [get_ports *]


#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {clk}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {clk}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {clk}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {clk}]  0.020  


#**************************************************************
# Set Input Delay
#**************************************************************

set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[0]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[1]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[2]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[3]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[4]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[5]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[6]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[7]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[8]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[9]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[10]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[11]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[12]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[13]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[14]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[15]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[16]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[17]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[18]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[19]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[20]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[21]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[22]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[23]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[24]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[25]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[26]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[27]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[28]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[29]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[30]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[31]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[32]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[33]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[34]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[35]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[36]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[37]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[38]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[39]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[40]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[41]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[42]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[43]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[44]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[45]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[46]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[47]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[48]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[49]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[50]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[51]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[52]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[53]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[54]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[55]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[56]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[57]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[58]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[59]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[60]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[61]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[62]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[63]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[64]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[65]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[66]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[67]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[68]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[69]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[70]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[71]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[72]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[73]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[74]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[75]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[76]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[77]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[78]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[79]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[80]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[81]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[82]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[83]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[84]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[85]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[86]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[87]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[88]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[89]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[90]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[91]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[92]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[93]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[94]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[95]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[96]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[97]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[98]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[99]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[100]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[101]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[102]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[103]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[104]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[105]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[106]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[107]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[108]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[109]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[110]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[111]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[112]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[113]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[114]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[115]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[116]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[117]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[118]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[119]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[120]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[121]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[122]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[123]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[124]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[125]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[126]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {key[127]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[0]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[1]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[2]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[3]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[4]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[5]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[6]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[7]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[8]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[9]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[10]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[11]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[12]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[13]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[14]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[15]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[16]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[17]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[18]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[19]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[20]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[21]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[22]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[23]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[24]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[25]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[26]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[27]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[28]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[29]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[30]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[31]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[32]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[33]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[34]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[35]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[36]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[37]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[38]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[39]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[40]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[41]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[42]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[43]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[44]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[45]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[46]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[47]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[48]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[49]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[50]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[51]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[52]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[53]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[54]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[55]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[56]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[57]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[58]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[59]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[60]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[61]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[62]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[63]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[64]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[65]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[66]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[67]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[68]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[69]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[70]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[71]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[72]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[73]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[74]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[75]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[76]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[77]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[78]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[79]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[80]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[81]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[82]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[83]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[84]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[85]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[86]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[87]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[88]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[89]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[90]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[91]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[92]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[93]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[94]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[95]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[96]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[97]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[98]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[99]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[100]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[101]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[102]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[103]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[104]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[105]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[106]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[107]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[108]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[109]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[110]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[111]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[112]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[113]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[114]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[115]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[116]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[117]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[118]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[119]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[120]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[121]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[122]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[123]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[124]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[125]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[126]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {plaintext[127]}]


#**************************************************************
# Set Output Delay
#**************************************************************

set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[0]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[1]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[2]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[3]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[4]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[5]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[6]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[7]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[8]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[9]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[10]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[11]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[12]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[13]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[14]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[15]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[16]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[17]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[18]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[19]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[20]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[21]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[22]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[23]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[24]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[25]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[26]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[27]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[28]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[29]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[30]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[31]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[32]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[33]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[34]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[35]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[36]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[37]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[38]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[39]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[40]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[41]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[42]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[43]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[44]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[45]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[46]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[47]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[48]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[49]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[50]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[51]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[52]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[53]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[54]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[55]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[56]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[57]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[58]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[59]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[60]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[61]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[62]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[63]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[64]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[65]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[66]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[67]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[68]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[69]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[70]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[71]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[72]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[73]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[74]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[75]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[76]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[77]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[78]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[79]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[80]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[81]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[82]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[83]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[84]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[85]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[86]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[87]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[88]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[89]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[90]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[91]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[92]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[93]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[94]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[95]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[96]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[97]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[98]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[99]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[100]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[101]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[102]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[103]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[104]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[105]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[106]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[107]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[108]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[109]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[110]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[111]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[112]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[113]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[114]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[115]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[116]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[117]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[118]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[119]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[120]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[121]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[122]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[123]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[124]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[125]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[126]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.100 [get_ports {cypher[127]}]


#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

