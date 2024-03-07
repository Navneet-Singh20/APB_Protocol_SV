// Code APB Slave=>

module APB_slave_m(input clk,
                   input rst,
                   input psel,
                   input penable,
                   input pwrite,
                   input [2:0] paddr,
                   input [31:0] pwdata,
                   output reg pready,
                   output reg pslver,
                   output reg [31:0] prdata);
  
  //I am creating memory
  reg [31:0] mem[8];
  
  always@(posedge clk or posedge rst) begin
    if(rst) begin
      foreach(mem[i]) begin
        mem[i] <= 32'h0000_0000;
      end
      pready <= 0;
      pslver <= 0;
      prdata <= 32'h0000_0000;
    end else begin
      if(psel && penable) begin
        if(pwrite) begin
          mem[paddr] <= pwdata;
          pready     <= 1;
        end else begin
          prdata <= mem[paddr];
          pready <= 1;
        end
      end else begin
        pready <= 0;
        pslver <= 0;
      end
    end
  end
  
endmodule