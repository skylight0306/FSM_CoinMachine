module AutoVendor( clk, coin, reset, drink_choose, give, refund, total_coin ) ;



input clk, reset ;
input [5:0] coin ;
input [2:0] drink_choose ;
output [2:0] give ;
output [5:0] refund ;
output [5:0] total_coin ;

reg [1:0] tea, coke, coffee, milk ;

parameter S0 = 3'd0,
	  S1 = 3'd1,
	  S2 = 3'd2,
	  S3 = 3'd3 ;
	  
reg [2:0] state ;
reg [2:0] next_state ;
reg [5:0] total_coin ;




reg [5:0] refund ;

reg [3:0] give ;

initial 
begin

    total_coin = 6'b0 ;
    tea = 1'b0 ;
    coke = 1'b0 ;
    coffee = 1'b0 ;
    milk = 1'b0 ;
    refund = 6'b0 ;
    give = 0 ;
	state = S0 ;
	next_state = S0;
end

always @ ( clk )//加錢
begin
	total_coin = total_coin + coin;
    //state = next_state;

end

always @ ( clk or reset )
  if ( reset )
  begin

    tea = 1'b0 ;
    coke = 1'b0 ;
    coffee = 1'b0 ;
    milk = 1'b0 ;
	//refund = 6'b0 ;
	//drink_choose = 3'b000;
    give = 0 ;
    state = S0 ;
	//reset = 1'b0;
  end
  else
    state = next_state ;

always @ ( state or total_coin or tea or coke or coffee or milk or clk )//改狀態用
begin
       case ( state )
        S0 :       
        begin
            if ( total_coin >= 10 ) next_state = S1 ;
            else next_state = S0 ;

        end
        S1 :
        begin
			if ( drink_choose == 3'b001 || drink_choose == 3'b010 || drink_choose == 3'b011 || drink_choose == 3'b100 )
			   next_state = S2;
			else
               next_state = S1 ;
        end	  
		
        S2 :       
        begin
            next_state = S3 ;
        end		
		
		S3 :
		begin
		    next_state = S0 ; 
		end
		endcase
end

always @ ( state or total_coin or drink_choose)//找零用
begin

case ( state )

    S1 :  //顯示可以買的東西
    begin
        if ( total_coin >= 10 ) tea = 1 ;
        if ( total_coin >= 15 ) coke = 1;
        if ( total_coin >= 20 ) coffee = 1 ;
        if ( total_coin >= 25 ) milk = 1 ;
    end

    S2 : //給東西
    begin
        give = drink_choose ;
    end	
	
    S3 :
    begin // 找零
	
    if ( drink_choose == 3'b001 ) total_coin = total_coin -6'd10;
	else if ( drink_choose == 3'b010 ) total_coin = total_coin -6'd15;
	else if ( drink_choose == 3'b011 ) total_coin = total_coin -6'd20;
	else if ( drink_choose == 3'b100 ) total_coin = total_coin -6'd25;
	
    refund = total_coin;	
	//reset = 1'b1;
    end	
	
endcase
end





endmodule

