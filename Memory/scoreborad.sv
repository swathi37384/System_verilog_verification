class scoreboard;

  transaction trans;
  mailbox mon2scb;
  logic [7:0] exp_mem [0:7];

  function new(mailbox mon2scb);
    this.mon2scb = mon2scb;
  endfunction

  task run();
    repeat(16) begin
      mon2scb.get(trans);

      if(trans.we) begin
        exp_mem[trans.addr] = trans.data_in;
        $display("[SCB] WRITE addr=%b data=%b",
                  trans.addr, trans.data_in);
      end
      else begin
        if(trans.data_out === exp_mem[trans.addr]) begin
          $display("[SCB] PASS addr=%b expected=%0b actual=%0b",
                   trans.addr, exp_mem[trans.addr], trans.data_out);
        end
        else begin
          $display("[SCB] FAIL addr=%0d expected=%0h actual=%0h",
                   trans.addr, exp_mem[trans.addr], trans.data_out);
        end
      end

    end
  endtask

endclass
