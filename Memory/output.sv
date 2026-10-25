[GEN] WRITE we=1 addr=000 data_in=1101
[GEN] WRITE we=1 addr=001 data_in=1110
[GEN] WRITE we=1 addr=010 data_in=1100
[GEN] WRITE we=1 addr=011 data_in=0110
[GEN] WRITE we=1 addr=100 data_in=0100
[GEN] WRITE we=1 addr=101 data_in=0000
[GEN] WRITE we=1 addr=110 data_in=0110
[GEN] WRITE we=1 addr=111 data_in=0000
[GEN] READ we=0 addr=000 data_out=1101
[GEN] READ we=0 addr=001 data_out=1110
[GEN] READ we=0 addr=010 data_out=1100
[GEN] READ we=0 addr=011 data_out=0110
[GEN] READ we=0 addr=100 data_out=0100
[GEN] READ we=0 addr=101 data_out=0000
[GEN] READ we=0 addr=110 data_out=0110
[GEN] READ we=0 addr=111 data_out=0000
[DRV]we=1 addr=000 data=1101
[MON] we=1 addr=000 data_in=1101 data_out=xxxx 
[SCB] WRITE addr=000 data=1101
[DRV]we=1 addr=001 data=1110
[MON] we=1 addr=001 data_in=1110 data_out=xxxx 
[SCB] WRITE addr=001 data=1110
[DRV]we=1 addr=010 data=1100
[MON] we=1 addr=010 data_in=1100 data_out=xxxx 
[SCB] WRITE addr=010 data=1100
[DRV]we=1 addr=011 data=0110
[MON] we=1 addr=011 data_in=0110 data_out=xxxx 
[SCB] WRITE addr=011 data=0110
[DRV]we=1 addr=100 data=0100
[MON] we=1 addr=100 data_in=0100 data_out=xxxx 
[SCB] WRITE addr=100 data=0100
[DRV]we=1 addr=101 data=0000
[MON] we=1 addr=101 data_in=0000 data_out=xxxx 
[SCB] WRITE addr=101 data=0000
[DRV]we=1 addr=110 data=0110
[MON] we=1 addr=110 data_in=0110 data_out=xxxx 
[SCB] WRITE addr=110 data=0110
[DRV]we=1 addr=111 data=0000
[MON] we=1 addr=111 data_in=0000 data_out=xxxx 
[SCB] WRITE addr=111 data=0000
[DRV]we=0 addr=000 data=1101
[MON] we=0 addr=000 data_in=1101 data_out=1101 
[SCB] PASS addr=000 expected=1101 actual=1101
[DRV]we=0 addr=001 data=1110
[MON] we=0 addr=001 data_in=1110 data_out=1110 
[SCB] PASS addr=001 expected=1110 actual=1110
[DRV]we=0 addr=010 data=1100
[MON] we=0 addr=010 data_in=1100 data_out=1100 
[SCB] PASS addr=010 expected=1100 actual=1100
[DRV]we=0 addr=011 data=0110
[MON] we=0 addr=011 data_in=0110 data_out=0110 
[SCB] PASS addr=011 expected=110 actual=110
[DRV]we=0 addr=100 data=0100
[MON] we=0 addr=100 data_in=0100 data_out=0100 
[SCB] PASS addr=100 expected=100 actual=100
[DRV]we=0 addr=101 data=0000
[MON] we=0 addr=101 data_in=0000 data_out=0000 
[SCB] PASS addr=101 expected=0 actual=0
[DRV]we=0 addr=110 data=0110
[MON] we=0 addr=110 data_in=0110 data_out=0110 
[SCB] PASS addr=110 expected=110 actual=110
[DRV]we=0 addr=111 data=0000
[MON] we=0 addr=111 data_in=0000 data_out=0000 
[SCB] PASS addr=111 expected=0 actual=0
Simulation complete via $finish(1) at time 166 NS + 0
./testbench.sv:23     $finish;
xcelium> exit
TOOL:	xrun	25.03-s001: Exiting on Oct 25, 2026 at 10:14:41 EDT  (total: 00:00:02)
Finding VCD file...
./d_ff.vcd
[2026-10-25 14:14:41 UTC] Opening EPWave...
Done
