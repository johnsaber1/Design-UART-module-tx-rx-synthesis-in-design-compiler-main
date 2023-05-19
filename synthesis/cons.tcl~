
####################################################################################
# UART Constraints
# ----------------------------------------------------------------------------
#
# 0. Design Compiler variables
#
# 1. Master Clock Definitions
#
# 2. Generated Clock Definitions
#
# 3. Clock Uncertainties
#
# 4. Clock Latencies 
#
# 5. Clock Relationships
#
# 6. #set input/output delay on ports
#
# 7. Driving cells
#
# 8. Output load

####################################################################################
           #########################################################
                  #### Section 0 : DC Variables ####
           #########################################################
#################################################################################### 

# Prevent assign statements in the generated netlist (must be applied before compile command)
#set_fix_multiple_port_nets -all -buffer_constants -feedthroughs

#################################################################################### 
           #########################################################
                  #### Section 1 : Clock Definition ####
           #########################################################
#################################################################################### 
# 1. Master Clock Definitions 
# 2. Generated Clock Definitions
# 3. Clock Latencies
# 4. Clock Uncertainties
# 4. Clock Transitions
####################################################################################

set CLK_TX_NAME "tx_clk"
set CLK_RX_NAME "rx_clk"
set CLK_TX_PER 100
set CLK_RX_PER [expr $CLK_TX_PER/8]
set CLK_SETUP_SKEW 0.25
set CLK_HOLD_SKEW 0.05
set CLK_LAT 0
set CLK_RISE 0.1
set CLK_FALL 0.1

create_clock -name $CLK_TX_NAME -period $CLK_TX_PER -waveform "0 [expr $CLK_TX_PER/2]" [get_ports TX_CLK]
create_clock -name $CLK_RX_NAME -period $CLK_RX_PER -waveform "0 [expr $CLK_RX_PER/2]" [get_ports RX_CLK]
set_clock_uncertainty -setup $CLK_SETUP_SKEW [get_clocks [list $CLK_TX_NAME $CLK_RX_NAME]]
set_clock_uncertainty -hold $CLK_HOLD_SKEW [get_clocks list[$CLK_TX_NAME $CLK_RX_NAME]]
set_clock_transition -rise $CLK_RISE  [get_clocks list[$CLK_TX_NAME $CLK_RX_NAME]]
set_clock_transition -fall $CLK_FALL  [get_clocks list[$CLK_TX_NAME $CLK_RX_NAME]]
set_clock_latency $CLK_LAT [get_clocks list[$CLK_TX_NAME $CLK_RX_NAME]]

set_dont_touch_network list[$CLK_TX_NAME $CLK_RX_NAME] 

set_dont_touch_network [get_ports RST] 

####################################################################################
           #########################################################
                  #### Section 2 : Clocks Relationships ####
           #########################################################
####################################################################################



####################################################################################
           #########################################################
             #### Section 3 : #set input/output delay on ports ####
           #########################################################
####################################################################################

set in_delay  [expr 0.2*$CLK_TX_PER]
set out_delay [expr 0.2*$CLK_RX_PER]

#Constrain Input Paths TX
set_input_delay $in_delay -clock $CLK_TX_NAME [get_port TX_IN_P]
set_input_delay $in_delay -clock $CLK_TX_NAME [get_port TX_IN_V]
set_input_delay $in_delay -clock $CLK_TX_NAME [get_port parity_enable]
set_input_delay $in_delay -clock $CLK_TX_NAME [get_port parity_type]
#Constrain Input Paths RX
set_input_delay $in_delay -clock $CLK_RX_NAME [get_port RX_IN_S]
set_input_delay $in_delay -clock $CLK_RX_NAME [get_port Prescale]
#set_input_delay $in_delay -clock $CLK_RX_NAME [get_port parity_enable]
#set_input_delay $in_delay -clock $CLK_RX_NAME [get_port parity_type]


#Constrain Output Paths TX
set_output_delay $out_delay -clock $CLK_TX_NAME [get_port TX_OUT_S]
set_output_delay $out_delay -clock $CLK_TX_NAME [get_port TX_OUT_V]
#Constrain Output Paths RX
set_output_delay $out_delay -clock $CLK_RX_NAME [get_port RX_OUT_P]
set_output_delay $out_delay -clock $CLK_RX_NAME [get_port RX_OUT_V]

####################################################################################
           #########################################################
                  #### Section 4 : Driving cells ####
           #########################################################
####################################################################################

set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port TX_IN_P]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port TX_IN_V]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port parity_enable]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port parity_type]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port RX_IN_S]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port Prescale]


####################################################################################
           #########################################################
                  #### Section 5 : Output load ####
           #########################################################
####################################################################################
set load_value 50

set_load $load_value  [get_port TX_OUT_S]
set_load $load_value  [get_port TX_OUT_V]
set_load $load_value  [get_port RX_OUT_P]
set_load $load_value  [get_port RX_OUT_V]

####################################################################################
           #########################################################
                 #### Section 6 : Operating Condition ####
           #########################################################
####################################################################################

# Define the Worst Library for Max(#setup) analysis
# Define the Best Library for Min(hold) analysis

set_operating_conditions -min_library "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c" -min "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c" -max_library "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c" -max "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c"

####################################################################################
           #########################################################
                  #### Section 7 : wireload Model ####
           #########################################################
####################################################################################

set_wire_load_model -name tsmc13_wl30 -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c

####################################################################################
