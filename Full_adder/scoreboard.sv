class scoreboard;
  bit exp_sum;
  bit exp_carry;
  
  mailbox mon2scb;
  transaction trans;
  
  function new(mailbox mon2scb);
    this.mon2scb=mon2scb;
  endfunction
  
  task run();
    repeat(8)begin
      mon2scb.get(trans);
      
      exp_sum=trans.a^trans.b^trans.c;
      exp_carry=(trans.a& trans.b)|(trans.b&trans.c)|(trans.a&trans.c);
      
      if(trans.sum ==exp_sum && trans.carry==exp_carry)begin
        $display("[scb] PASS a=%0d b=%0b c=%0b |sum=%0b carry=%0b",trans.a,trans.b,trans.c,trans.sum,trans.carry);
      end
      else begin
        $display("[scb] FAIL a=%0d b=%0b c=%0b |sum=%0b exp_sum=%0b carry=%0b exp_carry=%0b",trans.a,trans.b,trans.c,trans.sum,exp_sum,trans.carry,exp_carry);
      end
    end
  endtask
endclass
