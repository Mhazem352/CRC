`timescale 1us/1ps
module i_CLK_div_tb();
  
  
parameter width=8;



reg I_ref_clk_tb,I_rst_n_tb,I_clk_en_tb;
reg [width-1:0] I_div_ratio_tb;
wire O_div_clk_tb;

i_CLK_div DUT(
.I_ref_clk(I_ref_clk_tb),
.I_rst_n(I_rst_n_tb),
.I_clk_en(I_clk_en_tb),
.I_div_ratio(I_div_ratio_tb),
.O_div_clk(O_div_clk_tb)
);

localparam T_ref=10;

initial
begin
  reset();
  clock_div_out(0,1);
  #(10*T_ref);
  reset();
  clock_div_out(1,1);
  #(10*T_ref);
  reset();
  clock_div_out(1,2);
  #(10*T_ref);
  reset();
  clock_div_out(1,3);
  #(10*T_ref);
  reset();
  clock_div_out(1,4);
  #(10*T_ref);
  reset();
  clock_div_out(1,5);
  #(10*T_ref);
  reset();
  clock_div_out(1,6);
  #(10*T_ref);
  reset();
  clock_div_out(1,7);
  #(10*T_ref);
  reset();
  clock_div_out(1,8);
  #(10*T_ref);
  $stop;
end



//////generate clock///////
always
begin
I_ref_clk_tb=0;
#(T_ref/2);
I_ref_clk_tb=1;
#(T_ref/2);
end



/////////task reset/////////
task reset();
  begin
    I_rst_n_tb=0;
    #(T_ref);
    I_rst_n_tb=1;
  end
endtask




///////task clock_div_out////////
task clock_div_out;
input enable_val;
input [width-1:0] ratio;
  begin
    I_clk_en_tb=enable_val;
    I_div_ratio_tb=ratio;
  end
endtask

endmodule