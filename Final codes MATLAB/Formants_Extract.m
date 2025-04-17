%% AUDIO FILES LOAD

streams = loadxdf('/Users/alexandramikhael/Downloads/vowel Netherland/kh28_vowels.xdf');

x = streams(3);
z = streams(1);
data = x{1, 1}.time_series(1,:);
time = x{1,1}.time_stamps;
fs = streams{1, 3}.segments.effective_srate;
vowelmarkers = z{1, 1}.time_series(1,:);
t_vowelmarkers = z{1, 1}.time_stamps;

%% function [F1,F2] = formants_extract(data,fs)
y = data;
Fs = fs;


% Get time vector
t = (0:length(y)-1)*1/Fs;

% Plot the waveform
figure('name', 'Voice sample')
plot(t, y, 'black')
grid off
xlabel('Time (s)')
ylabel('Amplitude')
title('Speech Signal')

%% Get the speech envelope

env1 = hilbert(y);
env1 = abs(env1);

% Low pass filter
[z,p,k] = butter(8,10/(round(Fs/2)),'low');
[sos,g] = zp2sos(z,p,k);
env = filtfilt(sos,g,double(env1));
envelopeOut = env;

figure();
plot(data);
hold on
plot(envelopeOut);

%% detect speech 

% figure(1);
% % Get the handle of figure(n).
% fig1_comps.fig = gcf;
windowDuration = 0.3; % seconds
numWindowSamples = round(windowDuration*fs);
win = hamming(numWindowSamples,'periodic');

percentOverlap = 35;
overlap = round(numWindowSamples*percentOverlap/100);

mergeDuration = 0.44;
mergeDist = round(mergeDuration*fs);

detectSpeech(data',fs,"Window",win,"OverlapLength",overlap,"MergeDistance",mergeDist)
idx = detectSpeech(data',fs,"Window",win,"OverlapLength",overlap,"MergeDistance",mergeDist);

 % STANDARDIZE_FIGURE(fig1_comps);
 % SAVE_MY_FIGURE(fig1_comps, '/Users/alexandramikhael/Desktop/Figures/detectspeech.png', 'big');

%idx holds the start and stop times of each utterance

%%
%disregard the first 5 and last one for kh-31 and only last one for kh-30
%68 utterances in kh31 and 70 utterances in kh30

speechlength = []; splen = 1;
silencelength = []; silen = 1;

for i = 1:1:size(idx,1)-1
    splen = time(1,idx(i,2)) - time(1,idx(i,1));
    silen = time(1,idx(i+1,1)) - time(1,idx(i,2));
    speechlength = [speechlength splen];
    silencelength = [silencelength silen];
end

figure();
histogram(speechlength)
title("Histogram for Length of Speech Chuncks");
xlabel("Utterance length (s)")
ylabel("Number of chunks");

figure();
histogram(silencelength)
title("Histogram for Length of Silence Chuncks");
xlabel("Silence length (s)")
ylabel("Number of chunks");


%% Compute spectrogram using hamming window
% Time in seconds
Tw = [0.1, 0.35];
Ts = Tw(1)/2;

% Window size in samples
windowSize = [Tw(1)*Fs, Tw(2)*Fs];
windowOverlap = ceil(Ts * Fs);
nfft = [2^nextpow2(windowSize(1)), 2^nextpow2(windowSize(2))];

% Generate hamming window
wideWindow = hamming(windowSize(1));
narrowWindow = hamming(windowSize(2));

% Plot spectograms
figure('name', 'Spectrogram for wide window')
spectrogram(y, wideWindow, windowOverlap, nfft(1), Fs, 'yaxis')
title(['Using ', num2str(nfft(1)), ' DFT points'])

figure('name', 'Spectrogram for narrow window')
spectrogram(y, narrowWindow, windowOverlap, nfft(2), Fs, 'yaxis')
title(['Using ', num2str(nfft(2)), ' DFT points'])

%% Mel Filter bank

 %[freqmel1 freqmel2] = MelFrequencies(y,Fs);


%% Voiced, unvoiced and silence detection
% Here, wide window parameters are being used
window  = ceil(0.010*4 * Fs);
overlap = ceil(0.005 * Fs);

% Buffer speech signal into matrix of data frames
dataframes = buffer(y, window, overlap, 'nodelay')';
num_df = size(dataframes, 1);

% Initialize vectors
E = zeros(1,num_df);
ZCR = zeros(1,num_df);
decision = zeros(1,num_df);
pitch = zeros(1,num_df);
F1 = [];
F2 = [];
tt = [];


voiced = 0;
for k = 100:num_df-40
    % Extract one frame
    x = double(dataframes(k,:));
    
    % Compute its energy
    E(k) = sum(x.^2);
    
    % Compute its zero-crossing rate
    ZCR(k) = sum(abs(diff(x>0)))/length(x);
    
    % Check if the frame is voice, no voice or, silence
    decision(k) = Detect(E(k), ZCR(k));
    
    % Compute pitch and number of voiced frames
    if decision(k) == 2 % i.e., voice
        voiced = voiced + 1;
        pitch(k) = Pitch(x, Fs);
        [f1,f2,tt1] = formants(x,Fs,k,50);
        F1 = [F1 f1];
        F2 = [F2 f2];
        tt = [tt tt1];
    end
end
% 
% figure(1);
% % Get the handle of figure(n).
% fig1_comps.fig = gcf;
% fig1_comps.t1 = tiledlayout(fig1_comps.fig, 3, 1);
% % When the number of tiles is unknown use - tiledlayout(fig1, 'flow');
% % For each data set that you plot number the plot.
% % Each figure is a new window on which we can plot many data sets. Eg: In the same window plot a line y = mx + c and y = x^2 as well.
% % Tile 1
% fig1_comps.n(1) = nexttile;
% fig1_comps.p1 = plot(y);
% fig1_comps.tile1.plotXLabel = xlabel('Time (s)');
% fig1_comps.tile2.plotYLabel = ylabel('Input Signal');
% 
% % Tile 2
% fig1_comps.n(2) = nexttile;
% fig1_comps.p2 = plot(E, '-');
% fig1_comps.tile2.plotXLabel = xlabel('Frame');
% fig1_comps.tile2.plotYLabel = ylabel('Energy');
% 
% % Tile 3
% fig1_comps.n(3) = nexttile;
% fig1_comps.p3 = plot(ZCR, '-');
% fig1_comps.tile3.plotXLabel = xlabel('Frame');
% fig1_comps.tile3.plotYLabel = ylabel('Zero_Crossing Rate');
% 
% 
subplot(3,1,1)
plot(y), grid on
title('Input Signal'), xlabel('Time (s)')

subplot(3,1,2)
plot(E, '-'), grid off
title('Energy'), xlabel('Frames')

subplot(3,1,3)
plot(ZCR, '-'), grid on
title('Zero-Crossing Rate'), xlabel('Frames')
% 
% STANDARDIZE_FIGURE(fig2_comps);
% SAVE_MY_FIGURE(fig2_comps, '/Users/alexandramikhael/Desktop/Figures/zcr.png', 'big');



% % Plot Energy and Zero-Crossing Rate
% figure('name', 'Energy and Zero-Crossing Rate')
% subplot(3,1,1)
% plot(t, y), grid on
% title('Input Signal'), xlabel('Time (s)')
% 
% subplot(3,1,2)
% plot(E, '-'), grid on
% title('Energy'), xlabel('Frames')
% 
% subplot(3,1,3)
% plot(ZCR, '-'), grid on
% title('Zero-Crossing Rate'), xlabel('Frames')

%% Linear predictive coding - LPC Analysis
voicedFrame = zeros(window, 1);
unvoicedFrame = zeros(window, 1);


% Isolate a voiced frame
t_voiced = (0:length(voicedFrame)-1)*1/Fs;
for k = 1:num_df
    if decision(k) == 2
        voicedFrame = dataframes(k, :);
        break;
    end
end

% Isolate an unvoiced frame
t_unvoiced = (0:length(unvoicedFrame)-1)*1/Fs;
for k = 1:num_df
    if decision(k) == 1
        unvoicedFrame = dataframes(k,:);
        break;
    end
end

% % LPC on voiced part
% [lpc8v,  error8v, Hv_8] = LPC(voicedFrame, 8);
% [lpc12v, error12v, Hv_12] = LPC(voicedFrame, 12);
% [lpc16v, error16v, Hv_16] = LPC(voicedFrame, 16);
% 
% % LPC on unvoiced part
% [lpc8u,  error8u,  Hu_8]   = LPC(unvoicedFrame, 8);
% [lpc12u, error12u, Hu_12]  = LPC(unvoicedFrame, 12);
% [lpc16u, error16u, Hu_16]  = LPC(unvoicedFrame, 16);
% 
% % Plot LPC of voiced frames
% figure('name', 'LPC - Voiced')
% subplot(3,1,1)
% plot(t_voiced, voicedFrame)
% title('Voiced frame')
% xlabel('Time (s)')
% ylabel('Amplitude')
% 
% subplot(3,1,2)
% DFT(voicedFrame, Fs);
% 
% subplot(3,1,3)
% plot(t_voiced, error8v, t_voiced, error12v, t_voiced, error16v, t_voiced, abs(Hv_8),t_voiced, abs(Hv_12),t_voiced, abs(Hv_16))
% title('Prediction Error')
% xlabel('Time (s)')
% ylabel('Amplitude')
% legend('8','12','16','allpole8','allpole12','allpole16','Location', 'EastOutside')
% 
% % Plot LPC of unvoiced frames
% figure('name', 'LPC - Unvoiced')
% subplot(3,1,1)
% plot(t_unvoiced,unvoicedFrame)
% title('Unvoiced frame')
% xlabel('Time (s)')
% ylabel('Amplitude')
% 
% subplot(3,1,2)
% DFT(unvoicedFrame, Fs);
% 
% subplot(3,1,3)
% plot(t_unvoiced, error8u, t_unvoiced, error12u, t_unvoiced, error16u,t_unvoiced,abs(Hu_8),t_unvoiced, abs(Hu_12),t_unvoiced, abs(Hu_16));
% title('Prediction Error')
% xlabel('Time (s)')
% ylabel('Amplitude')
% legend('8','12','16', 'allpole8','allpole12','allpole16', 'Location', 'EastOutside')

%% Extract voice, unvoiced and silence frames
% Initialize vectors
voiced = zeros(1, numel(decision));
unvoiced = zeros(1, numel(decision));
silence =  zeros(1, numel(decision));

for k = 1:numel(decision)
    if decision(k) == 0         % silence
        voiced(k) = NaN;
        unvoiced(k) = NaN;
    elseif decision(k) == 1     % unvoiced
        unvoiced(k) = 1;
        voiced(k) = NaN;
        silence(k) = NaN;
    else                        % voiced
        voiced(k) = 2;
        unvoiced(k) = NaN;
        silence(k) = NaN;
        
    end
end

%Plot voice activity detection
figure('name', 'Voice Activity Detection')
subplot(2,1,1), plot(t,y), grid on
title('Input Signal'), xlabel('Time (s)')

subplot(2,1,2)
plot(1:num_df, silence, 'b', ...
     1:num_df, unvoiced, 'y+', ...
     1:num_df, voiced, 'r*')
grid on, ylim([-1 3])
title('Voiced-Unvoiced-Silence Detection'), xlabel('Frames'), ylabel('Classification')
legend('silence', 'unvoiced', 'voiced')

% %%   avg formant   
%         length = [];
%         i = 1;
%      while (i <= size(voiced,2))
%          length1 = 0;
%          
%              while(voiced(i) == 2)                
%                 length1 = length1 + 1;
%                 i=i+1;  
%              end
%              if(length1 ~= 0)
%                 length = [length length1];
%              
%              else
%                 i = i+1;
%              end
% 
%         
%      end
% 
%      j=1;f1avg=0;F1avg= [];f2avg=0;F2avg = [];
%      k=1;
%      while(k <= size(F1,2))
%          l=0;
%          while(l < length(j))
%              f1avg = (F1(:,l+k) + f1avg)/2;
%              f2avg = (F2(:,l+k) + f2avg)/2;
%              l = l+1;
%          end
%          F1avg = [F1avg f1avg];
%          F2avg = [F2avg f2avg];  
%          k = k + length(j);
%          j = j + 1;
%      end
% 
% %end

%% Avg formant 
F1d = []; F2d=[];
for k = 1:size(idx,1)
    % Extract one frame
    x = double(data(:,idx(k,1):idx(k,2)));
     [f1d,f2d,tt1] = formants(x,Fs,k,50);
      F1d = [F1d f1d];
      F2d = [F2d f2d];
end

%% Pitch Estimation

for k = 1:size(pitch,2)
    if pitch(k) == 0
        pitch(k) = NaN;
    end
end
disp('Estimated pitch in voice activity:')
fprintf('%.1f Hz\n', unique(pitch(pitch>0)))

%end

function decision = Detect(energy, zcr)
% Detect() classifies the frame to three main classes: 
%           VOICED
%           UNVOICED, and 
%           SILENCE
% The tresholds are calculated by observing the zcr and energy plot.
%
% ARGUMENTS:
%           energy - energy of the frame
%           zcr - zero-crossing rate of the frame
% RETURNS:
%           decision - 0 for silence, 1 for unvoiced, 2 for voiced

low_energy = 4*10^(-3);
high_energy = 1*10^(-2); 

low_zcr = 0.03;
high_zcr = 0.9;
n = length(energy);
decision = zeros(1,n);

for k = 1:n
    if energy(k) < low_energy
        if zcr(k) < low_zcr
            decision(k) = 0;
        elseif zcr(k) < high_zcr
            decision(k) = 0;
        end
    elseif energy(k) < high_energy
        if zcr(k) < low_zcr
            decision(k) = 1;
        elseif zcr(k) < high_zcr
            decision(k) = 2;
        else
            decision(k) = 1;
        end
    else
        decision(k) = 2;
    end
end
end

%% Detect the formants
function [F11,F22,tt] = formants(x,fs,k,order)

    % LPC based features should be applied on the time domain signal!!!
    % LPC widens the signal, models the signal as 1/signal
    % the formants will be the zeros of the lpc
    % plot the vowels using different lpc coefficients
    % use wavelet and then feed into lpc model and see the difference
    % between order 15 and order 8

% get Linear prediction filter

    a = lpc(x,order);


% find frequencies by root-solving

    r = roots(a); % find roots of polynomial a
    r = r(imag(r)>0.01); % only look for roots >0Hz up to fs/2
    ffreq = sort(atan2(imag(r),real(r))*fs/(2*pi));
        
%        if(length(ffreq)>1)
            F11 = ffreq(1);
            tt = k*fs;
            F22 = ffreq(2);
%        else 
%            F11 = 0;
%            F22 = 0;
%            tt = k*fs;
%        end
end

function [Y, fs] = DFT(y, f)
% DFT() computes and plot sdcrete fourier transform of a given signal y
%
% ARGUMENTS:
%           x - signal
%           f - sampling frequency
% RETURNS:
%           Y - DFT of the input signal y
%           fs - sampling frequency

L = length(y);
nfft = 2^nextpow2(L); 
Y = fft(y, nfft)/L;
fs = f/2*linspace(0, 1, nfft/2+1);

% Plot single-sided amplitude spectrum
plot(fs, 2*abs(Y(1:nfft/2+1))) 
title('Discrete Fourier Transform')
xlabel('Frequency (Hz)')
ylabel('Amplitude')
end

function [coef, error, allpole] = LPC(x, order)
% LPC() calculates the LPC coefficients and performs signal estimation
%
% ARGUMENTS:
%           x - signal
%           order - pth order of the filter
% RETURNS:
%           coef - LPC coefficients
%           error - error estimate
%           allpole - all-pole transfer function

[coef, g] = lpc(x, order);
coef = 0 - coef(2:end);
est_x = filter(coef, 1, x);
error = x - est_x;
allpole = filter(sqrt(g), [1 coef], est_x);

end

function pitch = Pitch(x, f)
% Pitch() calculates the the pitch for a framed signal
%
% ARGUMENTS:
%           x - frame signal
%           f - sampling frequency
% RETURNS:
%           pitch - fundamental frequency

[n,m] = size(x);
pitch = zeros(n,1);
for k = 1:n
    c = ifft(log(abs(fft(x(k, :), m)) + eps));
    [~, idx] = max(abs(c));
    pitch(k) = f/idx;
end
end

function [freq1,freq2] = MelFrequencies(x, f)

audioIn = x;

S = melSpectrogram(audioIn,f);

[numBands,numFrames] = size(S);
fprintf("Number of bandpass filters in filterbank: %d\n",numBands)
fprintf("Number of frames in spectrogram: %d\n",numFrames)
figure();
melSpectrogram(audioIn,f)
title('Mel Spectrogram')

% Mel Spectrums of 2048-Point Windows of the Input Speech
S1 = melSpectrogram(audioIn,f, ...
                   'Window',hamming(2048,'periodic'), ...
                   'OverlapLength',1024, ...
                   'FFTLength',4096, ...
                   'NumBands',64, ...
                   'FrequencyRange',[200,3e3]);
figure();
melSpectrogram(audioIn,f, ...
               'Window',hamming(2048,'periodic'), ...
               'OverlapLength',1024, ...
               'FFTLength',4096, ...
               'NumBands',64, ...
               'FrequencyRange',[200,3e3])
title('Mel Spectrums of 2048-Point Windows')

% Design Mel-Based Auditory Filter Bank

win = hamming(1024,"periodic");
noverlap = 512;
fftLength = 1024;
[S,F,time] = stft(audioIn,f, ...
               "Window",win, ...
               "OverlapLength",noverlap, ...
               "FFTLength",fftLength, ...
               "FrequencyRange","onesided");
PowerSpectrum = S.*conj(S);

numBands = 20;
range = [0,4000];
normalization = "bandwidth";

[fb,cf] = designAuditoryFilterBank(f, ...
                                   "FFTLength",fftLength, ...
                                   "NumBands",numBands, ...
                                   "FrequencyRange",range, ...
                                   "Normalization",normalization);

figure();
plot(F,fb.')
grid on
xlim([0 4000])
title("Mel Filter Bank")
xlabel("Frequency (Hz)")

X = fb*PowerSpectrum;

XdB = 10*log10(X);

figure();
surf(time,cf,XdB,"EdgeColor","none");
xlabel("Time (s)")
ylabel("Frequency (Hz)")
zlabel("Power (dB)")
view([45,60])
title('Mel-Based Spectrogram')
axis tight


freq1 = [];
freq2 = [];


maxim = [];
fm = [];


for k = 1:length(XdB)
    X = XdB(:,k);
    [maxi, maxIndex] = max(X);
    maxim = [maxim maxi];
    [row, col] = ind2sub(size(X), maxIndex);
    f = cf(row);
    fm = [fm f];
end

for k = 1:length(fm)
    if(fm(k) > 200 && fm(k) < 800)
        freq1 = [freq1 fm(k)];
    end
    if(fm(k) > 800 && fm(k) < 3000)% && length(freq2) < length(freq1))
        freq2 = [freq2 fm(k)];
    end
end


end
