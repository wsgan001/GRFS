clear;	
load('COIL20.mat');
nClass = length(unique(gnd));


L = zeros(1440,1440);
alpha = 1;
belta = 0;
epsilon = 0.1;
lamda_last = mlt_main_function(fea',L,alpha,belta,epsilon);


lamda_last_row = zeros(1,1024);
for i = 1:1024
lamda_last_row(1,i) = lamda_last(i,i);
end


[lamda_last_row_sort,ind] = sort(lamda_last_row);

fea_new = zeros(1440,100);
for r=1:100
    fea_new(:,ind(end-r+1)) = fea(:,ind(end-r+1));
end
fea_new = NormalizeFea(fea_new);
fprintf('the fea_new is :');
disp(fea_new);


rand('twister',5489);
label = litekmeans(fea_new,nClass,'Replicates',10);
MIhat = MutualInfo(gnd,label);
disp(['kmeans use some of the features. MIhat: ',num2str(MIhat)]);
