//TB : First i am testing with direct testing
`include "apb_interface.sv"

module top();
  
  bit clk;
  bit rst;
  
  //Taking instance of interface
  intf vif(clk,rst);
  
  //Taking instance of design
  APB_slave_m DUT(.clk(clk),.rst(rst),.psel(vif.psel),.penable(vif.penable),.pwrite(vif.pwrite),.paddr(vif.paddr),.pwdata(vif.pwdata),.pready(vif.pready),.pslver(vif.pslver),.prdata(vif.prdata));
  
  //generating clk
  always #5 clk=~clk;
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
    monitor_t();
    rst <= 1;
    @(posedge clk);
    rst <= 0;
    @(posedge clk);
    vif.psel   <= 1;
    vif.pwrite <= 1;
    vif.paddr  <= 5;
    vif.pwdata <= 32'b0000_0001;
    @(posedge clk);
    vif.penable <= 1;
    wait(vif.pready);
    @(posedge clk);
    //read from same address
    vif.penable <= 0;
    vif.pwrite <= 0;
    @(posedge clk);
    vif.penable <= 1;
    wait(vif.pready);
    //vif.penable <= 0;
    @(posedge clk);
    vif.penable <= 0;
    @(posedge clk);
    $finish;
    //fork 
      //begin wait(vif.pready); end //process 1
      //begin repeat(10) @(posedge clk); end //process 2
    //join_any
    //disable fork
  end
      
      task monitor_t();
        $monitor($time," psel=%b, pwrite=%b, penable=%b ,paddr=%b, pwdata=%b, prdata=%b, pslver=%b, mem=%p",vif.psel,vif.pwrite,vif.penable,vif.paddr,vif.pwdata,vif.prdata,vif.pslver,DUT.mem);
      endtask
  
endmodule
