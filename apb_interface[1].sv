interface intf(input clk,rst);
  logic psel;
  logic penable;
  logic pwrite;
  logic [2:0] paddr;
  logic [31:0] pwdata;
  logic [31:0] prdata;
  logic pready;
  logic pslver;
endinterface