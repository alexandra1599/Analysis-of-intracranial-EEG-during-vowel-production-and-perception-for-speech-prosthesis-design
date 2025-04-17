x1 = streams(2);
%data1 = x1{1, 1}.time_series(:,:);
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
% grey_left=[data1(1:4,:);data1(9,:);data1(11,:);data1(14:15,:);data1(19:21,:);data1(25,:);data1(28:29,:);data1(38,:)];
% 
% grey_right =[data1(39,:);data1(43:44,:);
%     data1(46,:);data1(49:50,:);data1(57,:);data1(59,:);
%     data1(60:64,:);data1(68:71,:);data1(73:75,:);data1(79,:);data1(83:84,:);
%     data1(89:93,:);data1(102:104,:);data1(109,:);data1(111:112,:);data1(115:118,:);data1(120:125,:);data1(128,:)];
% data1 = [grey_left;grey_right];

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

[b1,a1] = butter(4,[70, 200]/(fs1/2),'bandpass');
filtered_channel1 = double(filtfilt(b1,a1,data1));
    
index=[];indexpre=[];indexsim=[];

label_group1 = ["start;oo","start;uu","start;eu"];
label_group2 = ["start;oe","start;ee","start;ie"];
%%c
%  stdsilence = 0;
% 
% % Get the std of silent segments
% for k=1:1:size(data1)
%    powersilence = [];
%    for i = 1:1:size(idx,1)-4
%    startspeech = idx(i,1)-(windowlength); 
%    endspeech =idx(i,2)+(windowlength);
%    startsilence = idx(i,2)+(windowlength/4);
%    endsilence = startsilence + ((endspeech - startspeech)); 
% 
%      datasilence1 = filtered_channel1(k,startsilence:endsilence);
% 
%  hilb11 = abs(hilbert(datasilence1));
% 
%    powersilence = [powersilence; hilb11(1,1:300)];
% 
%    end
% end
% stdsilence = mean(std(powersilence));


v_o=[];v_u=[];v_eu=[];v_oe=[];v_e=[];v_ie=[];
vo_o=[];vo_u=[];vo_eu=[];vo_oe=[];vo_e=[];vo_ie=[];
zspeech=[];
for k=1:1:size(data1,1)
%zspeech=[];

  for i =4:1:size(idx,1)-4
  pow=[];avgsilence = 0;

  startspeech = idx(i,1)-(1.5*windowlength); 
  endspeech =idx(i,2)+(windowlength);
  startsilence_before = idx(i-1,2)+(windowlength/4); 
  endsilence_before = startsilence_before + (endspeech - startspeech);
  startsilence_after = idx(i,2)+(windowlength/4); 
  endsilence_after = startsilence_after + (endspeech - startspeech);
  
   datasilence1 = filtered_channel1(k,startsilence_after:endsilence_after);
  dataspeech1 = filtered_channel1(k,startspeech:endspeech);
 
  %Power
 Y_silence = datasilence1; % Segment the data to 10s
Y_silence = Y_silence.*hann(length(Y_silence))';  % Apply Hanning Window
N = length(Y_silence);   % Length of signal segment
P = nextpow2(N); % Pad signal to increase computational time                   
n = 2^P;
X = fft(Y_silence,n); % Apply the fft algorithm
Pxx = 1/(N*fs1)*abs(X(1:length(Y_silence)/2+1)).^2;   % Find signal power
Pxx(2:end-1) = 2*Pxx(2:end-1);
f = (0:fs1/N:fs1/2); % Frequency Vector
  %hilb1 = abs(hilbert(dataspeech1));

  Y_speech = dataspeech1;% Segment the data to 10s
Y_speech = Y_speech.*hann(length(Y_speech))';% Apply Hanning Window
N = length(Y_speech);% Length of signal segment
P = nextpow2(N);% Pad signal to increase computational time                   
n = 2^P;
X = fft(Y_speech,n); % Apply the fft algorithm
Pxx_speech =  1/(N*fs1)*abs(X(1:length(Y_speech)/2+1)).^2;% Find signal power
f = (0:fs1/N:fs1/2);  % Frequency Vector
Pxx_speech(2:end-1) = 2*Pxx_speech(2:end-1);
  

 % powerallsilence_after = hilb11;

  datasilence11 = filtered_channel1(k,startsilence_before:endsilence_before);
 %hilb11 = abs(hilbert(datasilence11));
  Y_silenceb = datasilence1; % Segment the data to 10s
Y_silenceb = Y_silenceb.*hann(length(Y_silenceb))';  % Apply Hanning Window
N = length(Y_silenceb);   % Length of signal segment
P = nextpow2(N); % Pad signal to increase computational time                   
n = 2^P;
X = fft(Y_silenceb,n); % Apply the fft algorithm
Pxx2 = 1/(N*fs1)*abs(X(1:length(Y_silenceb)/2+1)).^2;   % Find signal power
Pxx2(2:end-1) = 2*Pxx2(2:end-1);
f = (0:fs1/N:fs1/2); % Frequency Vector

 % powerallsilence_before = hilb11 ;

  avgsilence = (Pxx+Pxx2)/2;
  gz = ((Pxx_speech - avgsilence)/stdsilence); %zscore for standardization
  zspeech = [zspeech; gz(1,1:900)];
 
  

  s = streams{1,1}.time_series(2*i);
  s = strip(s,'right'); 
  st = string(s);   

   if(strcmp(label_group1(1),st))%||strcmp(label_group1(2),st)||strcmp(label_group1(3),st))
       v_o = [v_o; gz(1,1:900)];

   end
   if(strcmp(label_group1(2),st))%label_group2(1),st)||strcmp(label_group2(2),st)||strcmp(label_group2(3),st))
       v_u = [v_u;gz(1,1:900)];

   end
   if(strcmp(label_group1(3),st))%label_group2(1),st)||strcmp(label_group2(2),st)||strcmp(label_group2(3),st))
       v_eu = [v_eu;gz(1,1:900)];

   end
   if(strcmp(label_group2(1),st))%label_group2(1),st)||strcmp(label_group2(2),st)||strcmp(label_group2(3),st))
       v_oe = [v_oe;gz(1,1:900)];


   end
   if(strcmp(label_group2(2),st))%label_group2(1),st)||strcmp(label_group2(2),st)||strcmp(label_group2(3),st))
       v_e = [v_e;gz(1,1:900)];


   end
   if(strcmp(label_group2(3),st))%label_group2(1),st)||strcmp(label_group2(2),st)||strcmp(label_group2(3),st))
       v_ie = [v_ie;gz(1,1:900)];


   end
  end

   vo_e = [vo_e; mean(v_e)];
   vo_ie = [vo_ie; mean(v_ie)];
   vo_eu = [vo_eu; mean(v_eu)];
    vo_o = [vo_o; mean(v_o)];
   vo_oe = [vo_oe;mean(v_oe)];
   vo_u = [vo_u;mean(v_u)];
   

  %  % figure();
  %   subplot(6,1,1)
  %   d1 = plot(mean(v_o),'red', 'LineWidth',2); %(:,28:995)
  %   hold on
  %   plot(mean(v_o)+std(mean(v_o)),'red','LineWidth',1);
  %   hold on
  %   plot(mean(v_o)-std(mean(v_o)),'red','LineWidth',1);
  %   xline(500,'-','Speech Onset','LabelOrientation','horizontal');
  %   ylabel('Z-Score');
  %   title("Average z-score across trials for vowel /o/ for one channel");
  %   hold on
  %   subplot(6,1,2)
  %   d2 = plot(mean(v_u),'blue', 'LineWidth',2);
  %   hold on
  %   plot(mean(v_u)+std(mean(v_u)),'blue','LineWidth',1);
  %   hold on 
  %   plot(mean(v_u)-std(mean(v_u)),'blue','LineWidth',1);
  %   xline(500,'-','Speech Onset','LabelOrientation','horizontal');
  %   ylabel('Z-Score');
  %      title("Average z-score across trials for vowel /u/ for one channel");
  %   hold on
  %   subplot(6,1,3)
  %   d3 = plot(mean(v_eu),'green', 'LineWidth',2);
  %   hold on
  %   plot(mean(v_eu)+std(mean(v_eu)),'green','LineWidth',1);
  %   hold on 
  %   plot(mean(v_eu)-std(mean(v_eu)),'green','LineWidth',1);
  %   xline(500,'-','Speech Onset','LabelOrientation','horizontal');
  %   ylabel('Z-Score');
  %      title("Average z-score across trials for vowel /eu/ for one channel");
  %   hold on
  %   subplot(6,1,4)
  %   d4 = plot(mean(v_oe),'black', 'LineWidth',2);
  %   hold on
  %   plot(mean(v_oe)+std(mean(v_oe)),'black','LineWidth',1);
  %   hold on 
  %   plot(mean(v_oe)-std(mean(v_oe)),'black','LineWidth',1);
  %   xline(500,'-','Speech Onset','LabelOrientation','horizontal');
  %   ylabel('Z-Score');
  %      title("Average z-score across trials for vowel /oe/ for one channel");
  %   hold on
  %   subplot(6,1,5)
  %   d5 = plot(mean(v_e),'cyan', 'LineWidth',2);
  %    hold on
  %   plot(mean(v_e)+std(mean(v_e)),'cyan','LineWidth',1);
  %   hold on 
  %   plot(mean(v_e)-std(mean(v_e)),'cyan','LineWidth',1);
  %   xline(500,'-','Speech Onset','LabelOrientation','horizontal');
  %   ylabel('Z-Score');
  %      title("Average z-score across trials for vowel /e/ for one channel");
  %   hold on
  % subplot(6,1,6)
  %   d6 = plot(mean(v_ie),'magenta', 'LineWidth',2);
  %   hold on
  %   plot(mean(v_ie)+std(mean(v_ie)),'magenta','LineWidth',1);
  %    hold on 
  %   plot(mean(v_ie)-std(mean(v_ie)),'magenta','LineWidth',1);
  %   xline(500,'-','Speech Onset','LabelOrientation','horizontal');
  %   ylabel('Z-Score');
  %      title("Average z-score across trials for vowel /ie/ for one channel");

    % hold on
    % plot(mean(v_o(:,28:995))+std(mean(v_o(:,28:995))),'red','LineWidth',1);
    % hold on
    % plot(mean(v_o(:,28:995))-std(mean(v_o(:,28:995))),'red','LineWidth',1);
    % hold on
    % plot(mean(v_u(:,28:995))+std(mean(v_u(:,28:995)))+1,'blue','LineWidth',1);
    % hold on 
    % plot(mean(v_u(:,28:995))-std(mean(v_u(:,28:995)))+1,'blue','LineWidth',1);
    % hold on
    %  plot(mean(v_eu(:,28:995))+std(mean(v_eu(:,28:995)))+2,'green','LineWidth',1);
    % hold on 
    % plot(mean(v_eu(:,28:995))-std(mean(v_eu(:,28:995)))+2,'green','LineWidth',1);
    % hold on
    % plot(mean(v_oe(:,28:995))+std(mean(v_oe(:,28:995)))+3,'black','LineWidth',1);
    % hold on 
    % plot(mean(v_oe(:,28:995))-std(mean(v_oe(:,28:995)))+3,'black','LineWidth',1);
    % hold on
    % plot(mean(v_e(:,28:995))+std(mean(v_e(:,28:995)))+4,'cyan','LineWidth',1);
    % hold on 
    % plot(mean(v_e(:,28:995))-std(mean(v_e(:,28:995)))+4,'cyan','LineWidth',1);
    % hold on
    % plot(mean(v_ie(:,28:995))+std(mean(v_ie(:,28:995)))+5,'magenta','LineWidth',1);
    % hold on 
    %plot(mean(v_ie(:,28:995))-std(mean(v_ie(:,28:995)))+5,'magenta','LineWidth',1);

%     hleglines = [d1 d2 d3 d4 d5 d6];
% % create the legend
% hleg = legend(hleglines,'Vowel oo', 'Vowel uu', 'Vowel eu', 'Vowel oe', 'Vowel ee', 'Vowel ie');

%   zmean = mean(zspeech);
%    [peakValues, indexes] = findpeaks(zmean);
%   [maxz,id] = max(peakValues);
% 
%         if(indexes(id)>(idx(i,1)/fs1)+0.02*fs1)
%              postspeech(f,:) = zmean;
%              stderrorpost (f,:) =  std(zmean)/sqrt(size(idx,1));
%              index(k,i) = 1;
%              f=f+1;
%          elseif(indexes(id)<(idx(i,1)/fs1)-0.02*fs1)
%              prespeech(f1,:) = zmean;
%              stderrorpre (f1,:) =  std(zmean)/sqrt(size(idx,1));
%              index(k,i)=2;
%             f1=f1+1;
%          else
%             simspeech(f2,:) = zmean;
%             stderrorsim (f2,:) =  std(zmean)/sqrt(size(idx,1));
%             index(k,i)=3;
%             f2=f2+1;
%         end 
%   %end
%   % 
%   % zmean = mean(zspeech);
%   %   [peakValues, indexes] = findpeaks(zmean);
%   % [maxz,id] = max(peakValues);
%   % 
%   %       if(indexes(id)>(idx(i,1)/fs1)+0.02*fs1)
%   %            indexpost(i) = k;
%   %        elseif(indexes(id)<(idx(i,1)/fs1)-0.02*fs1)
%   %           indexpre(i)=k;
%   %        else
%   %           indexsim(i)=k;
%   %       end
%
  end


  %%
shadedErrorBar(v_e(1,:),{@mean,@std},'lineprops','-b','patchSaturation',0.33)

% Overlay second line
hold on
shadedErrorBar(v_o(1,:),{@mean,@std},'lineprops',{'-go','MarkerFaceColor','g'});

hold on

% Make this line non-transparent
shadedErrorBar(v_u(1,:), {@mean,@std}, 'lineprops', '-r','transparent',false,'patchSaturation',0.075)

grid on
  %%
  figure()
  
  plot((mean(v_e)),'red','LineWidth',3); 
 
    hold on
        plot(mean(v_e)+std(v_e),'red','LineWidth',1,"LineStyle","--");
      hold on
        plot(mean(v_e)-std(v_e),'red','LineWidth',1,"LineStyle","--");
%   ylabel("Z-Score")
%   ylim([-3 3]);
%   xline(200,'-','Speech Onset','LabelOrientation','horizontal');
%   title("Z-Score Avg across trials for channel for vowel /e/")
%    figure()
   hold on
  plot(mean(v_o)+2,'blue','LineWidth',3); 
   hold on
   plot(mean(v_o)+std(v_o)+2,'blue','LineWidth',1,"LineStyle","--");
   hold on
  plot(mean(v_o)-std(v_o)+2,'blue','LineWidth',1,"LineStyle","--");
% %    ylabel("Z-Score")
%    xline(200,'-','Speech Onset','LabelOrientation','horizontal');
%   ylim([-3 3]);
%   title("Z-Score Avg across trials for one channel for vowel /o/")
% 
%   figure();
    hold on
   plot(mean(v_ie)+4,'green','LineWidth',3); 
   hold on
    plot(mean(v_ie)+std(v_ie)+4,'green','LineWidth',1,"LineStyle","--");
    hold on
     plot(mean(v_ie)-std(v_ie)+4,'green','LineWidth',1,"LineStyle","--");
 hold on
 plot(mean(v_eu)+6,'cyan','LineWidth',3); 
 hold on
    plot(mean(v_eu)+std(v_ie)+6,'cyan','LineWidth',1,"LineStyle","--");
    hold on
    plot(mean(v_eu)-std(v_eu)+6,'cyan','LineWidth',1,"LineStyle","--");
 
hold on
 plot(mean(v_oe)+8,'magenta','LineWidth',3); 
  hold on
    plot(mean(v_oe)+std(v_oe)+8,'magenta','LineWidth',1,"LineStyle","--");
    hold on
    plot(mean(v_oe)-std(v_oe)+8,'magenta','LineWidth',1,"LineStyle","--");
% 
 hold on
plot(mean(v_u)+10,'black','LineWidth',3); 
 hold on
    plot(mean(v_u)+std(v_u)+10,'black','LineWidth',1,"LineStyle","--");
    hold on
    plot(mean(v_u)-std(v_u)+10,'black','LineWidth',1,"LineStyle","--");

  ylabel("Z-Score")
  %ylim([-2 2]);
  xline(250,'-','Speech Onset','LabelOrientation','horizontal');
  title("Z-Score Avg across trials for one channel"); % for vowel /ie/")
  %figure()
  % for i=30:1:40
  % plot(v_ie(i,28:995),'blue'); 
  % hold on
  % end
  % ylabel("Z-Score")
  % title("Z-Score per trial for one channel for vowel /o/")
%%

vowel_zscore = [vo_e; vo_ie; vo_eu; vo_o; vo_oe; vo_u];
pca_coeff = pca(vowel_zscore);
figure();
scatter3(pca_coeff(:,1),pca_coeff(:,2),pca_coeff(:,3))


pca_coeff1 = pca(vo_e);
figure();
scatter3(pca_coeff1(:,1),pca_coeff1(:,2),pca_coeff1(:,3))
xlabel("PCA 1");
ylabel("PCA 2");
zlabel("PCA 3");

[coeff,score,latent] = pca(vo_e);
[coeff1,score1,latent1] = pca(vo_ie);
[coeff2,score2,latent2] = pca(vo_eu);
[coeff3,score3,latent3] = pca(vo_o);
[coeff4,score4,latent4] = pca(vo_oe);
[coeff5,score5,latent5] = pca(vo_u);
figure();
scatter3(coeff(:,1),coeff(:,2),coeff(:,3),'black')
hold on
scatter3(coeff1(:,1),coeff1(:,2),coeff1(:,3),'Color',[0.9 .3 0])
hold on
scatter3(coeff2(:,1),coeff2(:,2),coeff2(:,3),'blue')
hold on
scatter3(coeff3(:,1),coeff3(:,2),coeff3(:,3),'red')
hold on
scatter3(coeff4(:,1),coeff4(:,2),coeff4(:,3),'yellow')
hold on
scatter3(coeff5(:,1),coeff5(:,2),coeff5(:,3),'green')
xlabel("PCA 1");
ylabel("PCA 2");
zlabel("PCA 3");
legend({'/e/','/ie/','/eu/','/o/','/oe/','/u/'})
title("PCA for different vowels")

%%
[coeff,score,latent] = pca(v_e);
[coeff1,score1,latent1] = pca(vo_ie);
[coeff2,score2,latent2] = pca(vo_eu);
[coeff3,score3,latent3] = pca(vo_o);
[coeff4,score4,latent4] = pca(vo_oe);
[coeff5,score5,latent5] = pca(vo_u);
figure();
scatter3(coeff(:,1),coeff(:,2),coeff(:,3),'black','filled')
hold on
scatter3(coeff1(:,1),coeff1(:,2),coeff1(:,3),'Color',[0.9 .3 0])
hold on
scatter3(coeff2(:,1),coeff2(:,2),coeff2(:,3),'blue','filled')
hold on
scatter3(coeff3(:,1),coeff3(:,2),coeff3(:,3),'red','filled')
hold on
scatter3(coeff4(:,1),coeff4(:,2),coeff4(:,3),'yellow','filled')
hold on
scatter3(coeff5(:,1),coeff5(:,2),coeff5(:,3),'green','filled')
xlabel("PCA 1");
ylabel("PCA 2");
zlabel("PCA 3");
legend({'/e/','/ie/','/eu/','/o/','/oe/','/u/'})
title("PCA for different vowels")

%% plot overall across trials

premean = mean(prespeech);
prestderror1 = premean  + std(premean)/size(idx,1);
prestderror2 = premean  + std(premean)/size(idx,1);
postmean = mean(postspeech);
poststderror1 = postmean  + std(postmean)/size(idx,1);
poststderror2 = postmean  + std(postmean)/size(idx,1);
simmean = mean(simspeech);
simstderror1 = simmean  + std(simmean)/size(idx,1);
simstderror2 = simmean  + std(simmean)/size(idx,1);

figure();
plot(postmean,'r');
hold on
plot(poststderror1,"--",'Color','r');
hold on
plot(poststderror2,"--",'Color','r');
hold on
plot(premean,'b');
hold on
plot(prestderror1,"--",'Color','b');
hold on
plot(prestderror2,"--",'Color','b');
hold on
plot(simmean,'g');
hold on
plot(simstderror1,"--",'Color','g');
hold on
plot(simstderror2,"--",'Color','g');
%ylim([-0.7 2])
xline(200,'-','Speech Onset','LabelOrientation','horizontal');
title("Average z-score over all electrodes and all utterances")
ylabel("High gamma Z-score")
    
 
%% plot for individual channels

figure();
for i=1:1:size(postspeech,1)


 
plot(postspeech(i,:),'g');
hold on
plot(postspeech(i,:)+ stderrorpost(i,:),"--",'Color','g');
hold on
plot(postspeech(i,:)- stderrorpost(i,:),"--",'Color','g');

xline(200,'-','Speech Onset','LabelOrientation','horizontal');
title("Average z-score across all trials for one channel")
ylabel("High gamma Z-score")
end


figure();
for i=1:1:size(prespeech,1)


 
plot(prespeech(i,:),'b');
hold on
plot(prespeech(i,:)+ stderrorpre(i,:),"--",'Color','b');
hold on
plot(prespeech(i,:)- stderrorpre(i,:),"--",'Color','b');
end


figure();
for i=1:1:size(simspeech,1)



plot(simspeech(i,:),'b');
hold on
plot(simspeech(i,:)+ stderrorsim(i,:),"--",'Color','b');
hold on
plot(simspeech(i,:)- stderrorsim(i,:),"--",'Color','b');

xline(200,'-','Speech Onset','LabelOrientation','horizontal');
title("Average z-score for one channel")
ylabel("High gamma Z-score")
end



 


%%


zmean = mean(zspeech);
%     [peakValues, indexes] = findpeaks(zmean);
%   [maxz,id] = max(peakValues);
% 
%         if(indexes(id)>(idx(i,1)/fs1)+0.02*fs1)
%              postspeech(f,:) = gz;
%              f=f+1;
%          elseif(indexes(id)<(idx(i,1)/fs1)-0.02*fs1)
%              prespeech(f1,:) = gz;
%             f1=f1+1;
%          else
%             simspeech(f2,:) = gz;
%             f2=f2+1;
%         end
% 
%         postmean = mean(postspeech);
%  poststderror1 = postmean + std(postspeech)/sqrt(size(idx,1));
%  poststderror2 = postmean - std(postspeech)/sqrt(size(idx,1));
%  premean = mean(prespeech);
%  prestderror1 = premean + std(prespeech)/sqrt(size(idx,1));
%  prestderror2 = premean - std(prespeech)/sqrt(size(idx,1));
%  simmean = mean(simspeech);
%  simstderror1 = simmean + std(simspeech)/sqrt(size(idx,1));
%  simstderror2 = simmean - std(simspeech)/sqrt(size(idx,1));
% 
% 
%  figure();
% plot(postmean,'r');
% hold on
% plot(poststderror1,"--",'Color','r');
% hold on
% plot(poststderror2,"--",'Color','r');
% hold on
% plot(premean,'b');
% hold on
% plot(prestderror1,"--",'Color','b');
% hold on
% plot(prestderror2,"--",'Color','b');
% hold on
% plot(simmean,'g');
% hold on
% plot(simstderror1,"--",'Color','g');
% hold on
% plot(simstderror2,"--",'Color','g');
% %ylim([-0.7 2])
% xline(200,'-','Speech Onset','LabelOrientation','horizontal');
% title("Average z-score over all electrodes and all utterances")
% ylabel("High gamma Z-score")
figure();
plot(postmean,'r');
hold on
plot(poststderror1,"--",'Color','r');
hold on
plot(poststderror2,"--",'Color','r');
hold on
plot(premean,'b');
hold on
plot(prestderror1,"--",'Color','b');
hold on
plot(prestderror2,"--",'Color','b');
hold on
plot(simmean,'g');
hold on
plot(simstderror1,"--",'Color','g');
hold on
plot(simstderror2,"--",'Color','g');
ylim([-0.7 2])
xline(250,'-','Speech Onset','LabelOrientation','horizontal');
title("Average z-score over all electrodes and all utterances")
ylabel("High gamma Z-score")