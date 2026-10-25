module memory(intf vif);
  logic [3:0]mem[0:7];
  always@(posedge vif.clk)begin
  if(vif.we)
    mem[vif.addr]<=vif.data_in;
else
  vif.data_out<=mem[vif.addr];
end
endmodule
