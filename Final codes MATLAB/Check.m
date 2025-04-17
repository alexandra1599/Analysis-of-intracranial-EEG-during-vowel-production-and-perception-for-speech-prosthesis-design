% 'delta': [2., 3.5],
%  'theta': [4., 7.],
%  'alpha': [9., 11.],
%  'beta': [15., 30.],
%  'gamma': [35., 55.],
%  'highgamma': [90., 110.] 
 
%CHANNEL 5
v_ohilbert=[];v_uhilbert=[];v_euhilbert=[];v_oehilbert=[];v_ehilbert=[];v_iehilbert=[];
counter_u = 0; counter_oe = 0; counter_o = 0 ; counter_ie = 0; counter_eu = 0; counter_e = 0;
power = [];
channel_counter = 0;
label_group1 = ["start;oo","start;uu","start;eu"];
label_group2 = ["start;oe","start;ee","start;ie"];

for i = 1:1:size(data1,1) 
%zspeech=[];

  for k=3:1:size(idx,1)-1

startspeech = idx(k,1)-(windowlength); 
  endspeech =idx(k,2)+(windowlength);
  startsilence_before = idx(k-1,2)+(windowlength/4); 
  endsilence_before = startsilence_before + (endspeech - startspeech);
  startsilence_after = idx(k,2)+(windowlength/4); 
  endsilence_after = startsilence_after + (endspeech - startspeech);

datasilence1 = data1(i,startsilence_after:endsilence_after);
dataspeech1 = data1(i,startspeech:endspeech);
datasilence11 = data1(i,startsilence_before:endsilence_before);

fs = Fs;
t = 0:1/fs:1;
% fd = 2;
% fu = 3.5;
% delta = bandpass(dataspeech1,[fd fu],fs);
% deltasb = bandpass(datasilence1,[fd fu],fs);
% deltasa = bandpass(datasilence11,[fd fu],fs);
% fd = 4;
% fu = 7;
% theta = bandpass(dataspeech1,[fd fu],fs);
% thetasb = bandpass(datasilence1,[fd fu],fs);
% thetasa = bandpass(datasilence11,[fd fu],fs);
% fd = 9;
% fu = 11;
% alpha = bandpass(dataspeech1,[fd fu],fs);
% alphasb = bandpass(datasilence1,[fd fu],fs);
% alphasa = bandpass(datasilence11,[fd fu],fs);
% fd = 15;
% fu = 30;
% beta = bandpass(dataspeech1,[fd fu],fs);
% betasb = bandpass(datasilence1,[fd fu],fs);
% betasa = bandpass(datasilence11,[fd fu],fs);
% fd = 35;
% fu = 55;
% gamma = bandpass(dataspeech1,[fd fu],fs);
% gammasb = bandpass(datasilence1,[fd fu],fs);
% gammasa = bandpass(datasilence11,[fd fu],fs);
fd = 90;
fu = 110;
[b1,a1] = butter(4,[fd, fu]/(fs1/2),'bandpass');
hgamma =  double(filtfilt(b1,a1,dataspeech1));
hgammasb = double(filtfilt(b1,a1,datasilence1));
hgammasa = double(filtfilt(b1,a1,datasilence11));

%hilbert
% hilbdelta = abs(hilbert(delta));
% hilbdeltasb = abs(hilbert(deltasb));
% hilbdeltasa = abs(hilbert(deltasa));
% 
% hilbtheta = abs(hilbert(theta));
% hilbthetasb = abs(hilbert(thetasb));
% hilbthetasa = abs(hilbert(thetasa));
% 
% hilbalpha = abs(hilbert(alpha));
% hilbalphasb = abs(hilbert(alphasb));
% hilbalphasa = abs(hilbert(alphasa));
% 
% hilbbeta = abs(hilbert(beta));
% hilbbetasb = abs(hilbert(betasb));
% hilbbetasa = abs(hilbert(betasa));
% 
% hilbgamma = abs(hilbert(gamma));
% hilbgammasb = abs(hilbert(gammasb));
% hilbgammasa = abs(hilbert(gammasa));

hilbhgamma = abs(hilbert(hgamma));
hilbhgammasb = abs(hilbert(hgammasb));
hilbhgammasa = abs(hilbert(hgammasa));

% %power 
% pdelta = hilbdelta.^2;
% pdeltas = ((hilbdeltasb.^2)+(hilbdeltasa.^2))/2;
% powdelta = (pdelta - pdeltas)/stdsilence;
% 
% ptheta = hilbtheta.^2;
% palpha = hilbalpha.^2;
% pbeta = hilbbeta.^2;
%powhgamma = hilbhgamma.^2;
phgamma = hilbhgamma.^2;
phgammas = ((hilbhgammasb.^2)+(hilbhgammasa.^2))/2;
powhgamma = zscore(phgamma); %(phgamma - phgammas)/stdsilence;

a = anatomy{i,4};
if(~(strcmp(a,'Left-Cerebral-White-Matter')) && ~(strcmp(a,'Right-Cerebral-White-Matter')))
 s = streams{1,1}.time_series(2*k);
  s = strip(s,'right'); 
  st = string(s);  
  channel_counter =channel_counter+1;

   if(strcmp(label_group1(1),st))%||strcmp(label_group1(2),st)||strcmp(label_group1(3),st))
       v_ohilbert = [v_ohilbert; powhgamma(1,1:2000)];
       counter_o = counter_o+1;

   end
   if(strcmp(label_group1(2),st))%label_group2(1),st)||strcmp(label_group2(2),st)||strcmp(label_group2(3),st))
       v_uhilbert = [v_uhilbert;powhgamma(1,1:2000)];
       counter_u = counter_u+1;

   end
   if(strcmp(label_group1(3),st))%label_group2(1),st)||strcmp(label_group2(2),st)||strcmp(label_group2(3),st))
       v_euhilbert = [v_euhilbert;powhgamma(1,1:2000)];
        counter_eu = counter_eu+1;
   end
   if(strcmp(label_group2(1),st))%label_group2(1),st)||strcmp(label_group2(2),st)||strcmp(label_group2(3),st))
       v_oehilbert = [v_oehilbert;powhgamma(1,1:2000)];
        counter_oe = counter_oe+1;

   end
   if(strcmp(label_group2(2),st))%label_group2(1),st)||strcmp(label_group2(2),st)||strcmp(label_group2(3),st))
       v_ehilbert = [v_ehilbert;powhgamma(1,1:2000)];
        counter_e = counter_e+1;

   end
   if(strcmp(label_group2(3),st))%label_group2(1),st)||strcmp(label_group2(2),st)||strcmp(label_group2(3),st))
       v_iehilbert = [v_iehilbert;powhgamma(1,1:2000)];
        counter_ie = counter_ie+1;

   end
  end
  end

end

%%
k = 56; %choose the channel
c_e=floor(counter_e/channel_counter);
    c_eu=floor(counter_eu/channel_counter);
    c_ie=floor(counter_ie/channel_counter);
c_o=floor(counter_o/channel_counter);
c_oe =floor(counter_oe/channel_counter);
c_u=floor(counter_u/channel_counter);

 figure();
  plot((v_ehilbert(k:k+c_e,:)), 'Color', 'cyan', 'LineWidth',2);
   hold on
   plot((v_euhilbert(k:k+c_eu,:)), 'Color', 'green', 'LineWidth',2);
  hold on
  plot((v_iehilbert(k:k+c_ie,:)), 'Color', 'magenta', 'LineWidth',2);
  hold on
  plot((v_ohilbert(k:k+c_o,:)), 'Color', 'red', 'LineWidth',2);
  hold on
  plot((v_oehilbert(k:k+c_oe,:)), 'Color', 'black', 'LineWidth',2);
  hold on
  plot((v_uhilbert(k:k+c_u,:)), 'Color', 'blue', 'LineWidth',2);
  title("Average High Gamma Z-score over all trials for channel " + k)
  xlabel("Time (ms)")
  ylabel("Amplitude")
  legend('e','eu','ie','o','u');


%%
k = 2; %choose the channel

c_e=floor(counter_e/channel_counter);
    c_eu=floor(counter_eu/channel_counter);
    c_ie=floor(counter_ie/channel_counter);
c_o=floor(counter_o/channel_counter);
c_oe =floor(counter_oe/channel_counter);
c_u=floor(counter_u/channel_counter);

figure()

plot(mean(v_ohilbert(k:k+c_o,50:end)),'Color', 'cyan', 'LineWidth',2);
hold on
plot(mean(v_oehilbert(k:k+c_oe,50:end)),'Color', 'red', 'LineWidth',2);
hold on
plot(mean(v_euhilbert(k:k+c_eu,50:end)), 'Color', 'green', 'LineWidth',2);
  hold on
  plot(mean(v_iehilbert(k:k+c_ie,50:end)), 'Color', 'magenta', 'LineWidth',2);
  hold on
  plot(mean(v_ehilbert(k:k+c_e,50:end)), 'Color', 'black', 'LineWidth',2);
  hold on
  plot(mean(v_uhilbert(k:k+c_u,50:end)), 'Color', 'blue', 'LineWidth',2);
  title("Average Z-score over all trials for channel " + k)
  xlabel("Time (ms)")
  ylabel("Amplitude")
  legend('o','oe','eu','ie','e','u');

%%
figure()

subplot(6,1,1)
plot(delta);
hold on
plot(hilbdelta);
hold on
plot(pdelta);
title('Hilbert transform for different frequency bands for one speech segment')
legend('filtered data','hilbert','power')
subplot(6,1,2)
plot(theta);
hold on
plot(hilbtheta);
hold on
plot(ptheta);
subplot(6,1,3)
plot(alpha);
hold on
plot(hilbalpha);
hold on
plot(palpha);
subplot(6,1,4)
plot(beta);
hold on
plot(hilbbeta);
hold on
plot(pbeta);
subplot(6,1,5)
plot(gamma);
hold on
plot(hilbgamma);
hold on
plot(pgamma);
subplot(6,1,6)
plot(hgamma);
hold on
plot(hilbhgamma);
hold on
plot(phgamma);

figure()
plot(hilbhgamma);
hold on
plot(phgamma);
legend("Hilbert",'Power')
title('High Gamma Hilbert and Power for one speech segment')


%% MACHINE LEARNING

% POPULATE TRAINING AND TEST LABELS ARRAYS 
labels_train =[];labels_test=[];
e=[1,0,0,0,0,0];oe=[0,1,0,0,0,0];eu=[0,0,1,0,0,0];ie=[0,0,0,1,0,0];
o=[0,0,0,0,1,0];u=[0,0,0,0,0,1]; %1 encoding labels
channel_counter = channel_counter/67;

%%
labels_train =[];labels_test=[];

c_e=floor(counter_e/size(data1,1));
    c_eu=floor(counter_eu/size(data1,1));
    c_ie=floor(counter_ie/size(data1,1));
c_o=floor(counter_o/size(data1,1));
c_oe =floor(counter_oe/size(data1,1));
c_u=floor(counter_u/size(data1,1));

k1=floor(0.6*c_e);
  k3=floor(0.6*c_o);
  k5=floor(0.6*c_oe);
  k7=floor(0.6*c_eu);
  k9=floor(0.6*c_ie);
  k11=floor(0.6*c_u);

for i=1:1:k1
    labels_train = [labels_train; 'ee'];
end
for i=1:1:k5
    labels_train = [labels_train; 'oe'];
end
for i=1:1:k7
    labels_train = [labels_train; 'eu'];
end
for i=1:1:k9
    labels_train = [labels_train; 'ie'];
end
for i=1:1:k3
    labels_train = [labels_train; 'oo'];
end
for i=1:1:k11
    labels_train = [labels_train; 'uu'];
end
for i=1:1:c_oe-k5
    labels_test = [labels_test; 'oe'];
end
for i=1:1:c_e-k1
    labels_test = [labels_test; 'ee'];
end
for i=1:1:c_u-k11
    labels_test = [labels_test; 'uu'];
end
for i=1:1:c_eu-k7
    labels_test = [labels_test; 'eu'];
end
for i=1:1:c_o-k3
    labels_test = [labels_test; 'oo'];
end
for i=1:1:c_ie-k9
    labels_test = [labels_test; 'ie'];
end


 
  %% START THE SVM IMPLEMENTATION

   generror_before = zeros(size(data1,1));
  generror = zeros(size(data1,1)); generror_after = zeros(size(data1,1));

  for j=77:1:77  %go over every channel individually
  ve = v_ehilbert((j-1)*c_e+1:j*c_e,50:end);
  veu = v_euhilbert((j-1)*c_eu+1:j*c_eu,50:end);
  vie = v_iehilbert((j-1)*c_ie+1:j*c_ie,50:end);
  vo = v_ohilbert((j-1)*c_o+1:j*c_o,50:end);
  voe = v_oehilbert((j-1)*c_oe+1:j*c_oe,50:end);
  vu = v_uhilbert((j-1)*c_u+1:j*c_u,50:end);

  % DATA FOR SVM BEFORE SPEECH ONSET (t=500)
  vowel_train_before = [ve(1:k1,1:400);voe(1:k5,1:400);veu(1:k7,1:400);vie(1:k9,1:400);vo(1:k3,1:400);vu(1:k11,1:400)];
  vowel_test_before = [voe(k5+1:c_oe,1:400);ve(k1+1:c_e,1:400);vu(k11+1:c_u,1:400);veu(k7+1:c_eu,1:400);vo(k3+1:c_o,1:400);vie(k9+1:c_ie,1:400)];

  cl = fitcecoc(vowel_train_before,labels_train);
v1 = predict(cl,vowel_test_before);
CVcl = crossval(cl);
generror_before(j) = kfoldLoss(CVcl);

hf=figure;
confusionchart(hf,labels_test,v1,"RowSummary","row-normalized","ColumnSummary","column-normalized")
title("Confusion Matrix before speech for channel " + j)

%    % DATA FOR SVM AT SPEECH ONSET (t=500)
  vowel_train_onset = [ve(1:k1,410:710);voe(1:k5,410:710);veu(1:k7,410:710);vie(1:k9,410:710);vo(1:k3,410:710);vu(1:k11,410:710)];
  vowel_test_onset = [voe(k5+1:c_oe,410:710);ve(k1+1:c_e,410:710);vu(k11+1:c_u,410:710);veu(k7+1:c_eu,410:710);vo(k3+1:c_o,410:710);vie(k9+1:c_ie,410:710)];


  cl1 = fitcecoc(vowel_train_onset,labels_train);
v11 = predict(cl1,vowel_test_onset);
CVcl1 = crossval(cl1);
generror(j) = kfoldLoss(CVcl1);

hf1=figure;
confusionchart(hf1,labels_test,v11,"RowSummary","row-normalized","ColumnSummary","column-normalized")
title("Confusion Matrix at speech onset for channel " + j)

   % DATA FOR SVM AFTER SPEECH ONSET (t=500)
   vowel_train_after = [ve(1:k1,750:1800);voe(1:k5,750:1800);veu(1:k7,750:1800);vie(1:k9,750:1800);vo(1:k3,750:1800);vu(1:k11,750:1800)];
  vowel_test_after = [voe(k5+1:c_oe,750:1800);ve(k1+1:c_e,750:1800);vu(k11+1:c_u,750:1800);veu(k7+1:c_eu,750:1800);vo(k3+1:c_o,750:1800);vie(k9+1:c_ie,750:1800)];


    cl2 = fitcecoc(vowel_train_after,labels_train);
v12 = predict(cl2,vowel_test_after);
CVcl2 = crossval(cl2);
generror_after(j) = kfoldLoss(CVcl2);

hf2=figure;
confusionchart(hf2,labels_test,v12,"RowSummary","row-normalized","ColumnSummary","column-normalized")
title("Confusion Matrix after speech onset for channel " + j)
   end

%c = cvpartition(group,"KFold",k,"Stratify",stratifyOption);