% Nodal Analysis

%AV=B
% A is coefficient matrix with self and mutual conductances
    %(self-positive,  mutual-negative)
% B is the source currents of the form Vs/R or Is

clc; clear;
    
%INPUT- circuit data
%Col-1: Element
%Col-2: From
%Col-3: To
%Col-4: R
%Col-5: Vs
%Col-6: Is
% 0th node - reference node
input =[1  0   1   10  100 0;
       2   1   0   20  0   0;
       3   1   2   10  0   0;
       4   2   0   20  0   0;
       5   0   2   0   0   2];
   nodes = max(max(input(:,2), input(:,3)));
   elements = size(input,1);
   
   A = zeros(nodes,nodes);  % coefficient matrix
   B = zeros(1,nodes);     % currents due to voltage and current sources
   
   %CALCULATION OF A, B
       for i1 = 1:elements
           node1 = input(i1,2);
            node2 = input(i1,3);
            R = input(i1,4);
            
            if input(i1,6)==0 % Resistance in series with current sources to be neglected
                G = 1/R;
            else G=0;
            end
            
            if node1~=0 % reference node to be neglected
                A(node1,node1)=A(node1,node1)+G;  % self conductance              
                B(node1) = B(node1)+ input(i1,5)*G +input(i1,6);
                
            end
            if node2~=0
                A(node2,node2)=A(node2,node2)+G;
                B(node2) = B(node2)+ input(i1,5)*G +input(i1,6);
                
            end
            %mutual conductance
            if node1~=0
                if node2~=0
                    A(node1,node2) = -1*G;
                    A(node2,node1) = -1*G;
                end
            end
            
       end
         A
         B = B'
         
         % Solving voltages using Cramers rule
         for i2 = 1:nodes
             delta = det(A);
             X =A;
             X(:,i2) = B;
             delta1 = det(X);
             Y = delta1/delta;
             V(i2) = Y;
         end
         
         V = V'
                  
             
         
       