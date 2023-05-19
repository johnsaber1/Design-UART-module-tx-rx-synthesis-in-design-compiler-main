set synopsys_auto_setup true
set_svf "/home/IC/Labs/Ass_Syn_2.0/syn/UART.svf"
############################## Formality Setup File ##############################

set SSLIB "/home/IC/Labs/Lab_Formal_1/std_cells/scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "/home/IC/Labs/Lab_Formal_1/std_cells/scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "/home/IC/Labs/Lab_Formal_1/std_cells/scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"


## Read Reference Design Files

read_db -container ref [list $SSLIB $TTLIB $FFLIB]

#TX
read_verilog -container ref /home/IC/Labs/Ass_Syn_2.0/rtl/UART_TX/mux.v
read_verilog -container ref /home/IC/Labs/Ass_Syn_2.0/rtl/UART_TX/parity_calc.v
read_verilog -container ref /home/IC/Labs/Ass_Syn_2.0/rtl/UART_TX/Serializer.v
read_verilog -container ref /home/IC/Labs/Ass_Syn_2.0/rtl/UART_TX/uart_tx_fsm.v
read_verilog -container ref /home/IC/Labs/Ass_Syn_2.0/rtl/UART_TX/UART_TX.v
#RX
read_verilog -container ref /home/IC/Labs/Ass_Syn_2.0/rtl/UART_RX/data_sampling.v
read_verilog -container ref /home/IC/Labs/Ass_Syn_2.0/rtl/UART_RX/deserializer.v
read_verilog -container ref /home/IC/Labs/Ass_Syn_2.0/rtl/UART_RX/edge_bit_counter.v
read_verilog -container ref /home/IC/Labs/Ass_Syn_2.0/rtl/UART_RX/par_chk.v
read_verilog -container ref /home/IC/Labs/Ass_Syn_2.0/rtl/UART_RX/stp_chk.v
read_verilog -container ref /home/IC/Labs/Ass_Syn_2.0/rtl/UART_RX/strt_chk.v
read_verilog -container ref /home/IC/Labs/Ass_Syn_2.0/rtl/UART_RX/UART_RX.v
read_verilog -container ref /home/IC/Labs/Ass_Syn_2.0/rtl/UART_RX/uart_rx_fsm.v
#mux
read_verilog -container ref /home/IC/Labs/Ass_Syn_2.0/rtl/mux2x1_dft.v
#TOP
read_verilog -container ref /home/IC/Labs/Ass_Syn_2.0/rtl/UART_TOP/UART.v

## set the top Reference Design 
set_reference_design UART
set_top UART

## Read Implementation technology libraries
read_db -container imp [list $SSLIB $TTLIB $FFLIB]


## Read Implementation Design Files
read_verilog -container imp /home/IC/Labs/Ass_Syn_2.0/dft/UART_dft.v

## set the top Implementation Design
set_implementation_design UART
set_top UART

############################### Don't verify #################################

# do not verify scan in & scan out ports as a compare point as it is existed only after synthesis and not existed in the RTL

#scan in
set_dont_verify_points -type port ref:/WORK/*/so
set_dont_verify_points -type port imp:/WORK/*/so

#scan_out


############################### contants #####################################

# all atpg enable(test_mode, scan_enable) are zero during formal compare 

#test_mode
set_constant ref:/WORK/*/test_mode 0
set_constant imp:/WORK/*/test_mode 0

#scan_enable
set_constant ref:/WORK/*/se 0
set_constant imp:/WORK/*/se 0

## matching Compare points

match

## verify
set successful [verify]
if {!$successful} {
diagnose
analyze_points -failing
}

#Reports
report_passing_points > "passing_points.rpt"
report_failing_points > "failing_points.rpt"
report_aborted_points > "aborted_points.rpt"
report_unverified_points > "unverified_points.rpt"


start_gui
