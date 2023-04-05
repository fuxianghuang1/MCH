function [B_train,B_test] = BLH( X,test,Y,paras )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%% learn 
% initialize W,B,P
B    = sign(randn(paras.bitsize,paras.trainnum));
P    = rand(paras.bitsize,paras.classnum);

% constant
C   = ones(paras.classnum,paras.classnum);
D   = ones(paras.classnum, paras.trainnum);
XtX = X*X';
XtX = max(XtX,XtX');
for i=1:paras.n_iter
    % update W
  W    = pinv((paras.lambda2-paras.lambda3)*XtX)*(paras.lambda2*X*B'); 
  
    % update B
  T1   =  P*P'+paras.lambda1*P*C*P'+paras.lambda2*eye(paras.bitsize);
  T2   =  P*Y+paras.lambda1*P*D+paras.lambda2*W'*X;
  B    =  sign(T1\T2); 
    % update P
  P    =  solve_P(P,B,Y,paras);

end
 B_train  = sign(W'*X);
 B_test   = sign(W'*test);
end

