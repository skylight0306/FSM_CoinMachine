module simulate() ;

reg clk, reset ;
reg [5:0] coin ;
wire [5:0] refund ;
reg [2:0]  drink_choose ;
wire [2:0] give ; 
wire[5:0] total_coin ;

AutoVendor autoVendor( clk, coin, reset, drink_choose, give, refund, total_coin ) ;

initial clk = 1'b1;
always #10 clk = ~clk;

initial
begin
 // 000nothing changed 還是討厭下雨天 001tea 010coke 011coffee 100 milk;
  coin = 5;
 #10 coin = 5;
 #10 coin = 1;
 #10 coin = 1;
 #10 coin = 10;
 #10 coin = 0;
 #10 drink_choose = 3'b010;//買可樂
 #30 reset = 1;
  $stop;

 
 
 
 
 
 
 
 //total_coin = total_coin + coin;
 //#10 coin = 6'd5;
 //total_coin = total_coin + coin;
 //#10 coin = 6'd1;
 //total_coin = total_coin + coin;
 //#10 coin = 6'd10;
 //total_coin = total_coin + coin;
//reset = 1;

end

endmodule
