
`include "interface.sv"
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "agent.sv"
`include "environment.sv"

module testbench;
   initial vif.clk=0;
  always #5 vif.clk=~vif.clk;
  intf vif();
  
  d_ff dut(vif);
  environment env;
  
  initial begin
    vif.clk=0;
  env=new(vif);
        env.run();
        $finish;
  end
  initial begin
    $dumpfile("d_ff.vcd");
    $dumpvars;
  end
endmodule
