x1 = streams(2);
data1 = x1{1, 1}.time_series(:,:);
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


[b1,a1] = butter(4,[70, 200]/(fs1/2),'bandpass');
filtered_data = double(filtfilt(b1,a1,filtered_data));
%% silence

pxxsilence = [];
for k=1:1:size(data1)
   powersilence = [];
   for i = 1:1:size(idx,1)-4
 
   startsilence = idx(i,2);
   endsilence = startsilence + windowlength; 

  datasilence = filtered_data(k,startsilence:endsilence);
  
  %power
 
p1 = pspectrum(datasilence,fs1,'spectrogram','TimeResolution',0.0045);
psila = p1(10,:);
  pxxsilence = [pxxsilence; psila];

   end
end
stdsilence = std(mean(pxxsilence));
%%
label_group1 = ["start;oo","start;uu","start;eu"];
label_group2 = ["start;oe","start;ee","start;ie"];
v_e=[];v_o=[];v_oe=[];v_u=[];v_ie=[];v_eu=[];
speech = [];
z=0
for k=1:1:size(data1,1)
%zspeech=[];

  for i =6:1:size(idx,1)-4

  startspeech = idx(i,1)-(windowlength); 
  endspeech =idx(i,2)+(windowlength);
  startsilence_before = idx(i-1,2)+(windowlength/4); 
  endsilence_before = startsilence_before + (endspeech - startspeech);
  startsilence_after = idx(i,2)+(windowlength/4); 
  endsilence_after = startsilence_after + (endspeech - startspeech);
 
  datasilenceb = filtered_data(k,startsilence_before:endsilence_before);
   datasilencea = filtered_data(k,startsilence_after:endsilence_after);
  dataspeech1 = filtered_data(k,startspeech:endspeech);
 


p1 = pspectrum(datasilencea,fs1,'spectrogram','TimeResolution',0.0045);
p2 = pspectrum(datasilenceb,fs1,'spectrogram','TimeResolution',0.0045);
p3 = pspectrum(dataspeech1,fs1,'spectrogram','TimeResolution',0.0045);

psila = (p1(10,:));
psilb = (p2(10,:));
pspeech = (p3(10,:));

z = (pspeech-((psila+psilb)/2))/stdsilence;


 s = streams{1,1}.time_series(2*i);
  s = strip(s,'right'); 
  st = string(s);   

   if(strcmp(label_group1(1),st))%||strcmp(label_group1(2),st)||strcmp(label_group1(3),st))
       v_o = [v_o; z(1,1:1000)];

   end
   if(strcmp(label_group1(2),st))%label_group2(1),st)||strcmp(label_group2(2),st)||strcmp(label_group2(3),st))
       v_u = [v_u;z(1,1:1000)];

   end
   if(strcmp(label_group1(3),st))%label_group2(1),st)||strcmp(label_group2(2),st)||strcmp(label_group2(3),st))
       v_eu = [v_eu;z(1,1:1000)];

   end
   if(strcmp(label_group2(1),st))%label_group2(1),st)||strcmp(label_group2(2),st)||strcmp(label_group2(3),st))
       v_oe = [v_oe;z(1,1:1000)];


   end
   if(strcmp(label_group2(2),st))%label_group2(1),st)||strcmp(label_group2(2),st)||strcmp(label_group2(3),st))
       v_e = [v_e;z(1,1:1000)];


   end
   if(strcmp(label_group2(3),st))%label_group2(1),st)||strcmp(label_group2(2),st)||strcmp(label_group2(3),st))
       v_ie = [v_ie;z(1,1:1000)];


   end
  end

   % vo_e = [vo_e; mean(v_e)];
   % vo_ie = [vo_ie; mean(v_ie)];
   % vo_eu = [vo_eu; mean(v_eu)];
   %  vo_o = [vo_o; mean(v_o)];
   % vo_oe = [vo_oe;mean(v_oe)];
   % vo_u = [vo_u;mean(v_u)];
   
end


%%

figure();
for i =1:1:100
    plot(v_e(i,:)+i*100);
    hold on
end

%%
%kh-30 grey matter electrodes

