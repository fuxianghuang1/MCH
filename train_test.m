function [ X,Y,train_label, test_label,cateTrainTest] = train_test(data)
%UNTITLED2 Summary of this function goes here
ind         = randperm(size(data,1));
data_rand   = data(ind,:);
TEST        = data_rand(1:1000,:);
TRAIN       = data_rand(1001:end,:);
train_label = TRAIN(:,1);
X           = TRAIN(:,2:end);
test_label  = TEST(:,1);
Y           = TEST(:,2:end);

cateTrainTest = bsxfun(@eq, double(train_label),double(test_label'));
end

