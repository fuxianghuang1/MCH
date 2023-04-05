function [b_train,b_test] = deep(train_data,test_data,Y,paras)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
nbit    = paras.bitsize;
D_train = train_data;
D_test  = test_data;
if paras.nlevels==1
      [b_train,b_test] = BLH(train_data,test_data,Y,paras);
else  
    paras.bitsize = paras.p_nbits;
    for n =1:paras.nlevels-1
       
       [temp_btrain,temp_btest] = BLH( D_train,D_test,Y,paras);
       D_train = [D_train;temp_btrain];
       D_test  = [D_test;temp_btest];      
    end
       paras.bitsize    = nbit;
       [b_train,b_test] = BLH(D_train,D_test,Y,paras);
end

end

