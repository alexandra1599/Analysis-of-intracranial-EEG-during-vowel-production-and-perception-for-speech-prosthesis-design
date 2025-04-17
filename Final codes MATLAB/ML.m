%% MACHINE LEARNING IMPLEMENTATION

% LOAD DATA
streams = loadxdf('/Users/alexandramikhael/Downloads/vowel Netherland/kh28_vowels.xdf');
x = streams(3);
z = streams(1);
data = x{1, 1}.time_series(1,:);
time = x{1,1}.time_stamps;
fs = streams{1, 3}.segments.effective_srate;
vowelmarkers = z{1, 1}.time_series(1,:);
t_vowelmarkers = z{1, 1}.time_stamps;
windowDuration = 0.3; % seconds
numWindowSamples = round(windowDuration*fs);
win = hamming(numWindowSamples,'periodic');

percentOverlap = 35;
overlap = round(numWindowSamples*percentOverlap/100);

mergeDuration = 0.44;
mergeDist = round(mergeDuration*fs);

detectSpeech(data',fs,"Window",win,"OverlapLength",overlap,"MergeDistance",mergeDist)
idx = detectSpeech(data',fs,"Window",win,"OverlapLength",overlap,"MergeDistance",mergeDist);
%idx holds the start and stop times of each utterance

x1 = streams(2);
data1 = x1{1, 1}.time_series(:,:);
time1 = x1{1,1}.time_stamps;
fs1 = streams{1, 2}.segments.effective_srate;
idx = (idx/fs)*fs1;
%% DATA CLEANING

% kh-28
channels = [pr1; pr2; pr3; pr4; pr5 ; pr7; pr13];
mean_speech = []; mean_silence = [];
%% kh 30
channels = [pr2; pr3; pr4; pr7 ; pr8;  pr9; pr10];


%% STEP 1 : GET THE FEATURES FOR EACH SEGMENT OF DATA
windowlength = 0.5*fs1;

for i=1:1:size(channels,1)
   j=1;
for k=1:1:size(idx,1) 
    q=1;
  startsilence = idx(k,2)+(windowlength/2); %$end of speech + 250ms
  endsilence = startsilence + windowlength; %startsilence + 500ms
  startspeech = idx(k,1)-(windowlength/10); %start of speech - 50 ms
  endspeech = startspeech + windowlength; %startspeech + 500ms
  datasilence = channels(i,startsilence:endsilence);
  dataspeech = channels(i,startspeech:endspeech);

  %feature 1 : MEAN
  mean_speech(i,k) = mean(dataspeech);
  mean_silence(i,k) = mean(datasilence);

  %feature 2 : STD
  std_speech(i,k) = std(dataspeech);
  std_silence(i,k) = std(datasilence);
  
  %feature 3 : skewness 
  skew_speech(i,k) = skewness(dataspeech);
  skew_silence(i,k) = skewness(datasilence);

  %feature 4 : Kurtosis
  kurt_speech(i,k) = kurtosis(dataspeech);
  kurt_silence(i,k) = kurtosis(datasilence);

  %feature 5 : RMS
  rms_speech(i,k) = rms(dataspeech);
  rms_silence(i,k) = rms(datasilence);

  %feature 6 : band power : get the two arrays speech and silence
  % from the ttest function file

  %feature 7 : shannon entropy
  entropy_speech(i,q:q+3) = wentropy(dataspeech,Level=3);
  entropy_silence(i,q:q+3) = wentropy(datasilence,Level=3);
    q=q+4;

end 
end

%% plot resutls

figure();
histogram(mean_silence);
figure();
histogram(mean_speech);

%%
figure();
bar(mean_silence(9,:),'b');
title("Bar graph for kurt of 1 iEEG channel over all trials")
hold on
%figure();
bar(mean_speech(9,:), 'r');
legend("silence","speech");
%title("Bar graph for means of iEEG for speech")

