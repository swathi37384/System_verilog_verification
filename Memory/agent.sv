class agent;

  generator gen;
  driver  drv;
  monitor mtr;

  virtual intf vinf;

  mailbox mb_gen;
  mailbox mb_drv;

  function new(virtual intf vinf, mailbox mb_drv);

    this.vinf = vinf;
    this.mb_drv = mb_drv;

    mb_gen = new();

    gen = new(mb_gen);
    drv = new(vinf, mb_gen);
    mtr = new(vinf, mb_drv);

  endfunction

  task run();

    fork
      gen.start();
      drv.start();
      mtr.start();
    join

  endtask

endclass
