`include "interface.sv"
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "agent.sv"
`include "environment.sv"

module tb;

  bit clk;

  always #5 clk = ~clk;

  intf inf(clk);
  sram uut(inf);

  environment env;

  initial begin
    env = new(inf);

    #5;
    inf.rst = 0;

    #15;
    inf.rst = 1;
    inf.wr = 1;
    inf.en = 1;

    #180;
    inf.wr = 0;
    inf.en = 1;
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #500;
    $finish;
  end

  initial begin
    env.run();
  end

endmodule
