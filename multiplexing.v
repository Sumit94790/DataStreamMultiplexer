`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/24/2023 04:09:55 PM
// Design Name: 
// Module Name: multiplexing
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module multiplexing( input clk ,rst ,
output reg  sclk,count_clk, 
input [1:0]mode,
input  [7:0]ds1,ds2,ds3,
output reg multi_data,
output reg out_ready

    );
    
    integer countc= 0;
    integer count = 0;
    reg [11:0]temp;
    integer state;
    
    
    /// generation of sclk for 1 mhz
    
    always @(posedge clk)
    begin
        if(rst == 1)
            begin
            countc <=0;
            sclk <= 1'b0;
            end
    
        else
            begin
             if(countc<50)
              begin
             countc <= countc+1;
              end
             else
              begin
              countc<=0;
              sclk = ~sclk;
              end         
            end
    
    end
    
    
   always@(posedge sclk)
   begin
       if(rst==1)
       begin
       multi_data <= 0;
       state <= 1;
       count <= 0;
       
       end
       else 
       begin
         case(state)
               1:
               begin
                  if(mode==1)
                  state <= 2;
                  else if (mode==2)
                  state <= 3;
                  else if(mode==3)
                  state <= 4;
               end
               2 :
               begin
                  if(count<6)
                      begin
                      multi_data <= ds1;
                      count <= count+1;
                      state<= 2;
                      end
                   else
                   state <= 7 ; //done
                   
               end
               
               3:
               begin
                  if(count==0)
                   begin
                     multi_data <= ds1;
                     count <= count+1;
                      state<= 5;
                   end
                  
                  
               end
               
               4:
               begin
               if(count==0)
                   begin
                      multi_data <= ds2;
                      count<=count+1;
                       state <= 6;
                   end
             
               
               end
               
               
               
              5 :
              begin
                if(count==1)
                 begin
                    multi_data <= ds2;
                    count <= count+1;
                    state<= 5;
                 end
                else
                begin
                 multi_data <= ds1;
                 state<= 7; //Done
                end
              
              end
              
             6:
             begin
               if(count==1)
                   begin
                    multi_data <= ds2;
                     count<= count+1;
                   end
                  
               else 
               begin
                multi_data <= ds3;
                state<= 7;//done
                count <=0;
               end
             end
             
            7: // out_ready == Done state
            begin
            out_ready <= 1;
            end
          endcase
   
      end
   end
   
   
   
   
   
   
    endmodule