% re-referencing scheme where you calculate the reference only from 
% the white matter electrodes and then apply it to the grey matter electrodes

%streams = loadxdf('/Users/alexandramikhael/Downloads/vowel Netherland/kh28_vowels.xdf');
x1 = streams(2);
data1 = x1{1, 1}.time_series(:,:);
time1 = x1{1,1}.time_stamps;
fs1 = streams{1, 2}.segments.effective_srate;

windowlength = 0.5*fs1;
nfft = 2^nextpow2(windowlength);

%% STEP 1 : Group the channels by white matter vs grey matter
% kh-28
% white matter
lwm1 = data1(5:7,:);
lwm2= data1(10,:);
lwm3=data1(12:13,:); lwm4= data1(16:18,:);
lwm5= data1(22:24,:);lwm6= data1(26,:);lwm7= data1(30:37,:);
left_white_matter_electrodes = [lwm1; lwm2 ;lwm3; lwm4;lwm5;lwm6;lwm7];
avg_channel_left_white_matter = mean(left_white_matter_electrodes);

rwm1 = data1(40:42,:); rwm2 = data1(45,:); rwm3 = data1(51:56,:);
rwm4 = data1(65:66,:); rwm5 = data1(72,:);rwm6 = data1(77,:);
 rwm8 = data1(80:82,:); rwm9 = data1(85:88,:); 
rwm10 = data1(95:101,:); rwm11 = data1(105:108,:);rwm12 = data1(113:114,:);
rwm13 = data1(119,:);rwm14 = data1(126:127,:);rwm15=data1(129,:);
right_white_matter_electrodes = [rwm1; rwm2 ;rwm3; rwm4; rwm5;rwm6;rwm8;rwm9;rwm10;rwm11;rwm12;rwm13;rwm14;rwm15];
avg_channel_right_white_matter = mean(right_white_matter_electrodes);

% grey matter
grey_left=[data1(1:4,:);data1(9,:);data1(11,:);data1(14:15,:);data1(19:21,:);data1(25,:);data1(28:29,:);data1(38,:)];

grey_right =[data1(39,:);data1(43:44,:);
    data1(46,:);data1(49:50,:);data1(57,:);data1(59,:);
    data1(60:64,:);data1(68:71,:);data1(73:75,:);data1(79,:);data1(83:84,:);
    data1(89:93,:);data1(102:104,:);data1(109,:);data1(111:112,:);data1(115:118,:);data1(120:125,:);data1(128,:)];

for i=1:1:size(grey_left,1)
    grey_left(i,:) =  grey_left(i,:) - avg_channel_left_white_matter;
end
for i=1:1:size(grey_right,1)
    grey_right(i,:) = grey_right(i,:) - avg_channel_right_white_matter;
end

data1 = [grey_left;grey_right];
 

%% kh30

% white matter
lwm1 = data1(8:11,:);
lwm2= data1(16:18,:); lwm3=data1(23,:);lwm4= data1(25:26,:);
lwm5= data1(28:31,:);lwm6=data1(33,:);lwm7=data1(35:36,:);lwm8=data1(39,:);
left_white_matter_electrodes = [lwm1; lwm2 ;lwm3; lwm4;lwm5;lwm6;lwm7;lwm8];
avg_channel_left_white_matter = mean(left_white_matter_electrodes);
rwm1 = data1(47,:); rwm2 = data1(49:51,:);rwm3 = data1(67:69,:);
rwm4 = data1(72:73,:); rwm5 = data1(77,:);rwm6 = data1(79:82,:);
 rwm8 = data1(87,:);  rwm9 = data1(90:91,:); 
rwm10 = data1(94,:); rwm11 = data1(99:100,:);rwm12 = data1(105,:);rwm13 = data1(121,:);
rwm14 = data1(123:124,:);
right_white_matter_electrodes = [rwm1; rwm2 ;rwm3; rwm4; rwm5;rwm6;rwm8;rwm9;rwm10;rwm11;rwm12;rwm13;rwm14];
avg_channel_right_white_matter = mean(right_white_matter_electrodes);

% grey matter left
Ctx_lh_G_and_S_Cingul_ant1 = data1(1:4,:); Ctx_lh_G_and_S_Cingul_ant2 = data1(6:7,:); 
Ctx_lh_G_and_S_Cingul_ant3 = data1(13:15,:); 
Ctx_lh_G_and_S_Cingul_ant = [Ctx_lh_G_and_S_Cingul_ant1;Ctx_lh_G_and_S_Cingul_ant2;Ctx_lh_G_and_S_Cingul_ant3];
Ctx_lh_G_front_mid1 = data1(12,:); Ctx_lh_G_front_mid3 = data1(40,:);
Ctx_lh_G_front_mid2 =  data1(22,:);
Ctx_lh_G_front_mid = [ Ctx_lh_G_front_mid1; Ctx_lh_G_front_mid2;Ctx_lh_G_front_mid3];
Ctx_lh_S_front_mid1 =  data1(19,:); Ctx_lh_S_front_mid2 =  data1(21,:);
Ctx_lh_S_front_mid = [Ctx_lh_S_front_mid1;Ctx_lh_S_front_mid2];
Ctx_lh_G_and_S_Cingul_mid_ant =  data1(24,:);
Ctx_lh_G_front_sup1=  data1(27,:);Ctx_lh_G_front_sup2=  data1(32,:);
Ctx_lh_G_front_sup = [Ctx_lh_G_front_sup1;Ctx_lh_G_front_sup2];
Ctx_lhS_circ_Ins_sup = data1(34,:);
Ctx_lhS_front_inf= data1(37:38,:);
left_grey_matter_electrodes = [Ctx_lh_G_and_S_Cingul_ant;Ctx_lh_G_front_mid;Ctx_lh_S_front_mid;Ctx_lh_G_and_S_Cingul_mid_ant;
    Ctx_lh_G_front_sup;Ctx_lhS_circ_Ins_sup;Ctx_lhS_front_inf];


Ctx_rh_G_And_S_Cingul_ant1 = data1(41:42,:);Ctx_rh_G_And_S_Cingul_ant2 = data1(44,:);
Ctx_rh_G_And_S_Cingul_ant3 = data1(46,:);Ctx_rh_G_And_S_Cingul_ant4 = data1(48,:);
Ctx_rh_G_And_S_Cingul_ant5 = data1(65:66,:); Ctx_rh_G_And_S_Cingul_ant6 = data1(78,:);
Ctx_rh_G_And_S_Cingul_ant = [Ctx_rh_G_And_S_Cingul_ant1;Ctx_rh_G_And_S_Cingul_ant2;Ctx_rh_G_And_S_Cingul_ant3;Ctx_rh_G_And_S_Cingul_ant4;Ctx_rh_G_And_S_Cingul_ant5;Ctx_rh_G_And_S_Cingul_ant6];
Ctx_rh_S_front_mid1 = data1(52:53,:); Ctx_rh_S_front_mid2 = data1(70:71,:);
Ctx_rh_S_front_mid = [Ctx_rh_S_front_mid1;Ctx_rh_S_front_mid2];
Ctx_rh_Gand_S_transvfrontopol = data1(54:55,:);
Ctx_rh_G_front_mid1= data1(74:75,:); Ctx_rh_G_front_mid2= data1(95:96,:);
Ctx_rh_G_front_mid = [Ctx_rh_G_front_mid1;Ctx_rh_G_front_mid2];
Ctx_rh_S_Front_sup1= data1(83:84,:);Ctx_rh_S_Front_sup2= data1(106:107,:);
Ctx_rh_S_Front_sup3= data1(109,:);Ctx_rh_S_Front_sup = [Ctx_rh_S_Front_sup1;Ctx_rh_S_Front_sup2;Ctx_rh_S_Front_sup3];
Ctx_rh_G_Front_sup1 = data1(85:86,:); Ctx_rh_G_Front_sup2 = data1(110:112,:);
Ctx_rh_G_Front_sup = [Ctx_rh_G_Front_sup1;Ctx_rh_G_Front_sup2];
Ctx_rhS_circ_Ins_sup1 = data1(88:89,:);Ctx_rhS_circ_Ins_sup2 = data1(98,:);
Ctx_rhS_circ_Ins_sup = [Ctx_rhS_circ_Ins_sup1;Ctx_rhS_circ_Ins_sup2];
Ctx_rh_S_front_inf= data1(92:93,:);Ctx_rh_S_central = data1(101,:);
Ctx_rh_G_post_central = data1(102:104,:);
Ctx_rhG_orbital= data1(113:114,:);
Ctx_rh_Sorb_H_Shaped = data1(115:120,:);
Ctx_rh_G_front_inf_orbital = data1(125:126,:);
right_grey_matter_electrodes = [Ctx_rh_G_And_S_Cingul_ant;Ctx_rh_S_front_mid;Ctx_rh_Gand_S_transvfrontopol;Ctx_rh_G_front_mid
    Ctx_rh_S_Front_sup;Ctx_rh_G_Front_sup;Ctx_rhS_circ_Ins_sup;Ctx_rh_S_front_inf;Ctx_rh_S_central;
    Ctx_rh_G_post_central;Ctx_rhG_orbital;Ctx_rh_Sorb_H_Shaped;Ctx_rh_G_front_inf_orbital];


%% kh31
%white matter
lwm1 = data1(4:5,:);
lwm2= data1(13:19,:); lwm3=data1(23:25,:);lwm4= data1(29,:);
lwm5= data1(32:38,:);lwm6=data1(43:51,:);lwm7=data1(53:63,:);lwm8=data1(66:69,:);
lwm9=data1(71:73,:);lwm10=data1(78:81,:);lwm11=data1(86:92,:);
left_white_matter_electrodes = [lwm1; lwm2 ;lwm3; lwm4;lwm5;lwm6;lwm7;lwm8;lwm9;lwm10;lwm11];
avg_channel_left_white_matter = mean(left_white_matter_electrodes);

% grey matter left
left_hippo=data1(1:3,:);
ctx_lh_S_temporal_sup1= data1(6:8,:);
ctx_lh_G_temporal_middle= data1(9:10,:); 
WM_hypointensities1 = data1(11:12,:);
ctx_lh_G_front_middle1 =  data1(20,:); 
LeftLateralVentricle1 =  data1(21:22,:);
ctx_lh_G_front_middle2 =  data1(26:28,:);
ctx_lh_G_front_middle3 =  data1(30,:);
 LeftLateralVentricle2 =  data1(31,:); 
ctx_lh_G_precentral1 = data1(39,:);
WM_hypointensities2 = data1(41:42,:);
ctx_lh_G_precentral2 = data1(52,:);
ctx_lh_G_parietal_sup = data1(64,:); 
WM_hypointensities3 = data1(65,:);
ctx_lh_S_temporal_sup2 = data1(70,:);
ctx_lh_S_calcarine= data1(75:76,:);
WM_hypointensities4 = data1(77,:);
ctx_lh_G_temporal_middle2 = data1(82:84,:); 
ctx_lh_S_calcarine2 = data1(85,:); 
LeftLateralVentricle = data1(87,:);
left_grey_matter_electrodes = [left_hippo;ctx_lh_S_temporal_sup1;ctx_lh_G_temporal_middle;
    WM_hypointensities1;ctx_lh_G_front_middle1;LeftLateralVentricle1;ctx_lh_G_front_middle2;
   ctx_lh_G_front_middle3; LeftLateralVentricle2;ctx_lh_G_precentral1;WM_hypointensities2;
   ctx_lh_G_precentral2;ctx_lh_G_parietal_sup;WM_hypointensities3;ctx_lh_S_temporal_sup2;
   ctx_lh_S_calcarine;WM_hypointensities4;ctx_lh_G_temporal_middle2;ctx_lh_S_calcarine2;
   LeftLateralVentricle];

%% STEP 2 :  Re-referencing


for i=1:1:size(grey_left,1)
    grey_left(i,:) =  grey_left(i,:) - avg_channel_left_white_matter;
end
for i=1:1:size(grey_right,1)
    grey_right(i,:) = grey_right(i,:) - avg_channel_right_white_matter;
end

data1 = [grey_left;grey_right];
%%
for i=1:1:size(left_grey_matter_electrodes,1)
    left_grey_matter_electrodes(i,:) =  left_grey_matter_electrodes(i,:) - avg_channel_left_white_matter;
end
for i=1:1:size(right_grey_matter_electrodes,1)
    right_grey_matter_electrodes(i,:) = right_grey_matter_electrodes(i,:) - avg_channel_right_white_matter;
end

data1 = [left_grey_matter_electrodes;right_grey_matter_electrodes];

%% kh31
for i=1:1:size(grey,1)
    grey(i,:) =  grey(i,:) - avg_channel_left_white_matter;
end

data1 = left_grey_matter_electrodes;