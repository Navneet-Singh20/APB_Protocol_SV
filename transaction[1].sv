class transaction;
  
  static bit [3:0] pkt_id;
  
  bit psel;
  bit penable;
  rand bit pwrite;
  rand bit [2:0] paddr;
  rand bit [31:0] pdata;
  bit pready;
  bit pslver;
  
  function void print(string name="transaction");
    $display("-------Inside %s class------",name);
    $display("psel=%b, penable=%b, pwrite=%b, paddr=%b, pdata=%b pready=%b, pslver=%b",psel,penable,pwrite,paddr,pdata,pready);
    $display("-------------------------------");
  endfunction
  
  constraint c1{
    pwrite dist { 1 := 80, 0 := 20};
  }
  
  function pkt_id_f();
    pkt_id++;
  endfunction
  
endclass