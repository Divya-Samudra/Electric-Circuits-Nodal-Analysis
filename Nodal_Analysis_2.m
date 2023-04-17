clc; clear;
% Nodal Analysis
% With current sources alone as a branch (without series resistance)
% Voltage sources alone does not constitute a branch

%input- circuit data
% Col-1: Element
%Col-2: From
%Col-3: To
%Col-4: R
%Col-5: Vs
%Col-6: Is
% 0th node - reference node
input =[1  0   1   2  0   2;
       2   1   0   4  0   0;
       3   1   2   4  0   0;
       4   2   0   2  0   0;
       5   0   2   0  0  4];
   
   A = zeros(2,2);
   B = zeros(1,2);
       for i1 = 1:5
           node1 = input(i1,2);
            node2 = input(i1,3);
            R = input(i1,4);
            if input(i1,6)==0
                G = 1/R;
            else G=0;
            end
            if node1~=0
                A(node1,node1)=A(node1,node1)+G;
                if input(i1,5)~=0
                    B(node1) = B(node1)+input(i1,5)/input(i1,4)+input(i1,6);
                else 
                    B(node1) = B(node1)+input(i1,6);
                end
            end
            if node2~=0
                A(node2,node2)=A(node2,node2)+G;
                if input(i1,5)~=0
                    B(node2) = B(node2)+input(i1,5)/input(i1,4)+input(i1,6);
                else 
                    B(node2) = B(node2)+input(i1,6);
                end
            end
            if node1~=0
                if node2~=0
                    A(node1,node2) = -1*G;
                    A(node2,node1) = -1*G;
                end
            end
            %B = B';
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
                  
             
         
       