class environment;
  
  //Taking instance of gen,driv & mon
  
  generator  gen;
  driver     driv;
  monitor    mon;
  scoreboard sb;
  
  //declaring mailbox
  mailbox gen2driv;
  mailbox mon2sb;
  
  //interface
  virtual intf vif;
  
  //constructor
  function new(virtual intf vif);
    this.vif = vif;
    gen2driv = new();
    mon2sb   = new();
    gen = new(gen2driv);
    driv = new(gen2driv,vif);
    mon = new(mon2sb,vif);
    sb  = new(mon2sb); 
  endfunction
  
  task run_t();
    $display("Inside Environent Class");
    //`uvm_info(get_full_name(),"Inside ",UVM_HIGH);
    fork
      gen.run_t();
      driv.run_t();
      mon.run_t();
      sb.run_t();
    join_any
    wait_t();
    $display("Env class completed");
  endtask
  
  task wait_t();
    fork
      begin wait(driv.no_pkt_driv == gen.no_pkt_gen); end
      //begin wait(driv.no_pkt_driv == 2); end
      begin repeat(100) begin @(posedge vif.clk); end $display("Wait condition didn't met"); end
    join_any
  endtask
  
endclass