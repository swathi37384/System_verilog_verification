class monitor;
  transaction trans;
  mailbox mon2scb;
  virtual intf vif;
  
  function new(virtual intf vif,mailbox mon2scb);
    this.vif=vif;
    this.mon2scb=mon2scb;
  endfunction
  
  task run();
    @(posedge vif.clk);
    
    repeat(16)begin
      @(posedge vif.clk);
      #1;
      trans=new();
      trans.we=vif.we;
      trans.addr=vif.addr;
      trans.data_in=vif.data_in;
      trans.data_out=vif.data_out;
      mon2scb.put(trans);
      
      $display("[MON] we=%b addr=%b data_in=%b data_out=%b ",trans.we,trans.addr,trans.data_in,trans.data_out);
    end
  endtask
endclass
      
