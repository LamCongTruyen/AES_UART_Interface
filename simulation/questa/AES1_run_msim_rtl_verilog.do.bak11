transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/lamco/Downloads/TC/TC {C:/Users/lamco/Downloads/TC/TC/AES1.sv}
vlog -sv -work work +incdir+C:/Users/lamco/Downloads/TC/TC {C:/Users/lamco/Downloads/TC/TC/sbox.sv}
vlog -sv -work work +incdir+C:/Users/lamco/Downloads/TC/TC {C:/Users/lamco/Downloads/TC/TC/shiftrow.sv}
vlog -sv -work work +incdir+C:/Users/lamco/Downloads/TC/TC {C:/Users/lamco/Downloads/TC/TC/KeyExp.sv}
vlog -sv -work work +incdir+C:/Users/lamco/Downloads/TC/TC {C:/Users/lamco/Downloads/TC/TC/AES_lastround.sv}
vlog -sv -work work +incdir+C:/Users/lamco/Downloads/TC/TC {C:/Users/lamco/Downloads/TC/TC/MixColumns_function.sv}
vlog -sv -work work +incdir+C:/Users/lamco/Downloads/TC/TC {C:/Users/lamco/Downloads/TC/TC/AES_pipeline_Encryption.sv}
vlog -sv -work work +incdir+C:/Users/lamco/Downloads/TC/TC {C:/Users/lamco/Downloads/TC/TC/AES_CTR_pipelined.sv}
vlog -sv -work work +incdir+C:/Users/lamco/Downloads/TC/TC {C:/Users/lamco/Downloads/TC/TC/AES0.sv}
vlog -sv -work work +incdir+C:/Users/lamco/Downloads/TC/TC {C:/Users/lamco/Downloads/TC/TC/uart_tx.sv}
vlog -sv -work work +incdir+C:/Users/lamco/Downloads/TC/TC {C:/Users/lamco/Downloads/TC/TC/uart_rx.sv}
vlog -sv -work work +incdir+C:/Users/lamco/Downloads/TC/TC {C:/Users/lamco/Downloads/TC/TC/aes_to_tx_top.sv}
vlog -sv -work work +incdir+C:/Users/lamco/Downloads/TC/TC {C:/Users/lamco/Downloads/TC/TC/uart_rx_top.sv}
vlog -sv -work work +incdir+C:/Users/lamco/Downloads/TC/TC {C:/Users/lamco/Downloads/TC/TC/aes_uart_top.sv}

vlog -sv -work work +incdir+C:/Users/lamco/Downloads/TC/TC {C:/Users/lamco/Downloads/TC/TC/AES_CTR_Pipelined_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  AES_CTR_Pipelined_tb

add wave *
view structure
view signals
run -all
