class generator;
  
  //mailbox
  mailbox gen2driv;
  
  //instance of txn class
  transaction pkt;
  
  //no of pkt gen
  bit [3:0] no_pkt_gen;
  
  function new(mailbox gen2driv);
    this.gen2driv = gen2driv;
  endfunction
  
  task run_t();
    repeat(no_pkt_gen) begin
      pkt = new();
      assert(pkt.randomize() with {pkt.paddr inside {1,2,3,4};});
      $display("-----------pkt_id=%d------------",pkt.pkt_id);
      pkt.print("Generator class");
      gen2driv.put(pkt);
      pkt.pkt_id_f();
    end
  endtask
  
endclass