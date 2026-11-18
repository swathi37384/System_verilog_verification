class driver;

    virtual asyn_fifo vif;

    mailbox gen2drv_write;
    mailbox gen2drv_read;

    bit done = 0;

    function new(mailbox gen2drv_write,
                 mailbox gen2drv_read,
                 virtual asyn_fifo vif);

        this.gen2drv_write = gen2drv_write;
        this.gen2drv_read = gen2drv_read;
        this.vif = vif;

    endfunction

    task write();

        transaction wtrans;

        repeat(8) begin

            gen2drv_write.get(wtrans);

            @(negedge vif.wr_clk);

            if(vif.w_rst) begin
                vif.wr_en = wtrans.w_en;
                vif.wr_data = wtrans.wdata;
            end

           @(negedge vif.wr_clk);

            vif.wr_en = 0;
            vif.wr_data = 0;

        end

    endtask

    task read();

        transaction rtrans;

        repeat(8) begin

            gen2drv_read.get(rtrans);

            @(negedge vif.rd_clk);

            if(vif.r_rst)
                vif.rd_en = rtrans.r_en;

            @(negedge vif.rd_clk);

            vif.rd_en = 0;

        end

    endtask

    task run();

        write();
        read();

        done = 1;

    endtask

endclass
