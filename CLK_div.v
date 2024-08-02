module i_CLK_div #(parameter width=8)(
  input                 I_ref_clk,I_rst_n,I_clk_en,
  input   [width-1:0]   I_div_ratio,
  output                O_div_clk
  );  
  
/////internal signals and assign statements//////
reg [width-1:0] counter;
reg div_clk;
wire odd_div;
wire even_div;
reg odd_half_pulse;   //for odd div toggling 
wire ClK_DIV_EN;
assign ClK_DIV_EN = I_clk_en && ( I_div_ratio != 0) && ( I_div_ratio != 1);
assign O_div_clk = (ClK_DIV_EN) ? div_clk:I_ref_clk ;
assign odd_div = ( I_div_ratio[0]==1);
assign even_div= (I_div_ratio[0]==0);



always@(posedge I_ref_clk or negedge I_rst_n)
begin
  if(!I_rst_n)
    begin
     counter<=0;
     div_clk<=0;
     odd_half_pulse<=0;
    end
  else if(ClK_DIV_EN)
     begin  
       /////even division process///
       if( even_div && (counter==( (I_div_ratio>>1) -1) ) )
         begin
          div_clk<=~div_clk;
          counter<=0;
         end
      //////odd division process////
       else if ((odd_div && (counter==(I_div_ratio>>1)-1) && odd_half_pulse) || (odd_div && counter==(I_div_ratio>>1) && !odd_half_pulse)) 
         /*condition to handle the half pulse for odd division ,
         when just before middle we about to toggle the odd div clk and flag sets,
         at the miidle we togle and the flag resets
         */
        begin
          div_clk<=~div_clk;
          counter<=0;
          odd_half_pulse=~odd_half_pulse;
        end 
        else
          counter<=counter+1;
     end  
end




endmodule
