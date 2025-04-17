%% DATA CLEANING 
%streams = loadxdf('/Users/alexandramikhael/Downloads/vowel Netherland/kh28_vowels.xdf');
x1 = streams(2);
data1 = x1{1, 1}.time_series(:,:);
time1 = x1{1,1}.time_stamps;
fs1 = streams{1, 2}.segments.effective_srate;
windowlength = 0.5*fs1;
nfft = 2^nextpow2(windowlength);

%% STEP 1 : Group the channels by probe 

%kh-28
pr1 = data1(1:11,:); avgchannel_pr1 = mean(pr1);
pr2 = data1(12:27,:);avgchannel_pr2 = mean(pr2);
pr3 = data1(28:38,:);avgchannel_pr3 = mean(pr3);
pr4 = data1(39:48,:);avgchannel_pr4 = mean(pr4);
pr5 = data1(49:59,:);avgchannel_pr5 = mean(pr5);
pr6 = data1(60:68,:);avgchannel_pr6 = mean(pr6); %really noisy
pr7 = data1(69:76,:);avgchannel_pr7 = mean(pr7); % really noisy
pr8 = data1(77:83,:);avgchannel_pr8 = mean(pr8);
pr9 = data1(84:94,:);avgchannel_pr9 = mean(pr9); % need to remove 8th channel (EKG)
pr10 = data1(96:104,:);avgchannel_pr10 = mean(pr10); %really noisy
pr11 = data1(105:110,:);avgchannel_pr11 = mean(pr11);
pr12 = data1(111:120,:);avgchannel_pr12 = mean(pr12);
pr13 = data1(121:129,:);avgchannel_pr13 = mean(pr13);

% STEP 2 : Apply CAR :

% kh-28
for i = 1:1:size(pr1,1)
    pr1(i,:) = pr1(i,:) - avgchannel_pr1;
    pr3(i,:) = pr3(i,:) - avgchannel_pr3;
    pr5(i,:) = pr5(i,:) - avgchannel_pr5;
    pr9(i,:) = pr9(i,:) - avgchannel_pr9;
end
for i =1:1:size(pr7,1)
    pr7(i,:) = pr7(i,:) - avgchannel_pr7;   
end
for i =1:1:size(pr4,1)
    pr4(i,:) = pr4(i,:) - avgchannel_pr4;  
    pr12(i,:) = pr12(i,:) - avgchannel_pr12;

end
for i = 1:1:size(pr10,1)
    pr10(i,:) = pr10(i,:) - avgchannel_pr10;
    pr13(i,:) = pr13(i,:) - avgchannel_pr13;
    pr6(i,:) = pr6(i,:) - avgchannel_pr6;
end
for i = 1:1:size(pr2,1)
    pr2(i,:) = pr2(i,:) - avgchannel_pr2;
end
for i = 1:1:size(pr11,1)
    pr11(i,:) = pr11(i,:) - avgchannel_pr11;
end
for i = 1:1:size(pr8,1)
    pr8(i,:) = pr8(i,:) - avgchannel_pr8;
end

data1 = [pr1; pr2; pr3; pr4; pr5 ;pr6; pr7 ; pr8;  pr9; pr10; pr11; pr12; pr13];


%% kh-30 
pr1 = data1(1:12,:); avgchannel_pr1 = mean(pr1);
pr2 = data1(16:22,:);avgchannel_pr2 = mean(pr2);
pr3 = data1(26:32,:);avgchannel_pr3 = mean(pr3);
pr4 = data1(34:40,:);avgchannel_pr4 = mean(pr4);
pr5 = data1(41:55,:);avgchannel_pr5 = mean(pr5);
pr6 = data1(56:64,:);avgchannel_pr6 = mean(pr6); %really noisy !!! REMOVE
pr7 = data1(66:77,:);avgchannel_pr7 = mean(pr7); 
pr8 = data1(78:87,:);avgchannel_pr8 = mean(pr8);
pr9 = data1(89:94,:);pr9 = [pr9; data1(96:98,:)];avgchannel_pr9 = mean(pr9); % REMOVE!!!!
pr10 = data1(99:105,:);avgchannel_pr10 = mean(pr10); 
pr11 = data1(106:111,:);avgchannel_pr11 = mean(pr11);
pr12 = data1(115:126,:);avgchannel_pr12 = mean(pr12);

for i = 1:1:size(pr1,1)
    pr1(i,:) = pr1(i,:) - avgchannel_pr1;
    pr7(i,:) = pr7(i,:) - avgchannel_pr7;
      pr12(i,:) = pr12(i,:) - avgchannel_pr12;
end
for i = 1:1:size(pr2,1)
    pr2(i,:) = pr2(i,:) - avgchannel_pr2;
    pr3(i,:) = pr3(i,:) - avgchannel_pr3;
    pr4(i,:) = pr4(i,:) - avgchannel_pr4;
    pr10(i,:) = pr10(i,:) - avgchannel_pr10;
end
for i = 1:1:size(pr8,1)
    pr8(i,:) = pr8(i,:) - avgchannel_pr8;
end
for i =1:1:size(pr5,1)
    pr5(i,:) = pr5(i,:) - avgchannel_pr5;
end
for i =1:1:size(pr6,1)
    pr6(i,:) = pr6(i,:) - avgchannel_pr6;
    pr9(i,:) = pr9(i,:) - avgchannel_pr9;
end
for i = 1:1:size(pr11,1)
    pr11(i,:) = pr11(i,:) - avgchannel_pr11;
end



data1 = [pr1; pr2; pr3; pr4; pr5 ;pr6; pr7 ; pr8;  pr9; pr10; pr11; pr12];

%% kh-31
pr1 = data1(1:10,:); avgchannel_pr1 = mean(pr1);
pr2 = data1(11:20,:);avgchannel_pr2 = mean(pr2);
pr3 = data1(21:30,:);avgchannel_pr3 = mean(pr3);
pr4 = data1(31:40,:);avgchannel_pr4 = mean(pr4);
pr5 = data1(41:51,:);avgchannel_pr5 = mean(pr5);
pr6 = data1(52:62,:);avgchannel_pr6 = mean(pr6); 
pr7 = data1(64:73,:);avgchannel_pr7 = mean(pr7); % really noisy DO NOT USE
pr8 = data1(74:82,:);avgchannel_pr8 = mean(pr8);
pr9 = data1(83:90,:);avgchannel_pr9 = mean(pr9); 

for i = 1:1:size(pr1,1)
    pr1(i,:) = pr1(i,:) - avgchannel_pr1;
    pr2(i,:) = pr2(i,:) - avgchannel_pr2;
    pr3(i,:) = pr3(i,:) - avgchannel_pr3;
    pr4(i,:) = pr4(i,:) - avgchannel_pr4;
    pr7(i,:) = pr7(i,:) - avgchannel_pr7;
end
for i = 1:1:size(pr5,1)
    pr5(i,:) = pr5(i,:) - avgchannel_pr5;
    pr6(i,:) = pr6(i,:) - avgchannel_pr6;
end
for i = 1:1:size(pr8,1)
    pr8(i,:) = pr8(i,:) - avgchannel_pr8; 
end
for i = 1:1:size(pr9,1)
    pr9(i,:) = pr9(i,:) - avgchannel_pr9;
end
data1 = [pr1; pr2; pr3; pr4; pr5 ;pr6; pr7 ; pr8;  pr9];
