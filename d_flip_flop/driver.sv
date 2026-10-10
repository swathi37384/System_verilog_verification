class driver;
  mailbox gen2driver;
  transaction trans;
  virtual intf vif;
  
  function new(mailbox gen2driver,virtual intf vif);
    this.gen2driver=gen2driver;
    this.vif=vif;
  endfunction
  
  task run();
    repeat(10)begin
       
      gen2driver.get(trans);
     @(negedge vif.clk);
      vif.rst=trans.rst;
      vif.d=trans.d;
      $display("[DRV] rst=%0b d=%b",vif.rst,vif.d);
    end
  endtask
endclass
