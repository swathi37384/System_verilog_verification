class agent;

    driver drv;
    monitor mon;

    virtual asyn_fifo vif;

    mailbox gen2drv_write;
    mailbox gen2drv_read;

    mailbox wmon2scb;
    mailbox rmon2scb;

    function new(virtual asyn_fifo vif,
                 mailbox gen2drv_write,
                 mailbox gen2drv_read,
                 mailbox wmon2scb,
                 mailbox rmon2scb);

        this.vif = vif;

        this.gen2drv_write = gen2drv_write;
        this.gen2drv_read = gen2drv_read;

        this.wmon2scb = wmon2scb;
        this.rmon2scb = rmon2scb;

        drv = new(gen2drv_write, gen2drv_read, vif);

        mon = new(vif, wmon2scb, rmon2scb);

    endfunction

    task run();

        fork
            drv.run();
            mon.run();
        join

    endtask

endclass
