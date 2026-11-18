class monitor;

    virtual asyn_fifo vif;

    mailbox wmon2scb;
    mailbox rmon2scb;

    function new(virtual asyn_fifo vif,
                 mailbox wmon2scb,
                 mailbox rmon2scb);

        this.vif = vif;
        this.wmon2scb = wmon2scb;
        this.rmon2scb = rmon2scb;

    endfunction

    task write_monitor();

        transaction wtrans;

        forever begin

            @(posedge vif.wr_clk);

            if(vif.wr_en) begin

                #1;

                wtrans = new();

                wtrans.w_en = 1;
                wtrans.wdata = vif.wr_data;
                wtrans.full = vif.full;

                wmon2scb.put(wtrans);

            end

        end

    endtask

    task read_monitor();

        transaction rtrans;

        forever begin

            @(posedge vif.rd_clk);

            if(vif.rd_en) begin

                #1;

                rtrans = new();

                rtrans.r_en = 1;
                rtrans.rdata = vif.rd_data;
                rtrans.empty = vif.empty;

                rmon2scb.put(rtrans);

            end

        end

    endtask

    task run();

        fork
            write_monitor();
            read_monitor();
        join

    endtask

endclass
