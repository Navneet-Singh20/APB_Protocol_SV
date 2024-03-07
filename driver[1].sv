class driver;
  
  //declare virt interface
  virtual intf vif;
  
  //declare mailbox
  mailbox gen2driv;
  
  //taking a var to count no_of_pkt
  bit [4:0] no_pkt_driv;
  
  //constructor func.
  function new(mailbox gen2driv, virtual intf vif);
    this.gen2driv = gen2driv;
    this.vif      = vif;
  endfunction
  
  //run task
  task run_t();
    transaction pkt; //taking instance of txn class
    reset_t();
    forever begin
      gen2driv.get(pkt);
      pkt.print("Driver class");
      vif.psel  <= 1;
      vif.paddr <= pkt.paddr;
      if(pkt.pwrite) begin
        vif.pwrite <= pkt.pwrite;
        vif.pwdata <= pkt.pdata;
      end else begin
        vif.pwrite <= pkt.pwrite;
      end
      @(posedge vif.clk);
      vif.penable  <= 1;
      wait(vif.pready);
      @(posedge vif.clk);
      vif.penable  <= 0;
      no_pkt_driv++;
    end
  endtask
  
  task reset_t();
    wait(vif.rst);
    $display("-----------Reset is triggered----------");
    vif.psel    <= 0;
    vif.penable <= 0;
    vif.pwrite  <= 0;
    vif.paddr   <= 0;
    vif.pwdata  <= 32'h0000_0000;
    wait(!vif.rst);
    $display("-----------Reset is removed--------------");
  endtask
  
endclass