class monitor;
  transaction trans;
  virtual intf vif;
  mailbox mon2scb;
  
  function new(virtual intf vif, mailbox mon2scb);
    this.vif=vif;
    this.mon2scb=mon2scb;
   endfunction
  
  task run();
    @(posedge vif.clk);//skip the initial rising edge

    repeat(10)begin
      @(posedge vif.clk);
      #1;
      trans=new();
      trans.rst=vif.rst;
      trans.d=vif.d;
      
      trans.q=vif.q;
      mon2scb.put(trans);
      
      $display("[MON] rst=%0b d=%b q=%b ",trans.rst,trans.d,trans.q);
    end
    
  endtask
endclass
