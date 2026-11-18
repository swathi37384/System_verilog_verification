`include "interface.sv"
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "agent.sv"
`include "environment.sv"

module async_fifo_tb;

    bit wclk, rclk;

    asyn_fifo intf(wclk, rclk);

    environment env;

    async_fifo dut(
        .wclk(intf.wr_clk),
        .rclk(intf.rd_clk),
        .w_en(intf.wr_en),
        .r_en(intf.rd_en),
        .w_rst(intf.w_rst),
        .r_rst(intf.r_rst),
        .wdata(intf.wr_data),
        .rdata(intf.rd_data),
        .wfull(intf.full),
        .rempty(intf.empty)
    );

    initial begin
        wclk = 0;
        forever #5 wclk = ~wclk;
    end

    initial begin
        rclk = 0;
        forever #7 rclk = ~rclk;
    end

    initial begin

        intf.w_rst = 0;
        intf.r_rst = 0;

        intf.wr_en = 0;
        intf.rd_en = 0;
        intf.wr_data = 0;

        repeat(5) @(negedge wclk);

        intf.w_rst = 1;
        intf.r_rst = 1;

        repeat(5) @(negedge wclk);

        env = new(intf);
        env.run();

        wait(env.ag.drv.done);

        repeat(5) @(posedge rclk);

        $display("----------------------------");
        $display("SIMULATION SUMMARY");
        $display("PASS COUNT = %0d", env.scb.pass_count);
        $display("FAIL COUNT = %0d", env.scb.fail_count);
        $display("----------------------------");

        $finish;

    end

endmodule
