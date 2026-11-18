class scoreboard;

    transaction wtrans, rtrans;

    mailbox wmon2scb;
    mailbox rmon2scb;

    bit [7:0] expected_queue[$];
    bit [7:0] expected;

    int pass_count = 0;
    int fail_count = 0;

    function new(mailbox wmon2scb,
                 mailbox rmon2scb);

        this.wmon2scb = wmon2scb;
        this.rmon2scb = rmon2scb;

    endfunction

    task collect_writes();

        forever begin

            wmon2scb.get(wtrans);

            if(wtrans.w_en) begin

                expected_queue.push_back(wtrans.wdata);

                $display("WRITE STORED = %h", wtrans.wdata);

                if(wtrans.full) begin

                    if(expected_queue.size() == 8) begin
                        $display("FULL CHECK PASS");
                        pass_count++;
                    end
                    else begin
                        $display("FULL CHECK FAIL");
                        fail_count++;
                    end

                end

            end

        end

    endtask

    task collect_reads();

        forever begin

            rmon2scb.get(rtrans);

            if(rtrans.r_en) begin

                if(expected_queue.size() > 0) begin

                    expected = expected_queue.pop_front();

                    if(expected === rtrans.rdata) begin

                        $display("READ PASS: Expected=%h Actual=%h",
                                 expected, rtrans.rdata);

                        pass_count++;

                    end
                    else begin

                        $display("READ FAIL: Expected=%h Actual=%h",
                                 expected, rtrans.rdata);

                        fail_count++;

                    end

                    if(rtrans.empty) begin

                        if(expected_queue.size() == 0) begin
                            $display("EMPTY CHECK PASS");
                            pass_count++;
                        end
                        else begin
                            $display("EMPTY CHECK FAIL");
                            fail_count++;
                        end

                    end

                end
                else begin

                    $display("ERROR: Expected queue is empty");
                    fail_count++;

                end

            end

        end

    endtask

    task run();

        fork
            collect_writes();
            collect_reads();
        join

    endtask

endclass
