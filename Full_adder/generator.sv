class generator;
  transaction trans;
  mailbox gen2driver;
  
  function new(mailbox gen2driver);
    this.gen2driver=gen2driver;
  endfunction
  
  task run();
    repeat(8)begin
      #1;
      trans=new();
      trans.randomize();
       gen2driver.put(trans);
      $display("a=%0b,b=%0b,c=%0b",trans.a,trans.b,trans.c);
     
    end
  endtask
endclass
        
