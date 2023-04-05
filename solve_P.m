function [ P ] = solve_P(P,B,Y,paras)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
% parms
classnum = paras.classnum;
lambda1  = paras.lambda1;
N        =  size(B,2);
%% 1

opts.record = 0;
opts.mxitr  = 100;
opts.xtol   = 1e-5;
opts.gtol   = 1e-5;
opts.ftol   = 1e-8;
% % learn
F1         = B*B';
F2         = -2*Y*B';
F3         = ones(1,classnum);
F4         = lambda1*B*B';
F5         = -2*lambda1*B*ones(N ,1);
[P, ~]     = OptStiefelGBB(P,@myfun,opts,F1,F2,F3,F4,F5);


end

function [F, G] = myfun(P,A1,A2,A3,A4,A5)
    F = trace(P'*A1*P)+trace(A2*P)+trace(A3*P'*A4*P*A3')+trace(A3*P'*A5);
    G = 2*A1*P+A2'+2*A4*P*A3'*A3+A5*A3;
end


