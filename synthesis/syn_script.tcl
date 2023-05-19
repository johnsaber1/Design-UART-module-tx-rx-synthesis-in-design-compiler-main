set_svf UART.svf
                                                   

################## Design Compiler Library Files ######################

lappend search_path /home/IC/Labs/Ass_Syn_2.0/std_cells
lappend search_path /home/IC/Labs/Ass_Syn_2.0/rtl
lappend search_path /home/IC/Labs/Ass_Syn_2.0/rtl/UART_TX
lappend search_path /home/IC/Labs/Ass_Syn_2.0/rtl/UART_RX
lappend search_path /home/IC/Labs/Ass_Syn_2.0/rtl/UART_TOP

set SSLIB "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"

## Standard Cell libraries 
set target_library [list $SSLIB $TTLIB $FFLIB]

## Standard Cell & Hard Macros libraries 
set link_library [list * $SSLIB $TTLIB $FFLIB]  
#echo "###############################################"
#echo "############# Reading RTL Files  ##############"
#echo "###############################################"

#TX
read_file -format verilog mux.v
read_file -format verilog parity_calc.v
read_file -format verilog Serializer.v
read_file -format verilog uart_tx_fsm.v
read_file -format verilog UART_TX.v
#RX
read_file -format verilog data_sampling.v
read_file -format verilog deserializer.v
read_file -format verilog edge_bit_counter.v
read_file -format verilog par_chk.v
read_file -format verilog stp_chk.v
read_file -format verilog strt_chk.v
read_file -format verilog UART_RX.v
read_file -format verilog uart_rx_fsm.v
#UART TOP
read_file -format verilog UART_TOP/UART.v


###################### Defining toplevel ###################################
current_design UART

#################### Liniking All The Design Parts #########################
#echo "###############################################"
#echo "# Linking The Top Module with its submodules  #"
#echo "###############################################"

link 

############# Make unique copies of replicated modules by ##################
############# giving each replicated module a unique name  #############

uniquify

#puts "***********************file of constrains *******************"

#source ./cons.tcl
############################################################################################## constrains ####################################################################################################


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
set_fix_multiple_port_nets -all -buffer_constants -feedthroughs

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
set CLK_TX_PER 800
set CLK_RX_PER [expr $CLK_TX_PER/8]
set CLK_SETUP_SKEW 0.25
set CLK_HOLD_SKEW 0.05
set CLK_LAT 0
set CLK_RISE 0.1
set CLK_FALL 0.1

create_clock -name $CLK_TX_NAME -period $CLK_TX_PER -waveform "0 [expr $CLK_TX_PER/2]" [get_ports TX_CLK]
create_clock -name $CLK_RX_NAME -period $CLK_RX_PER -waveform "0 [expr $CLK_RX_PER/2]" [get_ports RX_CLK]
set_clock_uncertainty -setup $CLK_SETUP_SKEW [get_clocks [list $CLK_TX_NAME $CLK_RX_NAME]]
set_clock_uncertainty -hold  $CLK_HOLD_SKEW  [get_clocks [list $CLK_TX_NAME $CLK_RX_NAME]]
set_clock_transition  -rise  $CLK_RISE       [get_clocks [list $CLK_TX_NAME $CLK_RX_NAME]]
set_clock_transition  -fall  $CLK_FALL       [get_clocks [list $CLK_TX_NAME $CLK_RX_NAME]]
set_clock_latency            $CLK_LAT        [get_clocks [list $CLK_TX_NAME $CLK_RX_NAME]]

set_dont_touch_network [list $CLK_TX_NAME $CLK_RX_NAME] 

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

set tx_delay  [expr 0.2*$CLK_TX_PER]
set rx_delay [expr 0.2*$CLK_RX_PER]

#Constrain Input Paths TX
set_input_delay $tx_delay -clock $CLK_TX_NAME [get_port TX_IN_P] 
set_input_delay $tx_delay -clock $CLK_TX_NAME [get_port TX_IN_V]
#set_input_delay $tx_delay -clock $CLK_TX_NAME [get_port U0_UART_TX/parity_enable]
#set_input_delay $tx_delay -clock $CLK_TX_NAME [get_port U0_UART_TX/parity_type]
#Constrain Input Paths RX
set_input_delay $rx_delay -clock $CLK_RX_NAME [get_port RX_IN_S]
set_input_delay $rx_delay -clock $CLK_RX_NAME [get_port Prescale]
set_input_delay $rx_delay -clock $CLK_RX_NAME [get_port parity_enable]
set_input_delay $rx_delay -clock $CLK_RX_NAME [get_port parity_type]


#Constrain Output Paths TX
set_output_delay $tx_delay -clock $CLK_TX_NAME [get_port TX_OUT_S]
set_output_delay $tx_delay -clock $CLK_TX_NAME [get_port TX_OUT_V]
#Constrain Output Paths RX
set_output_delay $rx_delay -clock $CLK_RX_NAME [get_port RX_OUT_P]
set_output_delay $rx_delay -clock $CLK_RX_NAME [get_port RX_OUT_V]

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

#############################################################################################end of constrains ################################################################################################

###################### Mapping and optimization ########################"
# Prevent assign statements in the generated netlist (must be applied before compile command)

set_fix_multiple_port_nets -all -buffer_constants -feedthroughs
compile

#############################################################################
# Write out Design after initial compile
#############################################################################

#write_file -format verilog -output UART.v

write_file -format verilog -hierarchy -output UART_TX.v
write_file -format ddc -hierarchy -output UART_TX.ddc
write_sdc  -nosplit UART_TX.sdc

################# reporting #######################

report_area -hierarchy > area.rpt
report_power -hierarchy > power.rpt
report_timing -max_paths 10 -delay_type min > hold.rpt
report_timing -max_paths 10 -delay_type max > setup.rpt
report_clock -attributes > clocks.rpt
report_constraint -all_violators > constraints.rpt
report_port > ports.rpt

#######################################################
