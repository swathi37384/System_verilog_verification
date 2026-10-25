class generator;
  transaction trans;
  mailbox gen2driver;

  logic [3:0] stored_data [0:7];
  
  function new(mailbox gen2driver);
    this.gen2driver = gen2driver;
  endfunction

  task run();

    for (int i = 0; i < 8; i++) begin
      trans = new();

      if (trans.randomize() with {
        we == 1;
        addr == i;
      }) begin
        stored_data[i]=trans.data_in;
        gen2driver.put(trans);

        $display("[GEN] WRITE we=%b addr=%b data_in=%b",
                 trans.we, trans.addr, trans.data_in);
      end
      else begin
        $display("[GEN] Write randomization failed");
      end
    end

    for (int i = 0; i < 8; i++) begin
      trans = new();
        
      trans.we=0;
      trans.addr=i;
      trans.data_in=stored_data[i];
        gen2driver.put(trans);

      $display("[GEN] READ we=%b addr=%b data_out=%b",
               trans.we, trans.addr,stored_data[i]);
      end


  endtask
endclass
