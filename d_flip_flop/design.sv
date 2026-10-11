module d_ff(intf vif);
  
  always_ff@(posedge vif.clk)begin
    if(vif.rst)
      vif.q<=3'b000;
    else
      vif.q<=vif.d;
  end
endmodule
