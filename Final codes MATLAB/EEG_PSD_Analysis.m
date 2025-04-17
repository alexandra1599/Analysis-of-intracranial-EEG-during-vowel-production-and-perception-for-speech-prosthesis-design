%streams = loadxdf('/Users/alexandramikhael/Downloads/vowel Netherland/kh28_vowels.xdf');
x1 = streams(2);
data1 = x1{1, 1}.time_series(:,:);
time1 = x1{1,1}.time_stamps;
fs1 = streams{1, 2}.segments.effective_srate;
% channel = x1{1, 1}.time_series(40,:); %one channel
idx = (idx/fs)*fs1; 
windowlength = 0.5*fs1;
nfft = 2^nextpow2(windowlength);
%%

alpha=0;beta=0;gamma=0;hgamma=0;alphas=0;betas=0;gammas=0;hgammas=0;
startsilence=0;endsilence=0;startspeech=0;endspeech=0;
pxxsilence = []; ptest = []; ptest1=[];ptest2=[];ptest3=[];
psdgamma = []; psdbeta=[]; psdalpha=[]; psdhgamma=[];
psdgammavowel = []; psdbetavowel=[]; psdalphavowel=[]; psdhgammavowel=[];
psdgammasil = []; psdbetasil=[]; psdalphasil=[]; psdhgammasil=[];
psdgammasilvowel = []; psdbetasilvowel=[]; psdalphasilvowel=[]; psdhgammasilvowel=[];
pxxspeech =[];s=zeros(71,257);si=zeros(71,257); speech=zeros(74,520);silence=zeros(74,520); 
%%

avgchannel = mean(data1);

for i=1:1:size(idx,1)
   j=1;
   q=1;
for k=1:1:size(data1,1)
   data1(k,:) = data1(k,:)-avgchannel;
 
  startsilence = idx(i,2)+(windowlength/2); %end of speech + 250ms
  endsilence = startsilence + windowlength; %startsilence + 500ms
  startspeech = idx(i,1)-(windowlength/10); %start of speech - 50 ms
  endspeech = startspeech + windowlength; %startspeech + 500ms
  datasilence = data1(k,startsilence:endsilence);
  dataspeech = data1(k,startspeech:endspeech);

 %subplot(2,1,1);
% plot(time1,channel); % Plot signal       
% hold on 
nw = 50;     % Filter Order
fp = 0.1;    % Passband frequency
fst = 25;    % Stopband frequency
wp = fp/fs1/2;  % Cutoff frequency
ws = fst/fs1/2;   % Cutoff frequency
wn = [wp,ws];   % Cutoff frequency vector(bandpass)
window = kaiser(nw+1);         % Apply kaiser window
b = fir1(nw,wn,'bandpass',window); % Get filter coeff.
y_silence = filter(b,1,datasilence);        
y_speech = filter(b,1,dataspeech); % Filter Signal
                 
% plot(time1,y,'k'); % Plot filtered Signal 
% figure;
Y_silence = y_silence; % Segment the data to 10s
Y_silence = Y_silence.*hann(length(Y_silence))';  % Apply Hanning Window
N = length(Y_silence);   % Length of signal segment
P = nextpow2(N); % Pad signal to increase computational time                   
n = 2^P;
X = fft(Y_silence,n); % Apply the fft algorithm
Pxx = 1/(N*fs1)*abs(X(1:length(Y_silence)/2+1)).^2;   % Find signal power
f = (0:fs1/N:fs1/2); % Frequency Vector
Pxx(2:end-1) = 2*Pxx(2:end-1);
pxxsilence(j,:) = Pxx;
% plot(f,10*log10(Pxx)); 
% hold on
% title('Power Spectral Density Using FFT on silence')
% xlabel('Frequency (Hz)')
% ylabel('Power/Frequency (dB/Hz)')
%subplot(2,1,2);        
Y_speech = y_speech;% Segment the data to 10s
Y_speech = Y_speech.*hann(length(Y_speech))';% Apply Hanning Window
N = length(Y_speech);% Length of signal segment
P = nextpow2(N);% Pad signal to increase computational time                   
n = 2^P;
X = fft(Y_speech,n); % Apply the fft algorithm
Pxx_speech =  1/(N*fs1)*abs(X(1:length(Y_speech)/2+1)).^2;% Find signal power
f = (0:fs1/N:fs1/2);  % Frequency Vector
Pxx_speech(2:end-1) = 2*Pxx_speech(2:end-1);
pxxspeech(j,:) = Pxx_speech;
j=j+1;
% [pks,locs] = findpeaks(10*log10(Pxx_speech));
%     F1 = [F1 (locs(2)/fs1)*fs];
%     F2 = [F2 (locs(3)/fs1)*fs];

% plot(f,10*log10(Pxx_speech)); 
% hold on
% title('Power Spectral Density Using FFT on speech')
% xlabel('Frequency (Hz)')
% ylabel('Power/Frequency (dB/Hz)')

pxxspeechavg = mean(pxxspeech);
pxxsilenceavg = mean(pxxsilence);
psdsmoothspeech = smoothdata(10*log10(pxxspeechavg));
s(k,:)=psdsmoothspeech;
psdsmoothsilence = smoothdata(10*log10(pxxsilenceavg));
si(k,:)=psdsmoothsilence;

%curve1smooth = smoothdata(10*log10(stderrorspeech1));
%curve2smooth = smoothdata(10*log10(stderrorspeech2));
%curve3smooth = smoothdata(10*log10(stderrorilence1));
%curve4smooth = smoothdata(10*log10(stderrorsilence2));



% for p=1:1:100
%     while (f(p) > 0 && f(p) < 20)
%         psdalphavowel = [psdalphavowel pxxspeech(p)];
%         psdalphasilvowel = [psdalphasilvowel pxxsilence(p)];
%         p=p+1;
%     end
%     while(f(p) > 20 && f(p) < 45)
%         psdbetavowel = [psdbetavowel pxxspeech(p)];
%         psdbetasilvowel = [psdbetasilvowel pxxsilence(p)];
%         p=p+1;
%     end
%     while(f(p) > 55 && f(p) < 140)
%         psdgammavowel = [psdgammavowel pxxspeech(p)];
%         psdgammasilvowel = [psdgammasilvowel pxxsilence(p)];
%         p=p+1;
%     end
%     while(f(p) > 150 && f(p) < 200)
%         psdhgammavowel = [psdhgammavowel pxxspeech(p)];
%         psdhgammasilvowel = [psdhgammasilvowel pxxsilence(p)];
%         p=p+1;
%     end
% end
% 
% alpha = mean(10*log10(psdalphavowel));
% %stdalpha = std(10*log10(psdalphavowel));
% beta = mean(10*log10(psdbetavowel));
% %stdbeta = std(10*log10(psdbetavowel));
% gamma = mean(10*log10(psdgammavowel));
% %stdgamma = std(10*log10(psdgammavowel));
% hgamma = mean(10*log10(psdhgammavowel));
% %stdhgamma = std(10*log10(psdhgammavowel));
% speech(i,q:q+3) = [alpha beta gamma hgamma];
% alphas = mean(10*log10(psdalphasilvowel));
% %stdalphas = std(10*log10(psdalphasilvowel));
% betas = mean(10*log10(psdbetasilvowel));
% %stdbetas = std(10*log10(psdbetasilvowel));
% gammas = mean(10*log10(psdgammasilvowel));
% %stdgammas = std(10*log10(psdgammasilvowel));
% hgammas = mean(10*log10(psdhgammasilvowel));
% %stdhgammas = std(10*log10(psdhgammasilvowel));
% silence(i,q:q+3) = [alphas betas gammas hgammas];
% q=q+4;
% psdbar =[alpha 0 beta 0 gamma 0 hgamma 0];
% psdbarsil =[0 alphas 0 betas 0 gammas 0 hgammas];
% errspeech =[stdalpha/sqrt(size(idx,1)) 0 stdbeta/sqrt(size(idx,1)) 0 stdgamma/sqrt(size(idx,1)) 0 stdhgamma/sqrt(size(idx,1)) 0];
% errsil = [0 stdalphas/sqrt(size(idx,1)) 0 stdbetas/sqrt(size(idx,1)) 0 stdgammas/sqrt(size(idx,1)) 0 stdhgammas/sqrt(size(idx,1))];

% x=1:8;
% figure();
% %subplot(2,1,1)
% plot(psdsmoothsilence,'b','LineWidth',1);
% hold on
% plot(psdsmoothspeech,'r','LineWidth',1);
% hold on;
% plot(curve1smooth,'r','LineWidth',1);
% hold on
% plot(curve2smooth,'r','LineWidth',1);
% hold on;
% plot(curve3smooth,'b','LineWidth',1);
% hold on
% plot(curve4smooth,'b','LineWidth',1);
% legend('silence','speech')
% xlabel("Frequency"); ylabel("Power (dB)");
% title("PSD for speech and silent EEG signals")
% subplot(2,1,2)
% bar(psdbarsil);
% hold on
% er = errorbar(x,psdbarsil,errsil,errsil);    
% er.Color = [0 0 0];                            
% er.LineStyle = 'none';  
% hold off
% hold on
% bar(psdbar,'r');
% hold on
% er = errorbar(x,psdbar,errspeech,errspeech);    
% er.Color = [0 0 0];                            
% er.LineStyle = 'none';  
% hold off
% xlabel("Frequency"); ylabel("Power (dB)");
% title("Power Bar Graph")

% 
% [h,p] = ttest2(psdalphavowel,psdalphasilvowel,0.05);
% ptest = [ptest p];
% [h,p1] = ttest2(psdbetavowel,psdbetasilvowel,0.05);
% ptest1 = [ptest1 p1];
% [h,p2] = ttest2(psdgammavowel,psdgammasilvowel,0.05);
% ptest2 = [ptest2 p2];
% [h,p3] = ttest2(psdhgammavowel,psdhgammasilvowel,0.05);
% ptest3 = [ptest3 p3];

end

% Plot the power spectrum

pxxsilenceavg = 0;
pxxspeechavg = 0;

pxxspeechavg = mean(pxxspeech);
pxxsilenceavg = mean(pxxsilence);
% stdspeech = std(pxxspeech);
% stdsilence = std(pxxsilence);
% x = 1:numel(pxxspeechavg);   
% stderrorspeech1 = pxxspeechavg + (stdspeech/sqrt(size(idx,1)));
% stderrorspeech2 = pxxspeechavg - (stdspeech/sqrt(size(idx,1)));
% stderrorilence1 = pxxsilenceavg + (stdsilence/sqrt(size(idx,1)));
% stderrorsilence2 = pxxsilenceavg - (stdsilence/sqrt(size(idx,1)));
% x2 = [x, fliplr(x)];
% % inBetween = [curve1, fliplr(curve2)];
% % fill(x2, inBetween, 'g');
% % hold on;
% %plot(x, pxxspeechavg, 'r', 'LineWidth', 2);
% 
psdsmoothspeech = smoothdata(10*log10(pxxspeechavg));
psdsmoothsilence = smoothdata(10*log10(pxxsilenceavg));
% curve1smooth = smoothdata(10*log10(stderrorspeech1));
% curve2smooth = smoothdata(10*log10(stderrorspeech2));
% curve3smooth = smoothdata(10*log10(stderrorilence1));
% curve4smooth = smoothdata(10*log10(stderrorsilence2));
% 
% % % [pks,locs] = findpeaks(10*log10(pxxspeechavg));
% % F1 = [F1 (locs(2)/fs1)*fs];
% % F2 = [F2 (locs(3)/fs1)*fs];
% 
% 
% for i=1:1:size(f,2)
%     while (f(i) > 2 && f(i) < 8)
%         psdalpha = [psdalpha psdsmoothspeech(i)];
%         psdalphasil = [psdalphasil psdsmoothsilence(i)];
%         i=i+1;
%     end
%     while(f(i) > 10 && f(i) < 30)
%         psdbeta = [psdbeta psdsmoothspeech(i)];
%         psdbetasil = [psdbetasil psdsmoothsilence(i)];
%         i=i+1;
%     end
%     while(f(i) > 30 && f(i) < 45)
%         psdgamma = [psdgamma psdsmoothspeech(i)];
%         psdgammasil = [psdgammasil psdsmoothsilence(i)];
%         i=i+1;
%     end
%     while(f(i) > 55 && f(i) < 95)
%         psdhgamma = [psdhgamma psdsmoothspeech(i)];
%         psdhgammasil = [psdhgammasil psdsmoothsilence(i)];
%         i=i+1;
%     end
% end
% 
% psdalphaavg = mean(psdalpha);
% stdalpha = std(psdalpha);
% psdalphasilavg = mean(psdalphasil);
% stdalphasil = std(psdalphasil);
% psdbetaavg = mean(psdbeta);
% stdbeta = std(psdbeta);
% psdbetasilavg = mean(psdbetasil);
% stdbetasil = std(psdbetasil);
% psdgammaavg = mean(psdgamma);
% stdgamma = std(psdgamma);
% psdgammasilavg = mean(psdgammasil);
% stdgammasil = std(psdgammasil);
% psdhgammaavg = mean(psdhgamma);
% stdhgamma = std(psdhgamma);
% psdhgammasilavg = mean(psdhgammasil);
% stdhgammasil = std(psdhgammasil);
% 
% psdbar =[psdalphaavg 0 psdbetaavg 0 psdgammaavg 0 psdhgammaavg 0];
% psdbarsil =[0 psdalphasilavg 0 psdbetasilavg 0 psdgammasilavg 0 psdhgammasilavg];
% % errhigh = [stderroralpha1 stderroralphasil1 stderrorbeta1 stderrorbetasil1 stderrorgamma1 stderrorgammasil1 stderrorhgamma1 stderrorhgammasil1];
% % errlow = [stderroralpha2 stderroralphasil2 stderrorbeta2 stderrorbetasil2 stderrorgamma2 stderrorgammasil2 stderrorhgamma2 stderrorhgammasil2] ;
% errspeech =[stdalpha/sqrt(size(idx,1)) 0 stdbeta/sqrt(size(idx,1)) 0 stdgamma/sqrt(size(idx,1)) 0 stdhgamma/sqrt(size(idx,1)) 0];
% errsil = [0 stdalphasil/sqrt(size(idx,1)) 0 stdbetasil/sqrt(size(idx,1)) 0 stdgammasil/sqrt(size(idx,1)) 0 stdhgammasil/sqrt(size(idx,1))];
% 
% % x=1:8;
 %figure();
% % subplot(2,1,1)
% plot(psdsmoothsilence,'b','LineWidth',1);
% hold on
% plot(psdsmoothspeech,'r','LineWidth',1);
% % hold on;
% % plot(curve1smooth,'r','LineWidth',1);
% % hold on
% % plot(curve2smooth,'r','LineWidth',1);
% % hold on;
% % plot(curve3smooth,'b','LineWidth',1);
% % hold on
% % plot(curve4smooth,'b','LineWidth',1);
% legend('silence','speech')
% xlabel("Frequency"); ylabel("Power (dB)");
% title("PSD for speech and silent EEG signals")
% % subplot(2,1,2)
% % bar(psdbarsil);
% % hold on
% % er = errorbar(x,psdbarsil,errsil,errsil);    
% % er.Color = [0 0 0];                            
% % er.LineStyle = 'none';  
% % hold off
% % hold on
% % bar(psdbar,'r');
% % hold on
% % er = errorbar(x,psdbar,errspeech,errspeech);    
% % er.Color = [0 0 0];                            
% % er.LineStyle = 'none';  
% % hold off
% % xlabel("Frequency"); ylabel("Power (dB)");
% % title("Power Bar Graph")

end
%%
speechavg = mean(pxxspeech);
silenceavg = mean(pxxsilence);
stdspeech = std(pxxspeech);
stdsilence = std(pxxsilence);

psdsmoothspeech = smoothdata(10*log10(speechavg));
psdsmoothsilence = smoothdata(10*log10(silenceavg));

figure();
plot((psdsmoothspeech),'r','LineWidth', 2);
hold on
plot((psdsmoothsilence),'b','LineWidth', 2);
% hold on
% plot(speechavg-(stdspeech/sqrt(size(idx,1))),'r','LineWidth',1);
% hold on
% plot(speechavg+(stdspeech/sqrt(size(idx,1))),'r','LineWidth',1);
% hold on
% plot(silenceavg-(stdsilence/sqrt(size(idx,1))),'b','LineWidth',1);
% hold on
% plot(silenceavg+(stdsilence/sqrt(size(idx,1))),'b','LineWidth',1);
% title("Average trace over all channels + stderror")
% xlabel("Time (ms)")
% ylabel("Amplitude (uV)")
%  legend('speech','silence')
%% 

htest=[];
[h,p] = ttest2(pxxspeech,pxxsilence,'alpha',0.05);
 %p1 = reshape(p,4,[]);
 k =p(h==1);

figure();
% x_lim = [0 1];
% pp = histogram(p1);
% pp.BinWidth = 0.005;
% xlim(x_lim);
% title("h-test Histogram");
% xlabel("h-values");
imagesc(p1);
colorbar;

% figure();
% x_lim = [0 1];
% h = histogram(ptest1);
% h.BinWidth = 0.005;
% xlim(x_lim);
% title("P-test Histogram for Beta Band");
% xlabel("p-values");
% 
% figure();
% x_lim = [0 1];
% h = histogram(ptest2);
% h.BinWidth = 0.005;
% xlim(x_lim);
% title("P-test Histogram for Gamma Band");
% xlabel("p-values");
% 
% figure();
% x_lim = [0 1];
% h = histogram(ptest3);
% h.BinWidth = 0.005;
% xlim(x_lim);
% title("P-test Histogram for High Gamma Band");
% xlabel("p-values");