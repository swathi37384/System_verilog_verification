class driver;
  mailbox gen2driver;
  transaction trans;
  virtual intf vif;
  
  function new( mailbox gen2driver, virtual intf vif);
    this.gen2driver=gen2driver;
    this.vif=vif;
    endfunction
  
  task run();
    repeat(16)begin
      
      gen2driver.get(trans);
      @(negedge vif.clk);
      vif.we=trans.we;
      vif.addr=trans.addr;
      vif.data_in=trans.data_in;
      $display("[DRV]we=%b addr=%b data=%b",vif.we,vif.addr,vif.data_in);
    end
  endtask
endclass
