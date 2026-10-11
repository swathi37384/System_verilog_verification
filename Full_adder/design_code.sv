module fulladder(intf vif);
  assign vif.sum=vif.a^vif.b^vif.c;
  assign vif.carry=(vif.a&vif.b)|(vif.b&vif.c)|(vif.c&vif.a);
endmodule
