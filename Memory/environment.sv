
class environment ;

  agent agt;
  scoreboard  sbd;

  virtual intf vinf;

  event next_n;

  mailbox mb_drv;

  function new(virtual intf vinf);

    this.vinf = vinf;

    mb_drv = new();

    agt = new(vinf, mb_drv);
    sbd = new(mb_drv);

    agt.gen.next = next_n;
    sbd.next = next_n;

    $display("environment new");

  endfunction

  task run();

    fork
      agt.run();
      sbd.start();
    join

  endtask

endclass
