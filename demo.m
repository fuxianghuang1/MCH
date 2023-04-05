clc
clear
addpath orth_opt
load('Data')
[traindata,testdata,train_label,test_label,cateTrainTest] = train_test( Data);
traindata = normalize(traindata);
testdata  = normalize(testdata);
%% kernel
tic;
Ntrain = size(traindata,1);
X      = traindata;
% get anchors
n_anchors = 1000;
anchor    = X(randsample(Ntrain, n_anchors),:);
 % for normalized data
PhiX  = exp(-sqdist(X,anchor));
sigma = mean(mean(PhiX,2));
%
Phi_traindata = exp(-sqdist(traindata,anchor)/(2*sigma*sigma))'; %clear traindata;
mu            = mean(Phi_traindata,2);
train_data    = Phi_traindata -repmat(mu,1,size(Phi_traindata ,2)); %clear Phi_traindata;

Phi_testdata  = exp(-sqdist(testdata,anchor)/(2*sigma*sigma))'; %clear testdata
test_data     = Phi_testdata-repmat(mu,1,size(Phi_testdata,2)); %clear Phi_testdata 

%% parameters
paras.bitsize   = 64;   % final output bits number
paras.p_nbits   = 2048; % ahead level bits number
paras.nlevels   = 2;    % [1 3 6]
paras.lambda1   = 1;
paras.lambda2   = 0.0001;
paras.lambda3   = 0.01;
paras.n_iter    = 5;
paras.classnum  = length(unique(train_label));
[paras.d,paras.trainnum] = size(train_data);
%% label matrix
Y = zeros(paras.classnum , length(train_label));
for i=1:length(train_label)
    ind      = train_label(i);
    Y(ind,i) = 1;
end
   
%% learn 
[bin_train,bin_test]  = deep(train_data,test_data,Y,paras);
bin_train             = (bin_train>0);  
bin_test              = (bin_test>0);    
train_time=toc;
train_time
%% evaluation
display('Evaluation...');

hammRadius = 2;

B  = compactbit(bin_train');
tB = compactbit(bin_test');


hammTrainTest = hammingDist(tB, B)';
% hash lookup: precision and reall
Ret = (hammTrainTest <= hammRadius+0.00001);
[Pre, Rec] = evaluate_macro(cateTrainTest, Ret)

% hamming ranking: MAP
[~, HammingRank]=sort(hammTrainTest,1);
MAP = cat_apcal(train_label,test_label,HammingRank)

