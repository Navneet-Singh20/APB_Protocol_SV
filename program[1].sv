program pb_block(intf vif);
  
  environment env;
  
  initial begin
    env = new(vif);
    env.gen.no_pkt_gen = 15;
    env.run_t();
  end
  
endprogram