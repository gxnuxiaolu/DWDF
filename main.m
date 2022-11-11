%% DWDF paper code
addpath('function');
image_set = 'Oxford5k';
% image_set = 'Paris6k';
% image_set = 'Oxford105k';
% image_set = 'Paris106k';
% image_set = 'Holidays';
%% compute image feature vectors
pool5 = dir(['..\datasets\',image_set,'\pool5\*.mat']);
dataset = dir(['..\datasets\',image_set,'\photo\*.jpg']);
num = size(pool5,1);
feature = [];

parfor i=1:num
    fe_path = pool5(i).folder+"\"+pool5(i).name;
    feature_mat = importdata(fe_path);
    tu_path = dataset(i).folder+"\"+dataset(i).name;
    im = imread(tu_path);
    c = flw(im,feature_mat);  
    a = sw(feature_mat);
    a = a.*c;
    feature(i,:) = a;
end

if strcmp(image_set,'Oxford5k')
    oxford_feature = feature;
    save('..\representation\DWDF\Oxford5k\oxford_feature.mat','oxford_feature');
elseif strcmp(image_set,'Paris6k')
    paris_feature = feature;
    save('..\representation\DWDF\Paris6k\paris_feature.mat','paris_feature');
elseif strcmp(image_set,'Holidays')
    holidays_feature = feature;
    save('..\representation\DWDF\Holidays\holidays_feature.mat','holidays_feature');
elseif strcmp(image_set,'Oxford105k')
    oxford105k_feature = feature;
    save('..\representation\DWDF\Oxford105k\oxford105k_feature.mat','oxford105k_feature');
elseif strcmp(image_set,'Paris106k')
    paris106k_feature = feature;
    save('..\representation\DWDF\Paris106k\paris106k_feature.mat','paris106k_feature');
end
%% compute query image feature vectors
pool5 = dir(['..\datasets\',image_set,'\query\*.mat']);
dataset = dir(['..\datasets\',image_set,'\query_images\*.jpg']);
num = size(pool5,1);
query_feature = [];

parfor i = 1:num
    fe_path = pool5(i).folder+"\"+pool5(i).name;
    feature_mat = importdata(fe_path);
    tu_path = dataset(i).folder+"\"+dataset(i).name;
    im = imread(tu_path);
    c = flw(im,feature_mat);    
    a = sw(feature_mat);
    a = a.*c;
    query_feature(i,:) = a;
end

if strcmp(image_set,'Oxford5k')
    save('..\representation\DWDF\Oxford5k\query_feature.mat','query_feature');
elseif strcmp(image_set,'Paris6k')
    save('..\representation\DWDF\Paris6k\query_feature.mat','query_feature');
elseif strcmp(image_set,'Holidays')
    save('..\representation\DWDF\Holidays\query_feature.mat','query_feature');
elseif strcmp(image_set,'Oxford105k')
    save('..\representation\DWDF\Oxford105k\query_feature.mat','query_feature');
elseif strcmp(image_set,'Paris106k')
    save('..\representation\DWDF\Paris106k\query_feature.mat','query_feature');
end
%% compute mAP (Execute PCA_Whitening first )
clear;
addpath('function');
% Whether to perform  QE. If you execute QE, please set the size of K.
% For example, K is equal to top 10. K = 10;
K = 0; 
% image_set = 'Oxford5k';
% image_set = 'Oxford105k';
% image_set = 'Paris6k';
% image_set = 'Paris106k';
image_set = 'Holidays';
% Choose how to calculate distance 
% L1            type = 1; 
% L2            type = 2;
% Cosine        type = 3;
% Correlation   type = 4;
type = 2;
mAP = zeros(1,3);
dim = [128,256,512];
if strcmp(image_set,'Oxford5k')
    for i = 1:size(dim,2)
        load('..\representation\DWDF\Oxford5k\query_feature.mat');
        load('..\representation\DWDF\Oxford5k\oxford_feature.mat');
        load('..\representation\DWDF\Paris6k\paris_feature.mat');
        [oxford_feature,query_feature] = pca_whitening(oxford_feature,paris_feature,query_feature,dim(i));
        mAP(i) = compute_mAP(oxford_feature,query_feature,K,image_set,type);
        fprintf('dim = %d  mAP = %.4f\n',dim(i),mAP(i));
    end
elseif strcmp(image_set,'Paris6k')
    for i = 1:size(dim,2)
        load('..\representation\DWDF\Paris6k\query_feature.mat');
        load('..\representation\DWDF\Oxford5k\oxford_feature.mat');
        load('..\representation\DWDF\Paris6k\paris_feature.mat');
        [paris_feature,query_feature] = pca_whitening(paris_feature,oxford_feature,query_feature,dim(i));
        mAP(i) = compute_mAP(paris_feature,query_feature,K,image_set,type);
        fprintf('dim = %d  mAP = %.4f\n',dim(i),mAP(i));
    end
elseif strcmp(image_set,'Holidays')
    for i = 1:size(dim,2)
        load('..\representation\DWDF\Holidays\query_feature.mat');
        load('..\representation\DWDF\Oxford5k\oxford_feature.mat');
        load('..\representation\DWDF\Holidays\holidays_feature.mat');
        [holidays_feature,query_feature] = pca_whitening(holidays_feature,oxford_feature,query_feature,dim(i));
        mAP(i) = compute_mAP(holidays_feature,query_feature,K,image_set,type);
        fprintf('dim = %d  mAP = %.4f\n',dim(i),mAP(i));
    end
elseif strcmp(image_set,'Oxford105k')
    for i = 1:size(dim,2)
        load('..\representation\DWDF\Oxford105k\query_feature.mat');
        load('..\representation\DWDF\Paris6k\paris_feature.mat');
        load('..\representation\DWDF\Oxford105k\oxford105k_feature.mat');
        [oxford105k_feature,query_feature] = pca_whitening(oxford105k_feature,paris_feature,query_feature,dim(i));
        mAP(i) = compute_mAP(oxford105k_feature,query_feature,K,image_set,type);
        fprintf('dim = %d  mAP = %.4f\n',dim(i),mAP(i));
    end
elseif strcmp(image_set,'Paris106k')
    for i = 1:size(dim,2)
        load('..\representation\DWDF\Paris106k\query_feature.mat');
        load('..\representation\DWDF\Oxford5k\oxford_feature.mat');
        load('..\representation\DWDF\Paris106k\paris106k_feature.mat');
        [paris106k_feature,query_feature] = pca_whitening(paris106k_feature,oxford_feature,query_feature,dim(i));
        mAP(i) = compute_mAP(paris106k_feature,query_feature,K,image_set,type);
        fprintf('dim = %d  mAP = %.4f\n',dim(i),mAP(i));
    end
end
rmpath('function');

