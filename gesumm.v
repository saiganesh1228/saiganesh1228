`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.07.2021 22:22:46
// Design Name: 
// Module Name: matrix_sum
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


module matrix_sum(A,B,c,v,X,Y,clk

    );
    input [15:0] A,B;
    input [15:0] X; 
    input clk;
    input [3:0]c,v;     
    output [3:0] Y;  
    reg [3:0] Y; 
    reg [3:0] Y1,Y2;                     
    reg [3:0] A1 [0:1][0:1];
    reg [3:0] B1 [0:1][0:1];
    reg [3:0] X1 [0:1][0:1];                      
                                           
                                             
    initial begin                            
        Y=0;                                                               
        end                                  
   always@(posedge clk)                      
   begin                                     
      {A1[0][0],A1[0][1],A1[1][0],A1[1][1]} = A;
      {B1[0][0],B1[0][1],B1[1][0],B1[1][1]} = B;
      {X1[0][0],X1[0][1],X1[1][0],X1[1][1]} = X;
       Y1 = c*(A1[0][0]*X1[0][0]+A1[0][1]*X1[0][1] +A1[1][0]*X1[1][0] +A1[1][1]*X1[1][1]); 
       Y2 =  v*(B1[0][0]*X1[0][0]+B1[0][1]*X1[0][1]+B1[1][0]*X1[1][0]+B1[1][1]*X1[1][1]);
                                     
   end  
   always@(negedge clk)                      
   begin   
   Y = Y1+Y2;
   end                                   
endmodule



`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.07.2021 23:48:37
// Design Name: 
// Module Name: m_s
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


module m_s(

    );
    
    reg [15:0] A,B;
    reg [15:0] X; 
    reg clk;
    reg [3:0]c,v;     
    wire [3:0] Y; 
    reg [3:0] A1[3:0][3:0],B1[3:0][3:0];
    reg [3:0] X1[3:0];
    integer i,j,k,l; 
    
    matrix_sum ms(A,B,c,v,X,Y,clk);
    
     initial 
     begin
           
         for(i=0;i<4;i=i+1)
         begin
            X1[i]= i;
            for(j=0;j<4;j=j+1)
            begin
                A1[i][j]= i+j;
                B1[i][j]= i+j+1;
            end
         end
         
    end
    
     initial 
     begin
          clk=0;
          #30
         for(k=0;k<4;k=k+1)
         begin
         
           l=10*k + 30;
           #l X=  {X1[0],X1[1],X1[2],X1[3]};
               c=4'b1011;v=4'b1011;
               A = {A1[k][0],A1[k][1],A1[k][2],A1[k][3]};
               B = {B1[k][0],B1[k][1],B1[k][2],B1[k][3]};
          end
         
        #80 $finish;  
    end
    
   
    always #10 clk =~ clk;
endmodule
