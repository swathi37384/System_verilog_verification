class generator;

    mailbox gen2drv_write;
    mailbox gen2drv_read;

    function new(mailbox gen2drv_write,
                 mailbox gen2drv_read);

        this.gen2drv_write = gen2drv_write;
        this.gen2drv_read = gen2drv_read;

    endfunction

    task write();

        transaction wtrans;

        repeat(8) begin

            wtrans = new();

            assert(wtrans.randomize() with {
                w_en == 1;
                r_en == 0;
            });

            gen2drv_write.put(wtrans);

        end

    endtask

    task read();

        transaction rtrans;

        repeat(8) begin

            rtrans = new();

            assert(rtrans.randomize() with {
                w_en == 0;
                r_en == 1;
            });

            gen2drv_read.put(rtrans);

        end

    endtask

    task run();

        write();
        read();

    endtask

endclass
