class transaction;
  rand bit [2:0] d;
  rand bit rst;
  
  bit[2:0] q;
   
  constraint reset_c{ rst dist{0:=8 ,1:=2};}
  
endclass
  
