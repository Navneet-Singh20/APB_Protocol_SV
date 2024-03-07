class monitor;
  
  //taking virt interface
  virtual intf vif;
  
  //taking mailbox
  mailbox mon2sb;
  
  //no of pkt rec
  bit [4:0] no_pkt_mon;
  
  //constructor
  function new(mailbox mon2sb, virtual intf vif);
    this.mon2sb = mon2sb;
    this.vif    = vif;
  endfunction
  
  //Run task
  task run_t();
    transaction pkt;
    forever begin
      pkt = new();
      wait(vif.pready);
      if(vif.pwrite) begin
        pkt.pwrite = vif.pwrite;
        pkt.pdata  = vif.pwdata;
      end else begin
        pkt.pwrite = vif.pwrite;
        pkt.pdata  = vif.prdata;
      end
       pkt.paddr  = vif.paddr;
      mon2sb.put(pkt);
      pkt.print("Monitor Class");
      @(posedge vif.clk);
      no_pkt_mon++;
    end
  endtask
  
endclass