class scoreboard;
  bit [2:0] exp_q;
  mailbox mon2scb;
  transaction trans;
  
  function new(mailbox mon2scb);
    this.mon2scb=mon2scb;
    endfunction
  
  task run();
    repeat(10)begin
      mon2scb.get(trans);
      if(trans.rst==1'b1)
        exp_q=3'b000;
      else
        exp_q=trans.d;
      
      if(trans.q==exp_q)begin
        $display("[scb] pass rst=%0b d=%b q=%b",trans.rst,trans.d,trans.q);
      end
      else
        begin
          $display("[scb] fail rst=%0b d=%0b q=%0b exp_q=%0b",trans.rst,trans.d,trans.q,exp_q);
        end
    end
      endtask
      endclass
