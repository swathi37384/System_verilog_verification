class environment;

    generator gen;
    agent ag;
    scoreboard scb;

    mailbox gen2drv_write;
    mailbox gen2drv_read;

    mailbox wmon2scb;
    mailbox rmon2scb;

    virtual asyn_fifo vif;

    function new(virtual asyn_fifo vif);

        this.vif = vif;

        gen2drv_write = new();
        gen2drv_read = new();

        wmon2scb = new();
        rmon2scb = new();

        gen = new(gen2drv_write, gen2drv_read);

        ag = new(vif,
                 gen2drv_write,
                 gen2drv_read,
                 wmon2scb,
                 rmon2scb);

        scb = new(wmon2scb, rmon2scb);

    endfunction

    task run();

        fork
            gen.run();
            ag.run();
            scb.run();
        join_none

    endtask

endclass
