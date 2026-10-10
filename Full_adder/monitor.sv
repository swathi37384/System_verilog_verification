class monitor;
  transaction trans;
  virtual intf vif;
  mailbox mon2scb;
  
  function new(virtual intf vif,mailbox mon2scb);
  this.vif=vif;
    this.mon2scb=mon2scb;
  endfunction
  
  task run();
    
    repeat(8)begin
      @(negedge vif.clk);
      #1;
      trans=new();
      trans.a=vif.a;
      trans.b=vif.b;
      trans.c=vif.c;
      trans.sum=vif.sum;
      trans.carry=vif.carry;
      mon2scb.put(trans);
      $display("[MON] a=%0b b=%0b c=%0b sum=%0b carry=%0b",trans.a,trans.b,trans.c,trans.sum,trans.carry);
    end
  endtask
endclass
           
