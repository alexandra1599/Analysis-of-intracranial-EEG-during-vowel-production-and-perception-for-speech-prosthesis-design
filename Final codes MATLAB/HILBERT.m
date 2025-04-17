%HILBERT POWER

x1 = streams(2);
data1 = x1{1, 1}.time_series(:,:);
time1 = x1{1,1}.time_stamps;
fs1 = streams{1, 2}.segments.effective_srate;
idx = (idx/fs)*fs1; 
windowlength = 0.5*fs1;
nfft = 2^nextpow2(windowlength);

%%
zspeech = [];  
N = round(0.05*fs1); % 50ms
f=1;f1=1;f2=1;a=0;
s1=0;s2=0;s3=0;s4=0;s5=0;s6=0;
prespeech=[];postspeech=[];simspeech=[];stderrorpost=[];

Wo = 50/(fs1/2);  
BW = Wo/35;
[b,a] = iirnotch(Wo,BW); 
data1 = filter(b,a,data1);

Wo = 100/(fs1/2);  
BW = Wo/35;
[b,a] = iirnotch(Wo,BW); 
data1 = filter(b,a,data1);

Wo = 150/(fs1/2);  
BW = Wo/35;
[b,a] = iirnotch(Wo,BW); 
filtered_data = filter(b,a,data1);

% 8BP FILTERS in the HG FREQ BAND
[b1,a1] = butter(4,[2, 3.5]/(fs1/2),'bandpass');
% [b2,a2] = butter(4,[81, 90]/(fs1/2),'bandpass');
% [b3,a3] = butter(4,[91, 100]/(fs1/2),'bandpass');
% [b4,a4] = butter(4,[101, 120]/(fs1/2),'bandpass');
% [b5,a5] = butter(4,[121, 135]/(fs1/2),'bandpass');
% [b6,a6] = butter(4,[136, 150]/(fs1/2),'bandpass');
% [b7,a7] = butter(4,[151, 170]/(fs1/2),'bandpass');
% [b8,a8] = butter(4,[171, 200]/(fs1/2),'bandpass');

filtered_channel1 = double(filtfilt(b1,a1,data1));
% filtered_channel2 = double(filtfilt(b2,a2,data1));
% filtered_channel3 = double(filtfilt(b3,a3,data1));
% filtered_channel4 = double(filtfilt(b4,a4,data1));
% filtered_channel5 = double(filtfilt(b5,a5,data1));
% filtered_channel6 = double(filtfilt(b6,a6,data1));
% filtered_channel7 = double(filtfilt(b7,a7,data1));
% filtered_channel8 = double(filtfilt(b8,a8,data1));

%%
 stdsilence = 0;
   fd = 90;
   fu = 110;
   
   hgammasb = bandpass(data1,[fd fu],fs);
  

% Get the std of silent segments
for k=1:1:size(data1)
   powersilence = [];
   for i = 1:1:size(idx,1)-4
   startspeech = idx(i,1)-(windowlength); 
   endspeech =idx(i,2)+(windowlength);
   startsilence = idx(i,2)+(windowlength/4);
   endsilence = startsilence + ((endspeech - startspeech)); 

    datasilence1 = hgammasb(k,startsilence:endsilence);
    
 

     hilb11 = abs(hilbert(datasilence1));

     hilb = hilb11.^2;
   powersilence = [powersilence; hilb(1,1:1000)];

   end
end
stdsilence = mean(std(powersilence));
    
index=[];indexpre=[];indexsim=[];

label_group1 = ["start;oo","start;uu","start;eu"];
label_group2 = ["start;oe","start;ee","start;ie"];

%% 
v_ohilbert=[];v_uhilbert=[];v_euhilbert=[];v_oehilbert=[];v_ehilbert=[];v_iehilbert=[];
zspeech=[]; counter_o = 0; counter_oe = 0; counter_e = 0; counter_u = 0;
counter_ie = 0; counter_eu = 0;

%I will get 6 arrays (1 for each vowel)
%Each array will be of size (#channels*#trials, time points)
%for example array for vowel 1 will contain : 
%[ch1tr1; ch1tr2; ... ; chntrm]
fd = 90;
fu = 110;
hgamma = bandpass(data1,[fd fu],fs);
  

for i =1:1:size(data1,1) 
%zspeech=[];

  for k=9:1:size(idx,1)-4
  pow=[];avgsilence = 0;

  startspeech = idx(k,1)-(windowlength); 
  endspeech =idx(k,2)+(windowlength);
  startsilence_before = idx(k-1,2)+(windowlength/4); 
  endsilence_before = startsilence_before + (endspeech - startspeech);
  startsilence_after = idx(k,2)+(windowlength/4); 
  endsilence_after = startsilence_after + (endspeech - startspeech);
  
   datasilence1 = hgamma(i,startsilence_after:endsilence_after);
  dataspeech1 = hgamma(i,startspeech:endspeech);
  datasilence11 = hgamma(i,startsilence_before:endsilence_before);
 
%HILBERT

  hilbhgamma = abs(hilbert(dataspeech1));
  hilbhgammasb = abs(hilbert(datasilence11));
  hilbhgammasa = abs(hilbert(datasilence1));

 

  phgamma = hilbhgamma.^2;
  phgammas = ((hilbhgammasb.^2)+(hilbhgammasa.^2))/2;


  gz = zscore(phgamma);

   s = streams{1,1}.time_series(2*k);
  s = strip(s,'right'); 
  st = string(s);   

   if(strcmp(label_group1(1),st))%||strcmp(label_group1(2),st)||strcmp(label_group1(3),st))
       v_ohilbert = [v_ohilbert; gz(1,1:1000)];
       counter_o = counter_o+1;

   end
   if(strcmp(label_group1(2),st))%label_group2(1),st)||strcmp(label_group2(2),st)||strcmp(label_group2(3),st))
       v_uhilbert = [v_uhilbert;gz(1,1:1000)];
       counter_u = counter_u+1;

   end
   if(strcmp(label_group1(3),st))%label_group2(1),st)||strcmp(label_group2(2),st)||strcmp(label_group2(3),st))
       v_euhilbert = [v_euhilbert;gz(1,1:1000)];
        counter_eu = counter_eu+1;
   end
   if(strcmp(label_group2(1),st))%label_group2(1),st)||strcmp(label_group2(2),st)||strcmp(label_group2(3),st))
       v_oehilbert = [v_oehilbert;gz(1,1:1000)];
        counter_oe = counter_oe+1;

   end
   if(strcmp(label_group2(2),st))%label_group2(1),st)||strcmp(label_group2(2),st)||strcmp(label_group2(3),st))
       v_ehilbert = [v_ehilbert;gz(1,1:1000)];
        counter_e = counter_e+1;

   end
   if(strcmp(label_group2(3),st))%label_group2(1),st)||strcmp(label_group2(2),st)||strcmp(label_group2(3),st))
       v_iehilbert = [v_iehilbert;gz(1,1:1000)];
        counter_ie = counter_ie+1;

   end
  end
end


 %% Bootstrap zscore plots
vowels=[];p=1;p1=1;p2=1;
%use the counters to get the number of trials for each vowels
p=counter_e/size(data1,1);
    p1=counter_eu/size(data1,1);
    p2=counter_ie/size(data1,1);
p3=counter_o/size(data1,1);
p4=counter_oe/size(data1,1);
p5=counter_u/size(data1,1);

for j = 1:1:2 %iterate over the channels
    
  % all trials all vowels for one channel
  vowels = [v_ehilbert((j-1)*p+1:j*p,50:end);v_euhilbert((j-1)*p1+1:j*p1,50:end);v_iehilbert((j-1)*p2+1:j*p2,50:end);v_ohilbert((j-1)*p3+1:j*p3,50:end);v_oehilbert((j-1)*p4+1:j*p4,50:end);v_uhilbert((j-1)*p5+1:j*p5,50:end)];
  % random shuffle of the vowels
  for i=1:1:10000000
  vowels = vowels(randperm(size(vowels,1)),:);
  vowels = vowels(randperm(size(vowels,1)),:);
  vowels = vowels(randperm(size(vowels,1)),:);
  vowels = vowels(randperm(size(vowels,1)),:);
  vowels = vowels(randperm(size(vowels,1)),:);
  vowels = vowels(randperm(size(vowels,1)),:);
  vowels = vowels(randperm(size(vowels,1)),:);
  vowels = vowels(randperm(size(vowels,1)),:);
  vowels = vowels(randperm(size(vowels,1)),:);
  vowels = vowels(randperm(size(vowels,1)),:);

  end

  v_e1 = vowels(1:size(v_ehilbert((j-1)*p+1:j*p,:),1),:);
  s1=size(v_e1)+size(v_euhilbert(j:(j-1)*p1+1:j*p1,:),1);
  v_eu1 = vowels(size(v_ehilbert((j-1)*p+1:j*p,:),1)+1:s1,:);
  s2=s1+size(v_iehilbert((j-1)*p2+1:j*p2,:),1);
  v_ie1 = vowels(s1+1:s2,:);
 s3 = s2+size(v_ohilbert((j-1)*p3+1:j*p3,:),1);
  v_o1 = vowels(s2+1:s3,:);
  s4=s3+size(v_oehilbert((j-1)*p4+1:j*p4,:),1);
  v_oe1 = vowels(s3+1:s4,:);
s5=s4+size(v_uhilbert((j-1)*p5+1:j*p5,:),1);
  v_u1 = vowels(s4+1:s5,:);

  figure();
  plot(mean(v_e1), 'Color', 'cyan', 'LineWidth',1);
  hold on
  plot(mean(v_eu1), 'Color', 'green', 'LineWidth',1);
  hold on
  plot(mean(v_ie1), 'Color', 'magenta', 'LineWidth',1);
  hold on
  plot(mean(v_o1), 'Color', 'red', 'LineWidth',1);
  hold on
  plot(mean(v_oe1), 'Color', 'black', 'LineWidth',1);
  hold on
  plot(mean(v_u1), 'Color', 'blue', 'LineWidth',1);
  title("Bootstrapping Analysis for channel "  + floor(j/10))
  xlabel("Time (ms)")
  ylabel("Amplitude")
  %ylim([-100,100])
end

%%
for k=1 %:1:10
   figure();
  plot(mean(v_ehilbert(k:k+7,50:end)), 'Color', 'cyan', 'LineWidth',2);
   hold on
   plot(mean(v_euhilbert(k:k+9,50:end)), 'Color', 'green', 'LineWidth',2);
  hold on
  plot(mean(v_iehilbert(k:k+9,50:end)), 'Color', 'magenta', 'LineWidth',2);
  hold on
  plot(mean(v_ohilbert(k:k+8,50:end)), 'Color', 'red', 'LineWidth',2);
  hold on
  % plot((v_oehilbert(1,:)), 'Color', 'black', 'LineWidth',2);
  % hold on
  plot(mean(v_uhilbert(k:k+8,50:end)), 'Color', 'blue', 'LineWidth',2);
  title("Average Z-score over all trials for channel " + k)
  xlabel("Time (ms)")
  ylabel("Amplitude")
  legend('e','eu','ie','o','u');
 end

%% ML kh-30
%labels array 
labels_train =[];labels_test=[];
e=[1,0,0,0,0,0];oe=[0,1,0,0,0,0];eu=[0,0,1,0,0,0];ie=[0,0,0,1,0,0];
o=[0,0,0,0,1,0];u=[0,0,0,0,0,1]; %1 encoding labels

for i=1:1:floor(0.7*(counter_e/size(data1,1)))
    labels_train = [labels_train; 'ee'];
end
for i=1:1:floor(0.7*(counter_oe/size(data1,1)))
    labels_train = [labels_train; 'oe'];
end
for i=1:1:floor(0.7*(counter_eu/size(data1,1)))
    labels_train = [labels_train; 'eu'];
end
for i=1:1:floor(0.7*(counter_ie/size(data1,1)))
    labels_train = [labels_train; 'ie'];
end
for i=1:1:floor(0.7*(counter_o/size(data1,1)))
    labels_train = [labels_train; 'oo'];
end
for i=1:1:floor(0.7*(counter_u/size(data1,1)))
    labels_train = [labels_train; 'uu'];
end
for i=1:1:(counter_oe/size(data1,1))-floor(0.7*(counter_oe/size(data1,1)))
    labels_test = [labels_test; 'oe'];
end
for i=1:1:(counter_e/size(data1,1))-floor(0.7*(counter_e/size(data1,1)))
    labels_test = [labels_test; 'ee'];
end
for i=1:1:(counter_u/size(data1,1))-floor(0.7*(counter_u/size(data1,1)))
    labels_test = [labels_test; 'uu'];
end
for i=1:1:(counter_eu/size(data1,1))-floor(0.7*(counter_eu/size(data1,1)))
    labels_test = [labels_test; 'eu'];
end
for i=1:1:(counter_o/size(data1,1))-floor(0.7*(counter_o/size(data1,1)))
    labels_test = [labels_test; 'oo'];
end
for i=1:1:(counter_ie/size(data1,1))-floor(0.7*(counter_ie/size(data1,1)))
    labels_test = [labels_test; 'ie'];
end
%%
%kh-30 : divide the channels per brain region and then run the SVM to get more trials 


  k1=floor(0.7*(counter_e/size(data1,1)));
  k2=(counter_e/size(data1,1));
  k3=floor(0.7*(counter_o/size(data1,1)));
  k4=(counter_o/size(data1,1));
  k5=floor(0.7*(counter_oe/size(data1,1)));
  k6=(counter_oe/size(data1,1));
  k7=floor(0.7*(counter_eu/size(data1,1)));
  k8=(counter_eu/size(data1,1));
  k9=floor(0.7*(counter_ie/size(data1,1)));
  k10=(counter_ie/size(data1,1));
  k11=floor(0.7*(counter_u/size(data1,1)));
  k12=(counter_u/size(data1,1));

  generror_before = zeros(size(data1,1));
  generror = zeros(size(data1,1)); generror_after = zeros(size(data1,1));

  %%
  p=counter_e/size(data1,1);
    p1=counter_eu/size(data1,1);
    p2=counter_ie/size(data1,1);
p3=counter_o/size(data1,1);
p4=counter_oe/size(data1,1);
p5=counter_u/size(data1,1);

for j=55:1:67  %go over every channel individually
  ve = v_ehilbert((j-1)*p+1:j*p,50:end);
  veu = v_euhilbert((j-1)*p1+1:j*p1,50:end);
  vie = v_iehilbert((j-1)*p2+1:j*p2,50:end);
  vo = v_ohilbert((j-1)*p3+1:j*p3,50:end);
  voe = v_oehilbert((j-1)*p4+1:j*p4,50:end);
  vu = v_uhilbert((j-1)*p5+1:j*p5,50:end);

  % DATA FOR SVM BEFORE SPEECH ONSET (t=500)
  vowel_train_before = [ve(1:k1,1:400);voe(1:k5,1:400);veu(1:k7,1:400);vie(1:k9,1:400);vo(1:k3,1:400);vu(1:k11,1:400)];
  vowel_test_before = [voe(k5+1:k6,1:400);ve(k1+1:k2,1:400);vu(k11+1:k12,1:400);veu(k7+1:k8,1:400);vo(k3+1:k4,1:400);vie(k9+1:k10,1:400)];

  cl = fitcecoc(vowel_train_before,labels_train);
v1 = predict(cl,vowel_test_before);
CVcl = crossval(cl);
generror_before(j) = kfoldLoss(CVcl);

hf=figure;
confusionchart(hf,labels_test,v1,"RowSummary","row-normalized","ColumnSummary","column-normalized")
title("Confusion Matrix before speech for channel " + j)

%    % DATA FOR SVM AT SPEECH ONSET (t=500)
  vowel_train_onset = [ve(1:k1,410:710);voe(1:k5,410:710);veu(1:k7,410:710);vie(1:k9,410:710);vo(1:k3,410:710);vu(1:k11,410:710)];
  vowel_test_onset = [voe(k5+1:k6,410:710);ve(k1+1:k2,410:710);vu(k11+1:k12,410:710);veu(k7+1:k8,410:710);vo(k3+1:k4,410:710);vie(k9+1:k10,410:710)];


  cl1 = fitcecoc(vowel_train_onset,labels_train);
v11 = predict(cl1,vowel_test_onset);
CVcl1 = crossval(cl1);
generror(j) = kfoldLoss(CVcl1);

hf1=figure;
confusionchart(hf1,labels_test,v11,"RowSummary","row-normalized","ColumnSummary","column-normalized")
title("Confusion Matrix at speech onset for channel " + j)

   % DATA FOR SVM AFTER SPEECH ONSET (t=500)
   vowel_train_after = [ve(1:k1,750:900);voe(1:k5,750:900);veu(1:k7,750:900);vie(1:k9,750:900);vo(1:k3,750:900);vu(1:k11,750:900)];
  vowel_test_after = [voe(k5+1:k6,750:900);ve(k1+1:k2,750:900);vu(k11+1:k12,750:900);veu(k7+1:k8,750:900);vo(k3+1:k4,750:900);vie(k9+1:k10,750:900)];


    cl2 = fitcecoc(vowel_train_after,labels_train);
v12 = predict(cl2,vowel_test_after);
CVcl2 = crossval(cl2);
generror_after(j) = kfoldLoss(CVcl2);

hf2=figure;
confusionchart(hf2,labels_test,v12,"RowSummary","row-normalized","ColumnSummary","column-normalized")
title("Confusion Matrix after speech onset for channel " + j)
end

%%

%# number of cross-validation folds:
%# If you have 50 samples, divide them into 10 groups of 5 samples each,
%# then train with 9 groups (45 samples) and test with 1 group (5 samples).
%# This is repeated ten times, with each group used exactly once as a test set.
%# Finally the 10 results from the folds are averaged to produce a single 
%# performance estimation.
k=8;
labels = ["ee","eu", "ie","oo","oe","uu"];
cvFolds = crossvalind('Kfold',labels, k);   %# get indices of 10-fold CV
cp = classperf(labels); %# init performance tracker

for j=78:1:89

 ve = v_ehilbert((j-1)*p+1:j*p,:);
  veu = v_euhilbert((j-1)*p1+1:j*p1,:);
  vie = v_iehilbert((j-1)*p2+1:j*p2,:);
  vo = v_ohilbert((j-1)*p3+1:j*p3,:);
  voe = v_oehilbert((j-1)*p4+1:j*p4,:);
  vu = v_uhilbert((j-1)*p5+1:j*p5,:);

 vowel_train_after = [ve(1:k1,400:500);voe(1:k5,400:500);veu(1:k7,400:500);vie(1:k9,400:500);vo(1:k3,400:500);vu(1:k11,400:500)];
  vowel_test_after = [voe(k5+1:k6,400:500);ve(k1+1:k2,400:500);vu(k11+1:k12,400:500);veu(k7+1:k8,400:500);vo(k3+1:k4,400:500);vie(k9+1:k10,400:500)];

  cl2 = fitcecoc(vowel_train_after,labels_train,'Learners',templateSVM('Standardize',true));
v12 = predict(cl2,vowel_test_after);
CVcl2 = crossval(cl2);
generror_after(j) = kfoldLoss(CVcl2);

hf2=figure;
confusionchart(hf2,labels_test,v12,"RowSummary","row-normalized","ColumnSummary","column-normalized")
title("Confusion Matrix after speech onset for channel " + j)
end