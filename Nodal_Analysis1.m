clc; clear;
% Nodal Analysis
% Without current sources
% Voltage sources alone does not constitute a branch

%AV=B
% A is coefficient matrix with self and mutual conductances
    %(self-positive,  mutual-negative)
% is the source currents of the form V/R or I
    
%input- circuit data
% Col-1: Element
%Col-2: From
%Col-3: To
%Col-4: R
%Col-5: Vs
%Col-6: Is
% 0th node - reference node
input =[1  0   1   20  100 0;
       2   1   0   10  0   0;
       3   1   2   15  0   0;
       4   2   0   10  0   0;
       5   2   0   10  -80  0];
   
   A = zeros(2,2);
   B = zeros (1,2);
       for i1 = 1:5
           node1 = input(i1,2);
            node2 = input(i1,3);
            R = input(i1,4);
            G = 1/R;
            if node1~=0
                A(node1,node1)=A(node1,node1)+G;
                if input(i1,5)~=0
                    B(node1) = B(node1)+input(i1,5)/input(i1,4);
                end
            end
            if node2~=0
                A(node2,node2)=A(node2,node2)+G;
                if input(i1,5)~=0
                    B(node2) = B(node2)+input(i1,5)/input(i1,4);
                end
            end
            if node1~=0
                if node2~=0
                    A(node1,node2) = -1*G;
                    A(node2,node1) = -1*G;
                end
            end
            
       end
         A
         B=B'
         for i2 = 1:2
             delta = det(A);
             X =A;
             X(:,i2) = B;
             delta1 = det(X);
             Y = delta1/delta;
             V(i2) = Y;
         end
         V
                  
             
         
       