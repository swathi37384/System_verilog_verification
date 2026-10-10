class driver;
  mailbox gen2driver;
  transaction trans;
  virtual intf vif;
  
  function new(mailbox gen2driver,virtual intf vif);
    this.gen2driver=gen2driver;
    this.vif=vif;
  endfunction
  
  task run();
    repeat(8)begin
      gen2driver.get(trans);
      @(negedge vif.clk); 
      vif.a=trans.a;
      vif.b=trans.b;
      vif.c=trans.c;
      $display("[DRV] a=%0b b=%0b c=%0b",vif.a, vif.b, vif.c);
     
    end
  endtask
endclass
