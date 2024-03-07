class scoreboard;
  
  //mailbox
  mailbox mon2sb;
  
  //mem
  bit [31:0] mem[8];
  
  //constructor
  function new(mailbox mon2sb);
    this.mon2sb = mon2sb;
  endfunction
  
  task run_t();
    transaction pkt;
    forever begin
      mon2sb.get(pkt);
      pkt.print("Scoreboard Class");
      if(pkt.pwrite) begin
        mem[pkt.paddr] = pkt.pdata;
      end else begin
        if(mem[pkt.paddr] == pkt.pdata) begin
          $display("--------DATA MATCHED--------mem[%d]=%b---prdata=%b",pkt.paddr,mem[pkt.paddr],pkt.pdata);
        end else begin
          $display("-------DATA MIS-MATCHED------mem[%d]=%b---prdata=%b ",pkt.paddr,mem[pkt.paddr],pkt.pdata);
        end
      end
    end
  endtask
  
endclass