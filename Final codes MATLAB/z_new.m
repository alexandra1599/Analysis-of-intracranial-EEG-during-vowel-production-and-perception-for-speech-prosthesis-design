x1 = streams(2);
%data1 = x1{1, 1}.time_series(:,:);
time1 = x1{1,1}.time_stamps;
fs1 = streams{1, 2}.segments.effective_srate;
idx = (idx/fs)*fs1; 
windowlength = 0.5*fs1;
nfft = 2^nextpow2(windowlength);

%% remove 50 Hz noise and harmonics
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

%% Get the std of silent segments
pxxsilence = [];
for k=1:1:size(data1)
   powersilence = [];
   for i = 1:1:size(idx,1)-4
   startspeech = idx(i,1)-(windowlength); 
   endspeech =idx(i,2)+(windowlength);
   startsilence = idx(i,2)+(windowlength/4);
   endsilence = startsilence + ((endspeech - startspeech)); 

  datasilence = filtered_data(k,startsilence:endsilence);
  
  %power
 
  [B,f,T] = specgram(datasilence,nfft,fs1,hanning(windowlength),round(windowlength/2));
  B = 10*log10(abs(B));
  pxxsilence = [pxxsilence B];

   end
end
stdsilence = mean(std(pxxsilence));

%%
v_o=[];v_u=[];v_eu=[];v_oe=[];v_e=[];v_ie=[];
vo_o=[];vo_u=[];vo_eu=[];vo_oe=[];vo_e=[];vo_ie=[];
for k=1:1:size(data1,1)
zspeech=[];

  for i =8:1:size(idx,1)-4
  pow=[];avgsilence = 0;

  startspeech = idx(i,1)-(1.5*windowlength); 
  endspeech =idx(i,2)+(windowlength);
  startsilence_before = idx(i-1,2)+(windowlength/4); 
  endsilence_before = startsilence_before + (endspeech - startspeech);
  startsilence_after = idx(i,2)+(windowlength/4); 
  endsilence_after = startsilence_after + (endspeech - startspeech);
  
  data_silence_before = filtered_data(k,startsilence_before:endsilence_before);
  data_silence_after = filtered_data(k,startsilence_after:endsilence_after);
  data_speech = filtered_data(k,startspeech:endspeech);


  [B_sb,fsb,Tsb] = specgram(data_silence_before,nfft,fs1,hanning(windowlength),round(windowlength/2));
  B_sb = 20*log10(abs(B_sb));
  [B_sa,fsa,Tsa] = specgram(data_silence_after,nfft,fs1,hanning(windowlength),round(windowlength/2));
  B_sa = 20*log10(abs(B_sa));
  
  [B_sp,fsp,Tsp] = specgram(data_speech,nfft,fs1,hanning(windowlength),round(windowlength/2));
  B_sp = 20*log10(abs(B_sp));

  avgsilence = (B_sb+B_sa)/2;
  gz = zscore((B_sp - avgsilence)/stdsilence); %zscore for standardization
  zspeech = [zspeech; gz];
 
  end
end
  

%% HERFF CODE

 %Filter High-Gamma Band
[b,a] = butter(4, [70/(fs1/2),170/(fs1/2)],'bandpass');
data2 = filtfilt(b,a,eeg);
 %Attenuate first harmonic of line noise
[b1,a1] = butter(4, [98/(fs1/2),102/(fs1/2)],'stop');
data3 = filtfilt(b1,a1,data2);
 %Attenuate second harmonic of line noise
[b2,a2] = butter(4, [148/(fs1/2),152/(fs1/2)],'stop');
filtered_data = filtfilt(b2,a2,data3);

%%
label_group1 = ["start;oo","start;uu","start;eu"];
label_group2 = ["start;oe","start;ee","start;ie"];

for i = 15:1:size(idx,1)-4
figure();
startspeech1 = idx(i,1)-(1.5*windowlength); 
endspeech1 =idx(i,2)+(windowlength);
data_speech1 = filtered_data(4,startspeech1:endspeech1);

M = 73;
L = 24;
g = flattopwin(M);
Ndft = 895;
neven = ~mod(Ndft,2);

 % s = streams{1,1}.time_series(2*i);
 %  s = strip(s,'right'); 
 %  st = string(s); 

spectrogram(data_speech1,g,L,Ndft,fs1,"power","yaxis");
clim([0 40])
% if(strcmp(label_group1(1),st))
%     title("Spectrogram for vowel /o/");
% end
% if(strcmp(label_group1(2),st))
%     title("Spectrogram for vowel /u/");
% end
% if(strcmp(label_group1(3),st))
%     title("Spectrogram for vowel /eu/");
% end
% if(strcmp(label_group2(1),st))
%     title("Spectrogram for vowel /oe/");
% end
% if(strcmp(label_group2(2),st))
%     title("Spectrogram for vowel /e/");
% end
% if(strcmp(label_group2(3),st))
%     title("Spectrogram for vowel /ie/");
% end

end

%%
nwbfile = nwbRead('/Users/alexandramikhael/Downloads/SingleWordProductionDutch-iBIDS/sub-01/ieeg/sub-01_task-wordProduction_ieeg.nwb')
eeg = nwbfile.acquisition.get('iEEG').data.load;
