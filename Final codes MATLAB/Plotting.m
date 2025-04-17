%% getting the locations of the electrodes that we have 
%  = anatomy{i,4}.time_series(2*i);
ve_std1 = std(v_ehilbert);
ve_stderror1 = ve_std1 / sqrt(size(v_ehilbert,1));
figure();
plot(mean(v_ehilbert)/fs1,'LineWidth', 3,'Color','b');
hold on
plot((mean(v_ehilbert)/fs1)+ve_stderror1/fs1,'LineWidth', 1,'Color','r');
hold on
plot((mean(v_ehilbert)/fs1)-ve_stderror1/fs1,'LineWidth', 1,'Color','r');

%xline(1000,'-','Speech Onset', 'LineWidth', 2,'LabelOrientation','horizontal','Color','black');
xlabel('Time (ms)')
ylabel('Z-score')
title('Average Z-score of PSD of HG band across all channels /e/');

veu_std1 = std(v_euhilbert);
veu_stderror1 = veu_std1 / sqrt(size(v_euhilbert,1));
figure();
plot(mean(v_euhilbert)/fs1,'LineWidth', 3,'Color','r');
hold on
plot((mean(v_euhilbert)/fs1)+veu_stderror1/fs1,'LineWidth', 1,'Color','r');
hold on
plot((mean(v_euhilbert)/fs1)-veu_stderror1/fs1,'LineWidth', 1,'Color','r');

%xline(1000,'-','Speech Onset', 'LineWidth', 2,'LabelOrientation','horizontal','Color','black');
xlabel('Time (ms)')
ylabel('Z-score')
title('Average Z-score of PSD of HG band across all channels /eu/');

vie_std1 = std(v_iehilbert);
vie_stderror1 = vie_std1 / sqrt(size(v_iehilbert,1));
figure();
plot(mean(v_iehilbert)/fs1,'LineWidth', 3,'Color','b');
hold on
plot((mean(v_iehilbert)/fs1)+vie_stderror1/fs1,'LineWidth', 1,'Color','b');
hold on
plot((mean(v_iehilbert)/fs1)-vie_stderror1/fs1,'LineWidth', 1,'Color','b');

%xline(1000,'-','Speech Onset', 'LineWidth', 2,'LabelOrientation','horizontal','Color','black');
xlabel('Time (ms)')
ylabel('Z-score')
title('Average Z-score of PSD of HG band across all channels /ie/');

vo_std1 = std(v_ohilbert);
vo_stderror1 = vo_std1 / sqrt(size(v_ohilbert,1));
figure();
plot(mean(v_ohilbert)/fs1,'LineWidth', 3,'Color','b');
hold on
plot((mean(v_ohilbert)/fs1)+vo_stderror1/fs1,'LineWidth', 1,'Color','b');
hold on
plot((mean(v_ohilbert)/fs1)-vo_stderror1/fs1,'LineWidth', 1,'Color','b');

%xline(1000,'-','Speech Onset', 'LineWidth', 2,'LabelOrientation','horizontal','Color','black');
xlabel('Time (ms)')
ylabel('Z-score')
title('Average Z-score of PSD of HG band across all channels /o/');

voe_std1 = std(v_oehilbert);
voe_stderror1 = voe_std1 / sqrt(size(v_oehilbert,1));
figure();
plot(mean(v_oehilbert)/fs1,'LineWidth', 3,'Color','b');
hold on
plot((mean(v_oehilbert)/fs1)+voe_stderror1/fs1,'LineWidth', 1,'Color','b');
hold on
plot((mean(v_oehilbert)/fs1)-voe_stderror1/fs1,'LineWidth', 1,'Color','b');

%xline(1000,'-','Speech Onset', 'LineWidth', 2,'LabelOrientation','horizontal','Color','black');
xlabel('Time (ms)')
ylabel('Z-score')
title('Average Z-score of PSD of HG band across all channels /oe/');

vu_std1 = std(v_uhilbert);
vu_stderror1 = vu_std1 / sqrt(size(v_uhilbert,1));
figure();
plot(mean(v_uhilbert)/fs1,'LineWidth', 3,'Color','b');
hold on
plot((mean(v_uhilbert)/fs1)+vu_stderror1/fs1,'LineWidth', 1,'Color','b');
hold on
plot((mean(v_uhilbert)/fs1)-vu_stderror1/fs1,'LineWidth', 1,'Color','b');

%xline(1000,'-','Speech Onset', 'LineWidth', 2,'LabelOrientation','horizontal','Color','black');
xlabel('Time (ms)')
ylabel('Z-score')
title('Average Z-score of PSD of HG band across all channels /o/');
%%
figure();
plot(mean(v_ehilbert),'LineWidth', 3);
hold on
plot(mean(v_euhilbert),'LineWidth', 3);
 hold on
plot(mean(v_ohilbert),'LineWidth', 3);
 hold on
plot(mean(v_iehilbert),'LineWidth', 3);
 hold on
plot(mean(v_oehilbert),'LineWidth', 3);
hold on
plot(mean(v_uhilbert),'LineWidth', 3);
%xline(1000,'-','Speech Onset', 'LineWidth', 2,'LabelOrientation','horizontal','Color','black');
xlabel('Time (ms)')
ylabel('Z-score')
title('Average Z-score of PSD of HG band across all channels');
legend('/e/','/eu/','/o/','/ie/','/oe/','/u/');
%%
%for i = 1:10:40
figure();
plot(mean(v_e(1:40,:)),'LineWidth', 3);
hold on
plot(mean(v_eu(1:40,:)),'LineWidth', 3);
hold on
plot(mean(v_o(1:40,:)),'LineWidth', 3);
hold on
plot(mean(v_ie(1:40,:)),'LineWidth', 3);
hold on
plot(mean(v_oe(1:40,:)),'LineWidth', 3);
hold on
plot(mean(v_u(1:40,:)),'LineWidth', 3);
xlabel('Frequency (Hz)')
ylabel('Power')
title('Average PSD for left hipocampus');
%xline(1000,'-','Speech Onset', 'LineWidth', 2,'LabelOrientation','horizontal','Color','black');

legend('/e/','/eu/','/o/','/ie/','/oe/','/u/');

%end


%% ctx_lh_G_temporal_middle : 8,10

ve = [v_e(71:80,:);v_e(91:100,:)];
veu = [v_eu(71:80,:);v_eu(91:100,:)];
vo = [v_o(71:80,:);v_o(91:100,:)];
vie = [v_ie(71:80,:);v_ie(91:100,:)];
voe = [v_oe(71:80,:);v_oe(91:100,:)];
vu = [v_u(71:80,:);v_u(91:100,:)];
figure();
plot(mean(ve),'LineWidth', 3);
hold on
plot(mean(veu),'LineWidth', 3);
hold on
plot(mean(vo),'LineWidth', 3);
hold on
plot(mean(vie),'LineWidth', 3);
hold on
plot(mean(voe),'LineWidth', 3);
hold on
plot(mean(vu),'LineWidth', 3);
xlabel('Frequency (Hz)')
%xline(1000,'-','Speech Onset', 'LineWidth', 2,'LabelOrientation','horizontal','Color','black');

ylabel('Power')
title('Average PSD for ctx lh G temporal middle');
legend('/e/','/eu/','/o/','/ie/','/oe/','/u/');



%% ctx_lh_G_and_S_cingul-Ant : 13,14,18,19,20
ve = [v_e(121:140,:);v_e(171:200,:)];
veu = [v_eu(121:140,:);v_eu(171:200,:)];
vo = [v_o(121:140,:);v_o(171:200,:)];
vie = [v_ie(121:140,:);v_ie(171:200,:)];
voe = [v_oe(121:140,:);v_oe(171:200,:)];
vu = [v_u(121:140,:);v_u(171:200,:)];
figure();
plot(mean(ve),'LineWidth', 3);
hold on
plot(mean(veu),'LineWidth', 3);
hold on
plot(mean(vo),'LineWidth', 3);
hold on
plot(mean(vie),'LineWidth', 3);
hold on
plot(mean(voe),'LineWidth', 3);
hold on
plot(mean(vu),'LineWidth', 3);
xlabel('Frequency (Hz)')
%xline(1000,'-','Speech Onset', 'LineWidth', 2,'LabelOrientation','horizontal','Color','black');

ylabel('Power')
title('Average PSD for ctx lh G and S cingul-Ant');
legend('/e/','/eu/','/o/','/ie/','/oe/','/u/');



%% ctx_lh_G_front_middle : 24,36
ve = [v_e(231:240,:);v_e(351:360,:)];
veu = [v_eu(231:240,:);v_eu(351:360,:)];
vo = [v_o(231:240,:);v_o(351:360,:)];
vie = [v_ie(231:240,:);v_ie(351:360,:)];
voe = [v_oe(231:240,:);v_oe(351:360,:)];
vu = [v_u(231:240,:);v_u(351:360,:)];
figure();
plot(mean(ve),'LineWidth', 3);
hold on
plot(mean(veu),'LineWidth', 3);
hold on
plot(mean(vo),'LineWidth', 3);
hold on
plot(mean(vie),'LineWidth', 3);
hold on
plot(mean(voe),'LineWidth', 3);
hold on
plot(mean(vu),'LineWidth', 3);
xlabel('Frequency (Hz)')
ylabel('Power')
title('Average PSD for ctx lh G front middle');
legend('/e/','/eu/','/o/','/ie/','/oe/','/u/');
%xline(1000,'-','Speech Onset', 'LineWidth', 2,'LabelOrientation','horizontal','Color','black');


%% ctx_lh_G_insular_short : 27,28
ve = [v_e(261:280,:)];
veu = [v_eu(261:280,:)];
vo = [v_o(261:280,:)];
vie = [v_ie(261:280,:)];
voe = [v_oe(261:280,:)];
vu = [v_u(261:280,:)];
figure();
plot(mean(ve)/fs1,'LineWidth', 3);
hold on
plot(mean(veu)/fs1,'LineWidth', 3);
hold on
plot(mean(vo)/fs1,'LineWidth', 3);
hold on
plot(mean(vie)/fs1,'LineWidth', 3);
hold on
plot(mean(voe)/fs1,'LineWidth', 3);
hold on
plot(mean(vu)/fs1,'LineWidth', 3);
xlabel('Time (ms)')
%xline(1000,'-','Speech Onset', 'LineWidth', 2,'LabelOrientation','horizontal','Color','black');

ylabel('Z-score')
title('Average Z-score of PSD of HG band for ctx lh G insular short');
legend('/e/','/eu/','/o/','/ie/','/oe/','/u/');



%ctx_rh_G_oc-temp_med-Parahip : 37
ve = [v_e(361:370,:)];
veu = [v_eu(361:370,:)];
vo = [v_o(361:370,:)];
vie = [v_ie(361:370,:)];
voe = [v_oe(361:370,:)];
vu = [v_u(361:370,:)];
figure();
plot(mean(ve)/fs1,'LineWidth', 3);
hold on
plot(mean(veu)/fs1,'LineWidth', 3);
hold on
plot(mean(vo)/fs1,'LineWidth', 3);
hold on
plot(mean(vie)/fs1,'LineWidth', 3);
hold on
plot(mean(voe)/fs1,'LineWidth', 3);
hold on
plot(mean(vu)/fs1,'LineWidth', 3);
xlabel('Time (ms)')
ylabel('Z-score')
%xline(1000,'-','Speech Onset', 'LineWidth', 2,'LabelOrientation','horizontal','Color','black');

title('Average Z-score of PSD of HG band for ctx rh G oc-temp med-Parahip');
legend('/e/','/eu/','/o/','/ie/','/oe/','/u/');


%ctx_rh_G_temporal_middle : 41,42,44

ve = [v_e(401:420,:);v_e(431:440,:)];
veu = [v_eu(401:420,:);v_eu(431:440,:)];
vo = [v_o(401:420,:);v_o(431:440,:)];
vie = [v_ie(401:420,:);v_ie(431:440,:)];
voe = [v_oe(401:420,:);v_oe(431:440,:)];
vu = [v_u(401:420,:);v_u(431:440,:)];
figure();
plot(mean(ve)/fs1,'LineWidth', 3);
hold on
plot(mean(veu)/fs1,'LineWidth', 3);
hold on
plot(mean(vo)/fs1,'LineWidth', 3);
hold on
plot(mean(vie)/fs1,'LineWidth', 3);
hold on
plot(mean(voe)/fs1,'LineWidth', 3);
hold on
plot(mean(vu)/fs1,'LineWidth', 3);
xlabel('Time (ms)')
ylabel('Z-score')
%xline(1000,'-','Speech Onset', 'LineWidth', 2,'LabelOrientation','horizontal','Color','black');

title('Average Z-score of PSD of HG band for ctx rh G temporal middle ');
legend('/e/','/eu/','/o/','/ie/','/oe/','/u/');


%ctx_rh_G_and_S_cingul-Ant : 47,48,68,69

ve = [v_e(461:480,:);v_e(671:690,:)];
veu = [v_eu(461:480,:);v_eu(671:690,:)];
vo = [v_o(461:480,:);v_o(671:690,:)];
vie = [v_ie(461:480,:);v_ie(671:690,:)];
voe = [v_oe(461:480,:);v_oe(671:690,:)];
vu = [v_u(461:480,:);v_u(671:690,:)];
figure();
plot(mean(ve)/fs1,'LineWidth', 3);
hold on
plot(mean(veu)/fs1,'LineWidth', 3);
hold on
plot(mean(vo)/fs1,'LineWidth', 3);
hold on
plot(mean(vie)/fs1,'LineWidth', 3);
hold on
plot(mean(voe)/fs1,'LineWidth', 3);
hold on
plot(mean(vu)/fs1,'LineWidth', 3);
xlabel('Time (ms)')
ylabel('Z-score')
%xline(1000,'-','Speech Onset', 'LineWidth', 2,'LabelOrientation','horizontal','Color','black');

title('Average Z-score of PSD of HG band for ctx rh G and S cingul-Ant');
legend('/e/','/eu/','/o/','/ie/','/oe/','/u/');

%ctx_rh_S_orbital_lateral : 55,
ve = [v_e(541:550,:)];
veu = [v_eu(541:550,:)];
vo = [v_o(541:550,:)];
vie = [v_ie(541:550,:)];
voe = [v_oe(541:550,:)];
vu = [v_u(541:550,:)];
figure();
plot(mean(ve)/fs1,'LineWidth', 3);
hold on
plot(mean(veu)/fs1,'LineWidth', 3);
hold on
plot(mean(vo)/fs1,'LineWidth', 3);
hold on
plot(mean(vie)/fs1,'LineWidth', 3);
hold on
plot(mean(voe)/fs1,'LineWidth', 3);
hold on
plot(mean(vu)/fs1,'LineWidth', 3);
xlabel('Time (ms)')
ylabel('Z-score')
%xline(1000,'-','Speech Onset', 'LineWidth', 2,'LabelOrientation','horizontal','Color','black');

title('Average Z-score of PSD of HG band for ctx rh S orbital lateral');
legend('/e/','/eu/','/o/','/ie/','/oe/','/u/');

%ctx_rh_G_front_inf-Orbital : 57

ve = [v_e(561:570,:)];
veu = [v_eu(561:570,:)];
vo = [v_o(561:570,:)];
vie = [v_ie(561:570,:)];
voe = [v_oe(561:570,:)];
vu = [v_u(561:570,:)];
figure();
plot(mean(ve)/fs1,'LineWidth', 3);
hold on
plot(mean(veu)/fs1,'LineWidth', 3);
hold on
plot(mean(vo)/fs1,'LineWidth', 3);
hold on
plot(mean(vie)/fs1,'LineWidth', 3);
hold on
plot(mean(voe)/fs1,'LineWidth', 3);
hold on
plot(mean(vu)/fs1,'LineWidth', 3);
xlabel('Time (ms)')
ylabel('Z-score')
%xline(1000,'-','Speech Onset', 'LineWidth', 2,'LabelOrientation','horizontal','Color','black');

title('Average Z-score of PSD of HG band for ctx rh G front inf-Orbital');
legend('/e/','/eu/','/o/','/ie/','/oe/','/u/');

%Right hippocampus : 58,59,60,61,62

ve = [v_e(571:620,:)];
veu = [v_eu(571:620,:)];
vo = [v_o(571:620,:)];
vie = [v_ie(571:620,:)];
voe = [v_oe(571:620,:)];
vu = [v_u(571:620,:)];
figure();
plot(mean(ve)/fs1,'LineWidth', 3);
hold on
plot(mean(veu)/fs1,'LineWidth', 3);
hold on
plot(mean(vo)/fs1,'LineWidth', 3);
hold on
plot(mean(vie)/fs1,'LineWidth', 3);
hold on
plot(mean(voe)/fs1,'LineWidth', 3);
hold on
plot(mean(vu)/fs1,'LineWidth', 3);
xlabel('Time (ms)')
ylabel('Z-score')
%xline(1000,'-','Speech Onset', 'LineWidth', 2,'LabelOrientation','horizontal','Color','black');

title('Average Z-score of PSD of HG band for right hippocampus');
legend('/e/','/eu/','/o/','/ie/','/oe/','/u/');

%ctx_rh_G_temporal_inf : 67,
ve = [v_e(661:670,:)];
veu = [v_eu(661:670,:)];
vo = [v_o(661:670,:)];
vie = [v_ie(661:670,:)];
voe = [v_oe(661:670,:)];
vu = [v_u(661:670,:)];
figure();
plot(mean(ve)/fs1,'LineWidth', 3);
hold on
plot(mean(veu)/fs1,'LineWidth', 3);
hold on
plot(mean(vo)/fs1,'LineWidth', 3);
hold on
plot(mean(vie)/fs1,'LineWidth', 3);
hold on
plot(mean(voe)/fs1,'LineWidth', 3);
hold on
plot(mean(vu)/fs1,'LineWidth', 3);
xlabel('Time (ms)')
ylabel('Z-score')
%xline(1000,'-','Speech Onset', 'LineWidth', 2,'LabelOrientation','horizontal','Color','black');

title('Average Z-score of PSD of HG band for ctx rh G temporal inf ');
legend('/e/','/eu/','/o/','/ie/','/oe/','/u/');


%ctx_rh_S_front_middle : 70,88
ve = [v_e(691:700,:);v_e(871:880,:)];
veu = [v_eu(691:700,:);v_eu(871:880,:)];
vo = [v_o(691:700,:);v_o(871:880,:)];
vie = [v_ie(691:700,:);v_ie(871:880,:)];
voe = [v_oe(691:700,:);v_oe(871:880,:)];
vu = [v_u(691:700,:);v_u(871:880,:)];
figure();
plot(mean(ve)/fs1,'LineWidth', 3);
hold on
plot(mean(veu)/fs1,'LineWidth', 3);
hold on
plot(mean(vo)/fs1,'LineWidth', 3);
hold on
plot(mean(vie)/fs1,'LineWidth', 3);
hold on
plot(mean(voe)/fs1,'LineWidth', 3);
hold on
plot(mean(vu)/fs1,'LineWidth', 3);
xlabel('Time (ms)')
ylabel('Z-score')
%xline(1000,'-','Speech Onset', 'LineWidth', 2,'LabelOrientation','horizontal','Color','black');

title('Average Z-score of PSD of HG band for ctx rh S front middle  ');
legend('/e/','/eu/','/o/','/ie/','/oe/','/u/');


%ctx_rh_G_front_middle : 72,
ve = [v_e(711:720,:)];
veu = [v_eu(711:720,:)];
vo = [v_o(711:720,:)];
vie = [v_ie(711:720,:)];
voe = [v_oe(711:720,:)];
vu = [v_u(711:720,:)];
figure();
plot(mean(ve)/fs1,'LineWidth', 3);
hold on
plot(mean(veu)/fs1,'LineWidth', 3);
hold on
plot(mean(vo)/fs1,'LineWidth', 3);
hold on
plot(mean(vie)/fs1,'LineWidth', 3);
hold on
plot(mean(voe)/fs1,'LineWidth', 3);
hold on
plot(mean(vu)/fs1,'LineWidth', 3);
xlabel('Time (ms)')
ylabel('Z-score')
xline(1000,'-','Speech Onset', 'LineWidth', 2,'LabelOrientation','horizontal','Color','black');

title('Average Z-score of PSD of HG band for ctx rh G front middle ');
legend('/e/','/eu/','/o/','/ie/','/oe/','/u/');

%ctx_rh_S_front_inf : 73,74
ve = [v_e(721:740,:)];
veu = [v_eu(721:740,:)];
vo = [v_o(721:740,:)];
vie = [v_ie(721:740,:)];
voe = [v_oe(721:740,:)];
vu = [v_u(721:740,:)];
figure();
plot(mean(ve)/fs1,'LineWidth', 3);
hold on
plot(mean(veu)/fs1,'LineWidth', 3);
hold on
plot(mean(vo)/fs1,'LineWidth', 3);
hold on
plot(mean(vie)/fs1,'LineWidth', 3);
hold on
plot(mean(voe)/fs1,'LineWidth', 3);
hold on
plot(mean(vu)/fs1,'LineWidth', 3);
xlabel('Time (ms)')
ylabel('Z-score')
xline(1000,'-','Speech Onset', 'LineWidth', 2,'LabelOrientation','horizontal','Color','black');

title('Average Z-score of PSD of HG band for ctx rh S front inf  ');
legend('/e/','/eu/','/o/','/ie/','/oe/','/u/');

%ctx_rh_S_orbital-H_Shaped : 78
ve = [v_e(771:780,:)];
veu = [v_eu(771:780,:)];
vo = [v_o(771:780,:)];
vie = [v_ie(771:780,:)];
voe = [v_oe(771:780,:)];
vu = [v_u(771:780,:)];
figure();
plot(mean(ve)/fs1,'LineWidth', 3);
hold on
plot(mean(veu)/fs1,'LineWidth', 3);
hold on
plot(mean(vo)/fs1,'LineWidth', 3);
hold on
plot(mean(vie)/fs1,'LineWidth', 3);
hold on
plot(mean(voe)/fs1,'LineWidth', 3);
hold on
plot(mean(vu)/fs1,'LineWidth', 3);
xlabel('Time (ms)')
ylabel('Z-score')
xline(1000,'-','Speech Onset', 'LineWidth', 2,'LabelOrientation','horizontal','Color','black');

title('Average Z-score of PSD of HG band for ctx rh S orbital-H Shaped');
legend('/e/','/eu/','/o/','/ie/','/oe/','/u/');


%ctx_rh_G_orbital : 82,103,104
ve = [v_e(811:820,:);v_e(1021:1040,:)];
veu = [v_eu(811:820,:);v_eu(1021:1040,:)];
vo = [v_o(811:820,:);v_o(1021:1040,:)];
vie = [v_ie(811:820,:);v_ie(1021:1040,:)];
voe = [v_oe(811:820,:);v_oe(1021:1040,:)];
vu = [v_u(811:820,:);v_u(1021:1040,:)];
figure();
plot(mean(ve)/fs1,'LineWidth', 3);
hold on
plot(mean(veu)/fs1,'LineWidth', 3);
hold on
plot(mean(vo)/fs1,'LineWidth', 3);
hold on
plot(mean(vie)/fs1,'LineWidth', 3);
hold on
plot(mean(voe)/fs1,'LineWidth', 3);
hold on
plot(mean(vu)/fs1,'LineWidth', 3);
xlabel('Time (ms)')
ylabel('Z-score')
xline(1000,'-','Speech Onset', 'LineWidth', 2,'LabelOrientation','horizontal','Color','black');

title('Average Z-score of PSD of HG band for ctx rh G orbital  ');
legend('/e/','/eu/','/o/','/ie/','/oe/','/u/');



%ctx_rh_S_orbital_med-olfact : 83,
ve = [v_e(821:830,:)];
veu = [v_eu(821:830,:)];
vo = [v_o(821:830,:)];
vie = [v_ie(821:830,:)];
voe = [v_oe(821:830,:)];
vu = [v_u(821:830,:)];
figure();
plot(mean(ve)/fs1,'LineWidth', 3);
hold on
plot(mean(veu)/fs1,'LineWidth', 3);
hold on
plot(mean(vo)/fs1,'LineWidth', 3);
hold on
plot(mean(vie)/fs1,'LineWidth', 3);
hold on
plot(mean(voe)/fs1,'LineWidth', 3);
hold on
plot(mean(vu)/fs1,'LineWidth', 3);
xlabel('Time (ms)')
ylabel('Z-score')
xline(1000,'-','Speech Onset', 'LineWidth', 2,'LabelOrientation','horizontal','Color','black');

title('Average Z-score of PSD of HG band for ctx rh S orbital med-olfact ');
legend('/e/','/eu/','/o/','/ie/','/oe/','/u/');

%%
%ctx_rh_S_front_sup : 89
ve = [v_e(881:890,:)];
veu = [v_eu(881:890,:)];
vo = [v_o(881:890,:)];
vie = [v_ie(881:890,:)];
voe = [v_oe(881:890,:)];
vu = [v_u(881:890,:)];
figure();
plot(mean(ve)/fs1,'LineWidth', 3);
hold on
plot(mean(veu)/fs1,'LineWidth', 3);
hold on
plot(mean(vo)/fs1,'LineWidth', 3);
hold on
plot(mean(vie)/fs1,'LineWidth', 3);
hold on
plot(mean(voe)/fs1,'LineWidth', 3);
hold on
plot(mean(vu)/fs1,'LineWidth', 3);
xlabel('Time (ms)')
ylabel('Z-score')
xline(1000,'-','Speech Onset', 'LineWidth', 2,'LabelOrientation','horizontal','Color','black');

title('Average Z-score of PSD of HG band for ctx rh S front sup  ');
legend('/e/','/eu/','/o/','/ie/','/oe/','/u/');


%ctx_rh_G_front_sup : 90,91,92,109
ve = [v_e(891:920,:)];
veu = [v_eu(891:920,:)];
vo = [v_o(891:920,:)];
vie = [v_ie(891:920,:)];
voe = [v_oe(891:920,:)];
vu = [v_u(891:920,:)];

%ctx_rh_G_and_S_frontomargin : 102,

ve = [v_e(1011:1020,:)];
veu = [v_eu(1011:1020,:)];
vo = [v_o(1011:1020,:)];
vie = [v_ie(1011:1020,:)];
voe = [v_oe(1011:1020,:)];
vu = [v_u(1011:1020,:)];
figure();
plot(mean(ve)/fs1,'LineWidth', 3);
hold on
plot(mean(veu)/fs1,'LineWidth', 3);
hold on
plot(mean(vo)/fs1,'LineWidth', 3);
hold on
plot(mean(vie)/fs1,'LineWidth', 3);
hold on
plot(mean(voe)/fs1,'LineWidth', 3);
hold on
plot(mean(vu)/fs1,'LineWidth', 3);
xlabel('Time (ms)')
ylabel('Z-score')
xline(1000,'-','Speech Onset', 'LineWidth', 2,'LabelOrientation','horizontal','Color','black');

title('Average Z-score of PSD of HG band for ctx rh G and S frontomargin  ');
legend('/e/','/eu/','/o/','/ie/','/oe/','/u/');


%ctx_rh_G_Ins_lg_and_S_cent_ins : 111,112
%ctx_rh_S_circular_insula_sup : 115,116
%ctx_rh_G_insular_short : 117,118
%ctx_rh_G_and_S_transv_frontopol : 120
%ctx_rh_S_circular_insula_inf : 121,122,123,
%ctx_rh_Lat_Fis-post : 124
%ctx_rh_G_pariet_inf-Supramar : 125
% ctx_rh_S_postcentral : 128




%% PCA 

featureMatrix_e = v_e/fs1; % Normalize the feature matrix
featureMatrix_o = v_o/fs1; % Normalize the feature matrix
featureMatrix_ie = v_ie/fs1; % Normalize the feature matrix
featureMatrix_oe = v_oe/fs1; % Normalize the feature matrix
featureMatrix_u = v_u/fs1; % Normalize the feature matrix
featureMatrix_eu = v_eu/fs1; % Normalize the feature matrix

[COEFFe, SCOREe, LATENTe, TSQUAREDe, EXPLAINEDe] = pca(featureMatrix_e); % Perform PCA analysis
[COEFFo, SCOREo, LATENTo, TSQUAREDo, EXPLAINEDo] = pca(featureMatrix_o); % Perform PCA analysis
[COEFFie, SCOREie, LATENTie, TSQUAREDie, EXPLAINEDie] = pca(featureMatrix_ie); % Perform PCA analysis
[COEFFoe, SCOREoe, LATENToe, TSQUAREDoe, EXPLAINEDoe] = pca(featureMatrix_oe); % Perform PCA analysis
[COEFFu, SCOREu, LATENTu, TSQUAREDu, EXPLAINEDu] = pca(featureMatrix_u); % Perform PCA analysis
[COEFFeu, SCOREeu, LATENTeu, TSQUAREDeu, EXPLAINEDeu] = pca(featureMatrix_eu); % Perform PCA analysis

sw = scatter3(SCOREe(:,1),SCOREe(:,2),SCOREe(:,3),'filled');
sw.MarkerFaceColor = 'blue';
hold on;
sw = scatter3(SCOREo(:,1),SCOREo(:,2),SCOREo(:,3),'filled');
sw.MarkerFaceColor = 'red';
hold on;
sw = scatter3(SCOREie(:,1),SCOREie(:,2),SCOREie(:,3),'filled');
sw.MarkerFaceColor = 'green';
hold on;
sw = scatter3(SCOREoe(:,1),SCOREoe(:,2),SCOREoe(:,3),'filled');
sw.MarkerFaceColor = 'cyan';
hold on;
sw = scatter3(SCOREu(:,1),SCOREu(:,2),SCOREu(:,3),'filled');
sw.MarkerFaceColor = 'magenta';
hold on;
sw = scatter3(SCOREeu(:,1),SCOREeu(:,2),SCOREeu(:,3),'filled');
sw.MarkerFaceColor = 'black';
title('PCA Analysis')
xlabel('PC1')
ylabel('PC2')
zlabel('PC3')
 

%%
% No of dimensions to keep
numberOfDimensions = 5;

[COEFF, SCORE, LATENT, TSQUARED, EXPLAINED] = pca(featureMatrix); % Perform PCA analysis

reducedDimension = COEFF(:,1:numberOfDimensions);
reducedFeatureMatrix = featureMatrix * reducedDimension;

figure('Name','EigenVectors','NumberTitle','off');
bar(COEFF);

% plotpca={'f1','f2','f3','f4','f5'};
% for p=1:5
%     figure('Name',plotpca{p},'NumberTitle','off');
% 
%     score_length = size(SCORE, 1);
%     tx_vect= SCORE(1:score_length, p);
%     scatter(1:score_length,tx_vect,'r')
%     xlabel('Timestamp in order') 
%     ylabel("Feature Values("+ plotpca{p}+")")
% end

scatter3(SCORE(:,1),SCORE(:,2),SCORE(:,3))
hold off;



%% Heatmap plotting of zscore
for i = 501:10:610
 v = [v_e(i:i+9,:);v_eu(i:i+9,:);v_ie(i:i+9,:);v_o(i:i+9,:);v_oe(i:i+9,:);v_u(i:i+9,:)]/fs1;
figure();
imagesc(v)
colormap default
colorbar
title("Z-score across all vowels for one channel")
yline(10,'-', 'LineWidth', 4,'Color','white');
yline(20,'-', 'LineWidth', 4,'Color','white');
yline(30,'-', 'LineWidth', 4,'Color','white');
yline(40,'-', 'LineWidth', 4,'Color','white');
yline(50,'-', 'LineWidth', 4,'Color','white');
xline(1000,'-','Speech Onset', 'LineWidth', 2,'LabelOrientation','horizontal','Color','white');
xlabel("Time (ms)")
ylabel("Trial")
clim([-1 11])
end
% for i=11:10:50
% 
% vowels = [v_e(i:i+9,:);v_eu(i:i+9,:);v_ie(i:i+9,:);v_o(i:i+9,:);v_oe(i:i+9,:);v_u(i:i+9,:)];
% 
% heatmap(vowels)
% title("Z-score for all vowels for one channel")
% end

%%
f=0;postspeech=[];
for i =1:1:length(v_e)

[peakValues, indexes] = findpeaks(v_e(i,:));
[maxz,id] = max(peakValues); 
    if(indexes(id)>(idx(i,1)/fs1)+0.02*fs1)
       postspeech(f,:) = v_e(i,:);
       index(k,i) = 1;
       f=f+1;
    elseif(indexes(id)<(idx(i,1)/fs1)-0.02*fs1)
              prespeech(f1,:) = zmean;
              stderrorpre (f1,:) =  std(zmean)/sqrt(size(idx,1));
              index(k,i)=2;
             f1=f1+1;
         else
             simspeech(f2,:) = zmean;
             stderrorsim (f2,:) =  std(zmean)/sqrt(size(idx,1));
             index(k,i)=3;
             f2=f2+1;
        end 
end
        

%% Single trial View

F1_lim = [0 1000];
F2_lim = [300 2200];
formants_o = [];formants_eu=[];formants_u=[];formants_A=[];formants_a=[];
formants_oe=[];formants_ie=[];formants_e=[];formants_ae=[];

% Get the handle of figure(n).
% figure(1);
% fig1_comps.fig = gcf;
% hold on

tto =[]; ttoe=[]; tteu=[];ttie=[];ttu=[];
for trial=1:size(F1,2)
    if(F1(trial)<400 && F1(trial) >300 && F2(trial)>800 &&F2(trial)<1000) %o
     s = scatter(F2(trial), F1(trial), 'filled'); 
     s.MarkerFaceColor = 'red';%[0 .5 .7];
     f = [F1(trial);F2(trial)];
     formants_o = [formants_o f];
     tto = [tto tt(trial)];
     hold on
    end
    if(F1(trial)<310 && F1(trial) >200 && F2(trial)>780 &&F2(trial)<950)%eu
     s1 = scatter(F2(trial), F1(trial), 'filled'); 
     s1.MarkerFaceColor = 'blue';
     f = [F1(trial);F2(trial)];
     formants_eu = [formants_eu f];
     tteu = [tteu tt(trial)];
     hold on
    end
    if(F1(trial)<300 && F1(trial) >200 && F2(trial)>600 &&F2(trial)<780)%u
     s2 = scatter(F2(trial), F1(trial), 'filled'); 
     s2.MarkerFaceColor = [0 .7 .4];
     f = [F1(trial);F2(trial)];
     formants_u = [formants_u f];
     ttu = [ttu tt(trial)];
     hold on
    end
    if(F1(trial)<800 && F1(trial) >700 && F2(trial)>780 &&F2(trial)<1000)%A
    w3 = scatter(F2(trial),F1(trial),'filled');
    w3.MarkerFaceColor = [0 .7 .7];
    f = [F1(trial);F2(trial)];
     formants_A = [formants_A f];
     hold on
    end
    if(F1(trial)<900 && F1(trial) >800 && F2(trial)>1000 &&F2(trial)<1300)%NO a
        s4 = scatter(F2(trial),F1(trial), 'filled');
        s4.MarkerFaceColor ='#D95319';
        f = [F1(trial);F2(trial)];
     formants_a = [formants_a f];

        hold on
    end
    if(F1(trial)<850 && F1(trial) >750 && F2(trial)>1550 &&F2(trial)<1750)%NO ae
        s5 = scatter(F2(trial),F1(trial),'filled');
        s5.MarkerFaceColor = [.7 .7 .7]; 
        f = [F1(trial);F2(trial)];
     formants_ae = [formants_ae f];
        hold on
    end
     if(F1(trial)<400 && F1(trial) >300 && F2(trial)>1450 &&F2(trial)<1800)%oe
     s = scatter(F2(trial), F1(trial), 'filled'); 
     s.MarkerFaceColor = [.7 .7 0];
     f = [F1(trial);F2(trial)];
     formants_oe = [formants_oe f];
     ttoe = [ttoe tt(trial)];
     
     hold on
     end
     if(F1(trial)<320 && F1(trial) >220 && F2(trial)>1650 &&F2(trial)<2000)%ie
     s = scatter(F2(trial), F1(trial), 'filled'); 
     s.MarkerFaceColor = [0.9 .3 0.7];
     f = [F1(trial);F2(trial)];
     formants_ie = [formants_ie f];
     ttie = [ttie tt(trial)];
     hold on
     end
     if(F1(trial)<500 && F1(trial) >350 && F2(trial)>2000 &&F2(trial)<2200)%ee
     s = scatter(F2(trial), F1(trial), 'filled'); 
     s.MarkerFaceColor = 'black';
     f = [F1(trial);F2(trial)];
     formants_e = [formants_e f];
     hold on
    end
end
   
    % grid('on')
    xlabel('F2')
    ylabel('F1')
    %  xlim(F2_lim);
    % ylim(F1_lim);
    %title('Formant')
    STANDARDIZE_FIGURE(fig1_comps);
    SAVE_MY_FIGURE(fig1_comps, '/Users/alexandramikhael/Desktop/Figures/Formants.png', 'big');
    % 


    %% ML comparaison figure

    F1_lim = [0 600];
F2_lim = [300 2400];
formants_o = [];formants_eu=[];formants_u=[];formants_A=[];formants_a=[];
formants_oe=[];formants_ie=[];formants_e=[];formants_ae=[];

figure();
for trial=1:93
     s = scatter( f_o(trial,2), f_o(trial,1), 'filled'); 
     s.MarkerFaceColor = [0 .5 .7];
     hold on
    end
   for trial=1:size( f_eu,1)
     s1 = scatter( f_eu(trial,2), f_eu(trial,1), 'filled'); 
     s1.MarkerFaceColor = 'blue';

     hold on
    end
    for trial=1:size( f_ie,1)
     s1 = scatter( f_ie(trial,2), f_ie(trial,1), 'filled'); 
     s1.MarkerFaceColor = 'green';

     hold on
    end
 
      for trial=1:size( f_e,1)
     s1 = scatter( f_e(trial,2), f_e(trial,1), 'filled'); 
     s1.MarkerFaceColor = [0.6 .1 0];

     hold on
    end
     
     for trial=1:size( f_oe,1)
     s1 = scatter( f_oe(trial,2), f_oe(trial,1), 'filled'); 
     s1.MarkerFaceColor = [0.9 .3 0];

     hold on
    end
     for trial=1:size( f_u,1)
     s1 = scatter( f_u(trial,2), f_u(trial,1), 'filled'); 
     s1.MarkerFaceColor = 'black';

     hold on
    end
    


% %      hold on
%      sw = scatter(F2d, F1d, 'filled'); 
%      sw.MarkerFaceColor = 'blue';
   
    grid('on')
    xlabel('F2')
    ylabel('F1')
     xlim(F2_lim);
    ylim(F1_lim);
    title('Formant')


    %% z-score plots

    for i=11:10:50
    % get the 60 trials for one channel
    vowels = [v_e(i:i+9,:);v_eu(i:i+9,:);v_ie(i:i+9,:);v_o(i:i+9,:);v_oe(i:i+9,:);v_u(i:i+9,:)];

    % get the mean and std
    vowel_avg = mean(vowels);
    vowel_std = std(vowels);
    vowel_stderror = vowel_std / sqrt(60);


    figure()
    plot(vowel_avg, 'LineWidth', 3, "Color", 'b');
    hold on
    plot(vowel_avg + vowel_stderror, 'LineWidth', 1,"Color", 'b');
    hold on
    plot(vowel_avg - vowel_stderror, 'LineWidth', 1,"Color", 'b');
    xline(1000,'-','Speech Onset', 'LineWidth', 2,'LabelOrientation','horizontal');
    xline(1512,'-','Speech Offset','LineWidth', 2,'LabelOrientation','horizontal');
    title('Avg and std error for all vowels for one channel')
    xlabel('Time (ms)')
    ylabel('Z-score')

    %  % get the 60 trials for one channel
    % vowelgourp1 = [v_eu(i:i+9,:);v_o(i:i+9,:);v_u(i:i+9,:)];
    % vowelgourp2 = [v_oe(i:i+9,:);v_ie(i:i+9,:);v_e(i:i+9,:)];
    % 
    % % get the mean and std
    % vowel_avg1 = mean(vowelgourp1);
    % vowel_std1 = std(vowelgourp1);
    % vowel_stderror1 = vowel_std1 / sqrt(30);
    % 
    % vowel_avg2 = mean(vowelgourp2);
    % vowel_std2 = std(vowelgourp2);
    % vowel_stderror2 = vowel_std2 / sqrt(30);
    % 
    % figure()
    % plot(vowel_avg1, 'LineWidth', 3, "Color", 'b');
    % hold on
    % plot(vowel_avg1 + vowel_stderror1, 'LineWidth', 1,"Color", 'b');
    % hold on
    % plot(vowel_avg1 - vowel_stderror1, 'LineWidth', 1,"Color", 'b');
    % xline(1000,'-','Speech Onset','LabelOrientation','horizontal');
    % xline(1512,'-','Speech Offset','LabelOrientation','horizontal');
    % title('Avg and std error for vowel group 1 for one channel')
    % xlabel('Time (ms)')
    % ylabel('Z-score')
    % 
    % figure()
    % plot(vowel_avg2, 'LineWidth', 3, "Color", 'b');
    % hold on
    % plot(vowel_avg2 + vowel_stderror2, 'LineWidth', 1,"Color", 'b');
    % hold on
    % plot(vowel_avg2 - vowel_stderror2, 'LineWidth', 1,"Color", 'b');
    % xline(1000,'-','Speech Onset','LabelOrientation','horizontal');
    % xline(1512,'-','Speech Offset','LabelOrientation','horizontal');
    % title('Avg and std error for vowel group 2 for one channel')
    % xlabel('Time (ms)')
    % ylabel('Z-score')
    end
   
 %% Bootstrap zscore plots
vowels=[];
  % all trials all vowels for one channel
  vowels = [v_ehilbert(11:19,:);v_euhilbert(11:19,:);v_iehilbert(11:19,:);v_ohilbert(11:19,:);v_oehilbert(11:19,:);v_uhilbert(11:19,:)];
  % random shuffle of the vowels
  for i=1:1:1000
  vowels = vowels(randperm(size(vowels,1)),:);
  end

  v_e1 = vowels(1:size(v_ehilbert(11:19,:),1),:);
  s1=size(v_ehilbert(11:19,:),1)+size(v_euhilbert(11:19,:),1);
  v_eu1 = vowels(size(v_ehilbert(11:19,:),1)+1:s1,:);
  s2=s1+size(v_iehilbert(11:19,:),1);
  v_ie1 = vowels(s1+1:s2,:);
 s3 = s2+size(v_ohilbert(11:19,:),1);
  v_o1 = vowels(s2+1:s3,:);
  s4=s3+size(v_oehilbert(11:19,:),1);
  v_oe1 = vowels(s3+1:s4,:);
s5=s4+size(v_uhilbert(11:19,:),1);
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
  title("Bootstrapping Analysis")
  xlabel("Time (s)")
  ylabel("Amplitude")

   figure();
  plot(mean(v_ehilbert(11:19,:)), 'Color', 'cyan', 'LineWidth',2);
  hold on
  plot(mean(v_euhilbert(11:19,:)), 'Color', 'green', 'LineWidth',2);
  hold on
  plot(mean(v_iehilbert(11:19,:)), 'Color', 'magenta', 'LineWidth',2);
  hold on
  plot(mean(v_ohilbert(11:19,:)), 'Color', 'red', 'LineWidth',2);
  hold on
  plot(mean(v_oehilbert(11:19,:)), 'Color', 'black', 'LineWidth',2);
  hold on
  plot(mean(v_uhilbert(11:19,:)), 'Color', 'blue', 'LineWidth',2);
  title("Analysis without Bootstrap")
  xlabel("Time (s)")
  ylabel("Amplitude")
  legend('e','eu','ie','o','oe','u');

%%
    figure();
     F1_lim = [250 800];
     F2_lim = [800 3000];
 
    s = scatter(freq2a_trial1, freq1a_trial1*2, 'filled'); 
    s.MarkerFaceColor = '#D95319';
    hold on
    sw = scatter(freq2a_trial2, freq1a_trial2*2, 'filled'); 
    sw.MarkerFaceColor = 'blue';
    hold on
    s1 = scatter(freq2a_trial3, freq1a_trial3*2.2, 'filled'); 
    s1.MarkerFaceColor = 'green';
    hold on
    sw1 = scatter(freq2e_trial1*1.45, freq1e_trial1, 'filled');
    sw1.MarkerFaceColor = '#D95319';
    hold on
    s11 = scatter(freq2e_trial2*1.5, freq1e_trial2, 'filled'); 
    s11.MarkerFaceColor = 'blue';
    hold on
    sw2 = scatter(freq2e_trial3*1.5, freq1e_trial3, 'filled');
    sw2.MarkerFaceColor = 'green';
%     hold on

    grid('on')
    xlabel('F2')
    ylabel('F1')
    xlim(F2_lim);
    ylim(F1_lim);
    title('Formant')


    %% Plot F1 vs Time

figure('name', 'Formant F1 trajectory')
tte = linspace(0,1,50);

sw1 = scatter(formants_o(1,100:149),tte, 'filled'); 
sw1.MarkerFaceColor = '#D95319';

hold on

tte = linspace(2,3,50);

sw1 = scatter(formants_u(1,50:99),tte, 'filled'); 
sw1.MarkerFaceColor = [0 .7 .4];

hold on

tte = linspace(5,6,50);

sw1 = scatter(formants_oe(1,50:99), tte,'filled'); 
sw1.MarkerFaceColor = [.7 .7 0];

hold on 

tte = linspace(7,8,50);

sw1 = scatter(formants_ie(1,50:99),tte, 'filled'); 
sw1.MarkerFaceColor =  [0.9 .3 0.7];

hold on

tte = linspace(9,10,50);

sw1 = scatter(formants_o(1,101:150),tte, 'filled'); 
sw1.MarkerFaceColor = '#D95319';

hold on

tte = linspace(11,12,50);

sw1 = scatter(formants_eu(1,50:99),tte, 'filled'); 
sw1.MarkerFaceColor = 'blue';

hold on

tte = linspace(13,14,50);

sw1 = scatter(formants_oe(1,101:150),tte, 'filled'); 
sw1.MarkerFaceColor = [.7 .7 0];
hold on



% xlabel('Time (s)')
% ylabel('F1')
title('Formant trajectory')



%% 7 Trials View

    figure();
    F1_lim = [250 800];
    F2_lim = [800 3000];
    s1 = scatter(F2_trial1_a, F1_trial1_a, 'filled');
    s1.MarkerFaceColor = '#D95319';
    hold on
    sw1 = scatter(F2_trial2_a,F1_trial2_a, 'filled');
          sw1.MarkerFaceColor = 'blue';
          hold on
%     sw = scatter(F2_trial3_a,F1_trial3_a, 'filled');
%           sw.MarkerFaceColor = 'green';
%           hold on
%     sw = scatter(F2_trial4_a,F1_trial4_a, 'filled');
%           sw.MarkerFaceColor = 'yellow';
%           hold on
    sw1 = scatter(F2_trial1_e,F1_trial1_e, 'filled');
          sw1.MarkerFaceColor = '#D95319';
          hold on
    sw1 = scatter(F2_trial2_e,F1_trial2_e, 'filled');
          sw1.MarkerFaceColor = 'blue';
%           hold on
%     sw = scatter(F2_trial3_e,F1_trial3_e, 'filled');
%           sw.MarkerFaceColor = 'green';
%           hold on;
%             sw = scatter(F2_trial4_e,F1_trial4_e, 'filled');
%           sw.MarkerFaceColor = 'yellow';
%           
%     s = scatter(F2_data1w, F1_data1w, 'filled');
%     s.MarkerFaceColor = 'blue';
%     hold on
%     sw = scatter(F2_data2w,F1_data2w, 'filled');
%           sw.MarkerFaceColor = 'blue';
%           hold on
%     sw = scatter(F2_data3w,F1_data3w, 'filled');
%           sw.MarkerFaceColor = 'blue';
%           hold on
%     sw = scatter(F2_data4w,F1_data4w, 'filled');
%           sw.MarkerFaceColor = 'blue';
%           hold on
%     sw = scatter(F2_data5w,F1_data5w, 'filled');
%           sw.MarkerFaceColor = 'blue';
%           hold on
%     sw = scatter(F2_data6w,F1_data6w, 'filled');
%           sw.MarkerFaceColor = 'blue';
%           hold on
%     sw = scatter(F2_data7w,F1_data7w, 'filled');
%           sw.MarkerFaceColor = 'blue';
    grid('on')
    xlabel('F2')
    ylim(F1_lim);
    xlim(F2_lim);
    ylabel('F1')
    title('Formant')

    %% Average Across Trials View

    F1avg = 0;F2avg = 0;F1avg2 = 0;F2avg2 = 0;F1avg3 = 0;F2avg3 = 0;F1avg4 = 0;
    F2avg4 = 0;F1avg5 = 0;F2avg5 = 0;F1avg6 = 0;F2avg6 = 0;F1avg7 = 0;F2avg7 = 0; 
    F1avgw = 0;F2avgw = 0;F1avg2w = 0;F2avg2w = 0;F1avg3w = 0;F2avg3w = 0;F1avg4w = 0;
    F2avg4w = 0;F1avg5w = 0;F2avg5w = 0;F1avg6w = 0;F2avg6w = 0;F1avg7w = 0;F2avg7w = 0;  
    
    
 for trial = 1:length(F1_data1_a1)
           F1avg = (F1avg + F1_data1_a1(trial))/2;
           F2avg = (F2avg + F2_data1_a1(trial))/2;
            F1avgw = (F1avgw + F1_data1_e1(trial))/2;
            F2avgw = (F2avgw + F2_data1_e1(trial))/2;
 end
  for trial = 1:length(F1_data1_a2)
           F1avg2 = (F1avg2 + F1_data1_a2(trial))/2;
           F2avg2 = (F2avg2 + F2_data1_a2(trial))/2;
            F1avg2w = (F1avg2w + F1_data1_e2(trial))/2;
            F2avg2w = (F2avg2w + F2_data1_e2(trial))/2;
  end
   for trial = 1:length(F1_data1_e3)
           F1avg3 = (F1avg3 + F1_data1_a3(trial))/2;
           F2avg3 = (F2avg3 + F2_data1_a3(trial))/2;
            F1avg3w = (F1avg3w + F1_data1_e3(trial))/2;
            F2avg3w = (F2avg3w + F2_data1_e3(trial))/2;
   end
    for trial = 1:length(F1_data1_a4)
           F1avg4 = (F1avg4 + F1_data1_a4(trial))/2;
           F2avg4 = (F2avg4 + F2_data1_a4(trial))/2;
            F1avg4w = (F1avg4w + F1_data1_e4(trial))/2;
            F2avg4w = (F2avg4w + F2_data1_e4(trial))/2;
    end
     for trial = 1:length(F1_data1_a5)
           F1avg5 = (F1avg5 + F1_data1_a5(trial))/2;
           F2avg5 = (F2avg5 + F2_data1_a5(trial))/2;
            F1avg5w = (F1avg5w + F1_data1_e5(trial))/2;
            F2avg5w = (F2avg5w + F2_data1_e5(trial))/2;
     end
     for trial = 1:length(F1_data1_a6)
           F1avg6 = (F1avg6 + F1_data1_a6(trial))/2;
           F2avg6 = (F2avg6 + F2_data1_a6(trial))/2;
            F1avg6w = (F1avg6w + F1_data1_e6(trial))/2;
            F2avg6w = (F2avg6w + F2_data1_e6(trial))/2;
     end
       for trial = 1:length(F1_data1_a)
           F1avg7 = (F1avg7 + F1_data1_a(trial))/2;
           F2avg7 = (F2avg7 + F2_data1_a(trial))/2;
            F1avg7w = (F1avg7w + F1_data1_e(trial))/2;
            F2avg7w = (F2avg7w + F2_data1_e(trial))/2;
       end
figure();
  s1 = scatter(F2avg, F1avg, 'filled');
    s1.MarkerFaceColor = '#D95319';
    hold on;
      s1 = scatter(F2avg2, F1avg2, 'filled');
    s1.MarkerFaceColor = '#D95319';
        hold on;
      s2 = scatter(F2avg3, F1avg3, 'filled');
    s2.MarkerFaceColor = '#D95319';
        hold on;

      s3 = scatter(F2avg4, F1avg4, 'filled');
    s3.MarkerFaceColor = '#D95319';
        hold on;

      s4= scatter(F2avg5, F1avg5, 'filled');
    s4.MarkerFaceColor = '#D95319';
        hold on;

      s5 = scatter(F2avg6, F1avg6, 'filled');
    s5.MarkerFaceColor = '#D95319';
        hold on;

      s6 = scatter(F2avg7, F1avg7, 'filled');
    s6.MarkerFaceColor = '#D95319';
      sw1 = scatter(F2avgw, F1avgw, 'filled');
    sw1.MarkerFaceColor = 'blue';
    hold on;
      s1w = scatter(F2avg2w, F1avg2w, 'filled');
    s1w.MarkerFaceColor = 'blue';
        hold on;
      s2w = scatter(F2avg3w, F1avg3w, 'filled');
    s2w.MarkerFaceColor = 'blue';
        hold on;

      s3w = scatter(F2avg4w, F1avg4w, 'filled');
    s3w.MarkerFaceColor = 'blue';
        hold on;

      s4w= scatter(F2avg5w, F1avg5w, 'filled');
    s4w.MarkerFaceColor = 'blue';
        hold on;

      s5w = scatter(F2avg6w, F1avg6w, 'filled');
    s5w.MarkerFaceColor = 'blue';
        hold on;

      s6w = scatter(F2avg7w, F1avg7w, 'filled');
    s6w.MarkerFaceColor = 'blue';
% 

    grid('on')
    xlabel('F2')
%     ylim(F1_lim);
%     xlim(F2_lim);
    ylabel('F1')
    title('Formant')


    %%
    %kh-28
elecmatrix(177:180,:)=[];elecmatrix(170:174,:)=[];
    elecmatrix(153:160,:)=[];  elecmatrix(143:144,:)=[];elecmatrix(135:136,:)=[];elecmatrix(124,:)=[];elecmatrix(109:114,:)=[];
elecmatrix(102:106,:)=[];elecmatrix(88:90,:)=[];
   elecmatrix(85,:)=[];elecmatrix(80,:)=[];elecmatrix(76:77,:)=[];
   elecmatrix(70,:)=[];elecmatrix(39:43,:)=[];elecmatrix(33,:)=[];
   elecmatrix(21,:)=[];elecmatrix(13:15,:)=[];elecmatrix(7:8,:)=[];

   %% kh-31
   
    elecmatrix(79,:)=[];elecmatrix(74,:)=[];elecmatrix(47,:)=[];
    elecmatrix(40,:)=[];
   %%
   set(0,'DefaultFigureVisible','off')
    
k=1;l=1;m=1;
filename = 'zscore_across_trials_kh31.gif';
im_idx = 0;
im = {};
vowels = streams{1,1}.time_series;
t=1;
    for trial=4:1:size(index,2)-1
        im_idx = im_idx + 1;
        fig = figure('Renderer', 'painters', 'Position', [10 10 2400 800]);
      
        prelocs =[];postlocs =[];simlocs =[];
        xpre=[];ypre=[];zpre=[];
        xpost=[];ypost=[];zpost=[];
        xsim=[];ysim=[];zsim=[];
        for ch=1:1:size(index,1)-1
            if(index(ch,trial)==2)
                xpre(l) = elecmatrix(ch,1);
                ypre(l) = elecmatrix(ch,2);
                zpre(l) = elecmatrix(ch,3);
                l=l+1;
            
        elseif(index(ch,trial)==1)
                xpost(k) = elecmatrix(ch,1);
                ypost(k) = elecmatrix(ch,2);
                zpost(k) = elecmatrix(ch,3);
                k=k+1;
            
            elseif(index(ch,trial)==3)
                xsim(m) = elecmatrix(ch,1);
                ysim(m) = elecmatrix(ch,2);
                zsim(m) = elecmatrix(ch,3);
                m=m+1;
            end

        end
         prelocs = [xpre',ypre',zpre'];
         postlocs = [xpost',ypost',zpost'];
         simlocs = [xsim',ysim',zsim'];
         

         if(size(prelocs,1)>0 && size(simlocs,1)>0 && size(postlocs,1)>0)
           
             w3 = scatter3(prelocs(:,1),prelocs(:,2),prelocs(:,3),'filled');
             w3.MarkerFaceColor = 'blue';
             hold on
             s6w = scatter3(postlocs(:,1),postlocs(:,2),postlocs(:,3),'filled');
             s6w.MarkerFaceColor = "red";
             hold on
             sw = scatter3(simlocs(:,1),simlocs(:,2),simlocs(:,3),'filled');
             sw.MarkerFaceColor = 'green';
             legend('pre-speech','post-speech','with speech');
             title(vowels(2*t));
         
            t=t+1;

         elseif(size(simlocs,1)>0 && size(postlocs,1)>0)
           
             s6w = scatter3(postlocs(:,1),postlocs(:,2),postlocs(:,3),'filled');
             s6w.MarkerFaceColor = "red";
             hold on
             sw = scatter3(simlocs(:,1),simlocs(:,2),simlocs(:,3),'filled');
             sw.MarkerFaceColor = 'green';
             legend('post-speech','with speech');
             title(vowels(2*t));
            t=t+1;

         elseif(size(prelocs,1)>0 && size(postlocs,1)>0)
            
             w3 = scatter3(prelocs(:,1),prelocs(:,2),prelocs(:,3),'filled');
             w3.MarkerFaceColor = 'blue';
             hold on
            s6w = scatter3(postlocs(:,1),postlocs(:,2),postlocs(:,3),'filled');
            s6w.MarkerFaceColor = "red";
         
            legend('pre-speech','post speech');
            title(vowels(2*t));
            t=t+1;
         end

   % plot to the gif 
    drawnow
    frame = getframe(fig);
    im{im_idx} = frame2im(frame);
    [imind,cm] = rgb2ind(im{im_idx},256);
    if im_idx == 1
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append');
    end
    end

%%
    w3 = scatter3(prelocs(:,1),prelocs(:,2),prelocs(:,3),'filled');
    w3.MarkerFaceColor = 'blue';
    hold on
    s6w = scatter3(postlocs(:,1),postlocs(:,2),postlocs(:,3),'filled');
    s6w.MarkerFaceColor = "red";
    hold on
    sw = scatter3(simlocs(:,1),simlocs(:,2),simlocs(:,3),'filled');
    sw.MarkerFaceColor = 'green';
   
    legend('pre-speech','post-speech','with speech');

     