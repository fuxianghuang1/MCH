function [ F ] = obj_value( P,B,Y,W,X,classnum,nbit,lambda1,lambda2,lambda3,lambda4)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
N    = size(X,2);
m    = mean(X,2);
M    = repmat(m,1,N );
t1   = ones(1,classnum);
t2   = 0.5*ones(1,N);
t3   = ones(1,nbit);
%COMPUTE 

F    = norm(P'*B-Y,'fro')+lambda1*norm(t1*P'*B-t2)+lambda2*norm(B-W'*X,'fro')+...
      +lambda3*norm(t3*B,'fro')-lambda4*norm(W'*X-W'*M,'fro');
      
  
    
    

end

