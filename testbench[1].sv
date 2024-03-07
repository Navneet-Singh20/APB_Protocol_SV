//SV Tb:
`include "apb_interface.sv"
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "environment.sv"
`include "program.sv"

module tb;
  
  bit clk,rst;
  
  //Taking instance of interface
  intf vif(clk,rst);
  
  //Taking instance of design
  APB_slave_m DUT(.clk(clk),.rst(rst),.psel(vif.psel),.penable(vif.penable),.pwrite(vif.pwrite),.paddr(vif.paddr),.pwdata(vif.pwdata),.pready(vif.pready),.pslver(vif.pslver),.prdata(vif.prdata));
  
  //Taking instance of program_block
  pb_block pb(vif);
  
  //generating clk
  always #5 clk=~clk;
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
    rst = 1;
    @(posedge clk);
    rst = 0;
    @(posedge clk);
  end
  
endmodule