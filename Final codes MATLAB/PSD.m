x1 = streams(2);
% data1 = x1{1, 1}.time_series(:,:);
time1 = x1{1,1}.time_stamps;
fs1 = streams{1, 2}.segments.effective_srate;
idx = (idx/fs)*fs1; 
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

%%
windowlength = 0.5*fs1; %500 ms
offset = 0.02*fs1; %20 ms 
label_group1 = ["start;oo","start;uu","start;eu"];
label_group2 = ["start;oe","start;ee","start;ie"];


%% kh-30

vo =[];vu=[];veu=[];voe=[];ve=[];vie=[];
% vo_lh=[];vo_lhStemps=[];vo_lhGtempm=[];vo_lhGfrm=[];vo_lhGpc=[];
% vu_lh=[];vu_lhStemps=[];vu_lhGtempm=[];vu_lhGfrm=[];vu_lhGpc=[];
% veu_lh=[];veu_lhStemps=[];veu_lhGtempm=[];veu_lhGfrm=[];veu_lhGpc=[];
% voe_lh=[];voe_lhStemps=[];voe_lhGtempm=[];voe_lhGfrm=[];voe_lhGpc=[];
% ve_lh=[];ve_lhStemps=[];ve_lhGtempm=[];ve_lhGfrm=[];ve_lhGpc=[];
% vie_lh=[];vie_lhStemps=[];vie_lhGtempm=[];vie_lhGfrm=[];vie_lhGpc=[];

for i =4:1:size(idx,1)-4
%zspeech=[];
psil=[];pspeech=[];
  for k=1:1:size(data1,1)-1

  startspeech = idx(i,1)+offset;
  endspeech =startspeech + windowlength;
  startsilence_before = idx(i-1,2) + offset;
  endsilence_before = startsilence_before + windowlength;
  startsilence_after = idx(i,2)+ offset; 
  endsilence_after = startsilence_after + windowlength;
 
  datasilenceb = filtered_data(k,startsilence_before:endsilence_before);
   datasilencea = filtered_data(k,startsilence_after:endsilence_after);
  dataspeech1 = filtered_data(k,startspeech:endspeech);
 

Y = dataspeech1;                                                                 % Segment the data to 10s
Y = Y.*hann(length(Y))';                                                   % Apply Hanning Window
N = length(Y);                                                                 % Length of signal segment
P = nextpow2(N);                                                           % Pad signal to increase computational time                   
n = 2^P;
X = fft(Y,n);                                                                    % Apply the fft algorithm
Pxx = 1/(N*fs)*abs(X(1:length(Y)/2+1)).^2;                  % Find signal power
f = (0:fs/N:fs/2);                                                            % Frequency Vector
Pxx(2:end-1) = 2*Pxx(2:end-1);
pspeech = (10*log10(Pxx));


s = streams{1,1}.time_series(2*i);
  s = strip(s,'right'); 
  st = string(s);  
  ch = anatomy{k,4};
  ch = strip(ch,'right'); 
  stch = string(ch);  

 
       a1='Left-Hippocampus';
       a2= 'ctx_lh_S_temporal_sup';
       a3='ctx_lh_G_temporal_middle';
     a4='ctx_lh_G_front_middle';
     a5= 'ctx_lh_G_precentral';


   if(strcmp(label_group1(1),st))%||strcmp(label_group1(2),st)||strcmp(label_group1(3),st))
    
       vo = [vo; pspeech];
 % if(strcmp(a1,stch))
 %    vo_lh = [vo_lh; pspeech];
 %  end
 % 
 % if(strcmp(a2,stch))
 %    vo_lhStemps = [vo_lhStemps; pspeech];
 %  end
 % if(strcmp(a3,stch))
 %    vo_lhGtempm = [vo_lhGtempm; pspeech];
 % end
 % if(strcmp(a4,stch))
 %    vo_lhGfrm = [vo_lhGfrm; pspeech];
 % end
 % if(strcmp(a5,stch))
 %    vo_lhGpc = [vo_lhGpc; pspeech];
 % end
   end

   if(strcmp(label_group1(2),st))%label_group2(1),st)||strcmp(label_group2(2),st)||strcmp(label_group2(3),st))
       
       vu = [vu; pspeech];
 % if(strcmp(a1,stch))
 %    vu_lh = [vu_lh; pspeech];
 %  end
 % 
 % if(strcmp(a2,stch))
 %    vu_lhStemps = [vu_lhStemps; pspeech];
 %  end
 % if(strcmp(a3,stch))
 %    vu_lhGtempm = [vu_lhGtempm; pspeech];
 % end
 % if(strcmp(a4,stch))
 %    vu_lhGfrm = [vu_lhGfrm; pspeech];
 % end
 % if(strcmp(a5,stch))
 %    vu_lhGpc = [vu_lhGpc; pspeech];
 % end

   end


   if(strcmp(label_group1(3),st))%label_group2(1),st)||strcmp(label_group2(2),st)||strcmp(label_group2(3),st))
       
       veu = [veu; pspeech];
 % if(strcmp(a1,stch))
 %    veu_lh = [veu_lh; pspeech];
 %  end
 % 
 % if(strcmp(a2,stch))
 %    veu_lhStemps = [veu_lhStemps; pspeech];
 %  end
 % if(strcmp(a3,stch))
 %    veu_lhGtempm = [veu_lhGtempm; pspeech];
 % end
 % if(strcmp(a4,stch))
 %    veu_lhGfrm = [veu_lhGfrm; pspeech];
 % end
 % if(strcmp(a5,stch))
 %    veu_lhGpc = [veu_lhGpc; pspeech];
 % end

   end
   if(strcmp(label_group2(1),st))%label_group2(1),st)||strcmp(label_group2(2),st)||strcmp(label_group2(3),st))
      
       voe = [voe; pspeech];
 % if(strcmp(a1,stch))
 %    voe_lh = [voe_lh; pspeech];
 %  end
 % 
 % if(strcmp(a2,stch))
 %    voe_lhStemps = [voe_lhStemps; pspeech];
 %  end
 % if(strcmp(a3,stch))
 %    voe_lhGtempm = [voe_lhGtempm; pspeech];
 % end
 % if(strcmp(a4,stch))
 %    voe_lhGfrm = [voe_lhGfrm; pspeech];
 % end
 % if(strcmp(a5,stch))
 %    voe_lhGpc = [voe_lhGpc; pspeech];
 % end


   end
   if(strcmp(label_group2(2),st))%label_group2(1),st)||strcmp(label_group2(2),st)||strcmp(label_group2(3),st))
       
       ve = [ve; pspeech];
 % if(strcmp(a1,stch))
 %    ve_lh = [ve_lh; pspeech];
 %  end
 % 
 % if(strcmp(a2,stch))
 %    ve_lhStemps = [ve_lhStemps; pspeech];
 %  end
 % if(strcmp(a3,stch))
 %    ve_lhGtempm = [ve_lhGtempm; pspeech];
 % end
 % if(strcmp(a4,stch))
 %    ve_lhGfrm = [ve_lhGfrm; pspeech];
 % end
 % if(strcmp(a5,stch))
 %    ve_lhGpc = [ve_lhGpc; pspeech];
 % end


   end
   if(strcmp(label_group2(3),st))%label_group2(1),st)||strcmp(label_group2(2),st)||strcmp(label_group2(3),st))
        
       vie = [vie; pspeech];
 % if(strcmp(a1,stch))
 %    vie_lh = [vie_lh; pspeech];
 %  end
 % 
 % if(strcmp(a2,stch))
 %    vie_lhStemps = [vie_lhStemps; pspeech];
 %  end
 % if(strcmp(a3,stch))
 %    vie_lhGtempm = [vie_lhGtempm; pspeech];
 % end
 % if(strcmp(a4,stch))
 %    vie_lhGfrm = [vie_lhGfrm; pspeech];
 % end
 % if(strcmp(a5,stch))
 %    vie_lhGpc = [vie_lhGpc; pspeech];
 % end

   end
  
  end
  end

% plot(f,smoothdata(10*log10(Pxx)));                                                   % Plot the power spectrum
% title('Power Spectral Density Using FFT')
% xlabel('Frequency (Hz)')
% ylabel('Power/Frequency (dB/Hz)')

%% plot

figure();
plot(mean(vo),'red');
hold on
plot(mean(ve),'blue');
hold on
plot(mean(vie),'black');
hold on 
plot(mean(voe),'magenta')
hold on
plot(mean(veu), 'green')
hold on
plot(mean(vu),'cyan')
title("PSD avg across all trials and channels")
xlabel("Frequency (Hz)")
ylabel("Power (dB)")
legend('/o/','/e/','/ie/','/oe/','/eu/','/u/');

%% kh-31

vo_lh=[];vo_lhStemps=[];vo_lhGtempm=[];vo_lhGfrm=[];vo_lhGpc=[];
vu_lh=[];vu_lhStemps=[];vu_lhGtempm=[];vu_lhGfrm=[];vu_lhGpc=[];
veu_lh=[];veu_lhStemps=[];veu_lhGtempm=[];veu_lhGfrm=[];veu_lhGpc=[];
voe_lh=[];voe_lhStemps=[];voe_lhGtempm=[];voe_lhGfrm=[];voe_lhGpc=[];
ve_lh=[];ve_lhStemps=[];ve_lhGtempm=[];ve_lhGfrm=[];ve_lhGpc=[];
vie_lh=[];vie_lhStemps=[];vie_lhGtempm=[];vie_lhGfrm=[];vie_lhGpc=[];

for i =4:1:size(idx,1)-4
%zspeech=[];
psil=[];pspeech=[];
  for k=1:1:size(data1,1)-1

  startspeech = idx(i,1)+offset;
  endspeech =startspeech + windowlength;
  startsilence_before = idx(i-1,2) + offset;
  endsilence_before = startsilence_before + windowlength;
  startsilence_after = idx(i,2)+ offset; 
  endsilence_after = startsilence_after + windowlength;
 
  datasilenceb = filtered_data(k,startsilence_before:endsilence_before);
   datasilencea = filtered_data(k,startsilence_after:endsilence_after);
  dataspeech1 = filtered_data(k,startspeech:endspeech);
 

Y = dataspeech1;                                                                 % Segment the data to 10s
Y = Y.*hann(length(Y))';                                                   % Apply Hanning Window
N = length(Y);                                                                 % Length of signal segment
P = nextpow2(N);                                                           % Pad signal to increase computational time                   
n = 2^P;
X = fft(Y,n);                                                                    % Apply the fft algorithm
Pxx = 1/(N*fs)*abs(X(1:length(Y)/2+1)).^2;                  % Find signal power
f = (0:fs/N:fs/2);                                                            % Frequency Vector
Pxx(2:end-1) = 2*Pxx(2:end-1);
pspeech = (10*log10(Pxx));


s = streams{1,1}.time_series(2*i);
  s = strip(s,'right'); 
  st = string(s);  
  ch = anatomy{k,4};
  ch = strip(ch,'right'); 
  stch = string(ch);  

  if(size(data1,1)==93) %kh-31
       a1='Left-Hippocampus';
       a2= 'ctx_lh_S_temporal_sup';
       a3='ctx_lh_G_temporal_middle';
     a4='ctx_lh_G_front_middle';
     a5= 'ctx_lh_G_precentral';


   if(strcmp(label_group1(1),st))%||strcmp(label_group1(2),st)||strcmp(label_group1(3),st))
       
 if(strcmp(a1,stch))
    vo_lh = [vo_lh; pspeech];
  end

 if(strcmp(a2,stch))
    vo_lhStemps = [vo_lhStemps; pspeech];
  end
 if(strcmp(a3,stch))
    vo_lhGtempm = [vo_lhGtempm; pspeech];
 end
 if(strcmp(a4,stch))
    vo_lhGfrm = [vo_lhGfrm; pspeech];
 end
 if(strcmp(a5,stch))
    vo_lhGpc = [vo_lhGpc; pspeech];
 end
   end

   if(strcmp(label_group1(2),st))%label_group2(1),st)||strcmp(label_group2(2),st)||strcmp(label_group2(3),st))
       
 if(strcmp(a1,stch))
    vu_lh = [vu_lh; pspeech];
  end

 if(strcmp(a2,stch))
    vu_lhStemps = [vu_lhStemps; pspeech];
  end
 if(strcmp(a3,stch))
    vu_lhGtempm = [vu_lhGtempm; pspeech];
 end
 if(strcmp(a4,stch))
    vu_lhGfrm = [vu_lhGfrm; pspeech];
 end
 if(strcmp(a5,stch))
    vu_lhGpc = [vu_lhGpc; pspeech];
 end

   end


   if(strcmp(label_group1(3),st))%label_group2(1),st)||strcmp(label_group2(2),st)||strcmp(label_group2(3),st))
        
 if(strcmp(a1,stch))
    veu_lh = [veu_lh; pspeech];
  end

 if(strcmp(a2,stch))
    veu_lhStemps = [veu_lhStemps; pspeech];
  end
 if(strcmp(a3,stch))
    veu_lhGtempm = [veu_lhGtempm; pspeech];
 end
 if(strcmp(a4,stch))
    veu_lhGfrm = [veu_lhGfrm; pspeech];
 end
 if(strcmp(a5,stch))
    veu_lhGpc = [veu_lhGpc; pspeech];
 end

   end
   if(strcmp(label_group2(1),st))%label_group2(1),st)||strcmp(label_group2(2),st)||strcmp(label_group2(3),st))
        
 if(strcmp(a1,stch))
    voe_lh = [voe_lh; pspeech];
  end

 if(strcmp(a2,stch))
    voe_lhStemps = [voe_lhStemps; pspeech];
  end
 if(strcmp(a3,stch))
    voe_lhGtempm = [voe_lhGtempm; pspeech];
 end
 if(strcmp(a4,stch))
    voe_lhGfrm = [voe_lhGfrm; pspeech];
 end
 if(strcmp(a5,stch))
    voe_lhGpc = [voe_lhGpc; pspeech];
 end


   end
   if(strcmp(label_group2(2),st))%label_group2(1),st)||strcmp(label_group2(2),st)||strcmp(label_group2(3),st))
        
 if(strcmp(a1,stch))
    ve_lh = [ve_lh; pspeech];
  end

 if(strcmp(a2,stch))
    ve_lhStemps = [ve_lhStemps; pspeech];
  end
 if(strcmp(a3,stch))
    ve_lhGtempm = [ve_lhGtempm; pspeech];
 end
 if(strcmp(a4,stch))
    ve_lhGfrm = [ve_lhGfrm; pspeech];
 end
 if(strcmp(a5,stch))
    ve_lhGpc = [ve_lhGpc; pspeech];
 end


   end
   if(strcmp(label_group2(3),st))%label_group2(1),st)||strcmp(label_group2(2),st)||strcmp(label_group2(3),st))
        
 if(strcmp(a1,stch))
    vie_lh = [vie_lh; pspeech];
  end

 if(strcmp(a2,stch))
    vie_lhStemps = [vie_lhStemps; pspeech];
  end
 if(strcmp(a3,stch))
    vie_lhGtempm = [vie_lhGtempm; pspeech];
 end
 if(strcmp(a4,stch))
    vie_lhGfrm = [vie_lhGfrm; pspeech];
 end
 if(strcmp(a5,stch))
    vie_lhGpc = [vie_lhGpc; pspeech];
 end

   end
  
  end
  end
end
% plot(f,smoothdata(10*log10(Pxx)));                                                   % Plot the power spectrum
% title('Power Spectral Density Using FFT')
% xlabel('Frequency (Hz)')
% ylabel('Power/Frequency (dB/Hz)')
