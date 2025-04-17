classNames = {'e','oe','eu','ie','o','u'}; % Specify class order
labels_train = []; labels_test = [];

for i=1:1:floor(0.7*size(ve,1))
    labels_train = [labels_train 1];
end
for i=1:1:floor(0.7*size(voe,1))
    labels_train = [labels_train 2];
end
for i=1:1:floor(0.7*size(veu,1))
    labels_train = [labels_train 3];
end
for i=1:1:floor(0.7*size(vie,1))
    labels_train = [labels_train 4];
end
for i=1:1:floor(0.7*size(vo,1))
    labels_train = [labels_train 5];
end
for i=1:1:floor(0.7*size(vu,1))
    labels_train = [labels_train 6];
end

for i =1:1:size(ve,1)-floor(0.7*size(ve,1))
    labels_test = [labels_test 1];
end
for i =1:1:size(voe,1)-floor(0.7*size(voe,1))
    labels_test = [labels_test 2];
end
for i =1:1:size(veu,1)-floor(0.7*size(veu,1))
    labels_test = [labels_test 3];
end
for i =1:1:size(vie,1)-floor(0.7*size(vie,1))
    labels_test = [labels_test 4];
end
for i =1:1:size(vo,1)-floor(0.7*size(vo,1))
    labels_test = [labels_test 5];
end
for i =1:1:size(vu,1)-floor(0.7*size(vu,1))
    labels_test = [labels_test 6];
end

%% ALL RANGES 
neuro_train = [ve(1:floor(0.7*size(ve,1)),:);voe(1:floor(0.7*size(voe,1)),:);veu(1:floor(0.7*size(veu,1)),:);vie(1:floor(0.7*size(vie,1)),:);
    vo(1:floor(0.7*size(vo,1)),:);vu(1:floor(0.7*size(vu,1)),:)];
neuro_test = [ve(floor(0.7*size(ve,1))+1:end,:);voe(floor(0.7*size(voe,1))+1:end,:);veu(floor(0.7*size(veu,1))+1:end,:);vie(floor(0.7*size(vie,1))+1:end,:);
    vo(floor(0.7*size(vo,1))+1:end,:);vu(floor(0.7*size(vu,1))+1:end,:)];


cl = fitcecoc(neuro_train,labels_train);
v1 = predict(cl,neuro_test);

hf=figure;
confusionchart(hf,labels_test,v1,"RowSummary","row-normalized","ColumnSummary","column-normalized")
title("Confusion Matrix for all frequencies")


%% HIGH GAMMA RANGE 
neuro_train = [ve(1:floor(0.7*size(ve,1)),150:end);voe(1:floor(0.7*size(voe,1)),150:end);veu(1:floor(0.7*size(veu,1)),150:end);vie(1:floor(0.7*size(vie,1)),150:end);
    vo(1:floor(0.7*size(vo,1)),150:end);vu(1:floor(0.7*size(vu,1)),150:end)];
neuro_test = [ve(floor(0.7*size(ve,1))+1:end,150:end);voe(floor(0.7*size(voe,1))+1:end,150:end);veu(floor(0.7*size(veu,1))+1:end,150:end);vie(floor(0.7*size(vie,1))+1:end,150:end);
    vo(floor(0.7*size(vo,1))+1:end,150:end);vu(floor(0.7*size(vu,1))+1:end,150:end)];

cl = fitcecoc(neuro_train,labels_train);
v1 = predict(cl,neuro_test);

hf=figure;
confusionchart(hf,labels_test,v1,"RowSummary","row-normalized","ColumnSummary","column-normalized")
title("Confusion Matrix for the  High Gamma activity (150 - 250 Hz)")


%% GAMMA RANGE 
neuro_train = [ve(1:floor(0.7*size(ve,1)),100:150);voe(1:floor(0.7*size(voe,1)),100:150);veu(1:floor(0.7*size(veu,1)),100:150);vie(1:floor(0.7*size(vie,1)),100:150);
    vo(1:floor(0.7*size(vo,1)),100:150);vu(1:floor(0.7*size(vu,1)),100:150)];
neuro_test = [ve(floor(0.7*size(ve,1))+1:end,100:150);voe(floor(0.7*size(voe,1))+1:end,100:150);veu(floor(0.7*size(veu,1))+1:end,100:150);vie(floor(0.7*size(vie,1))+1:end,100:150);
    vo(floor(0.7*size(vo,1))+1:end,100:150);vu(floor(0.7*size(vu,1))+1:end,100:150)];


cl = fitcecoc(neuro_train,labels_train);
v1 = predict(cl,neuro_test);

hf=figure;
confusionchart(hf,labels_test,v1,"RowSummary","row-normalized","ColumnSummary","column-normalized")
title("Confusion Matrix for the Gamma activity (100 - 150 Hz)")

%%  RANGE 
neuro_train = [ve(1:floor(0.7*size(ve,1)),75:100);voe(1:floor(0.7*size(voe,1)),75:100);veu(1:floor(0.7*size(veu,1)),75:100);vie(1:floor(0.7*size(vie,1)),75:100);
    vo(1:floor(0.7*size(vo,1)),75:100);vu(1:floor(0.7*size(vu,1)),75:100)];
neuro_test = [ve(floor(0.7*size(ve,1))+1:end,75:100);voe(floor(0.7*size(voe,1))+1:end,75:100);veu(floor(0.7*size(veu,1))+1:end,75:100);vie(floor(0.7*size(vie,1))+1:end,75:100);
    vo(floor(0.7*size(vo,1))+1:end,75:100);vu(floor(0.7*size(vu,1))+1:end,75:100)];


cl = fitcecoc(neuro_train,labels_train);
v1 = predict(cl,neuro_test);

hf=figure;
confusionchart(hf,labels_test,v1,"RowSummary","row-normalized","ColumnSummary","column-normalized")
title("Confusion Matrix for the Gamma activity (75 - 100 Hz)")

%%  BETA RANGE 
neuro_train = [ve(1:floor(0.7*size(ve,1)),30:75);voe(1:floor(0.7*size(voe,1)),30:75);veu(1:floor(0.7*size(veu,1)),30:75);vie(1:floor(0.7*size(vie,1)),30:75);
    vo(1:floor(0.7*size(vo,1)),30:75);vu(1:floor(0.7*size(vu,1)),30:75)];
neuro_test = [ve(floor(0.7*size(ve,1))+1:end,30:75);voe(floor(0.7*size(voe,1))+1:end,30:75);veu(floor(0.7*size(veu,1))+1:end,30:75);vie(floor(0.7*size(vie,1))+1:end,30:75);
    vo(floor(0.7*size(vo,1))+1:end,30:75);vu(floor(0.7*size(vu,1))+1:end,30:75)];


cl = fitcecoc(neuro_train,labels_train);
v1 = predict(cl,neuro_test);

hf=figure;
confusionchart(hf,labels_test,v1,"RowSummary","row-normalized","ColumnSummary","column-normalized")
title("Confusion Matrix  (30 - 75 Hz)")


%%  ALPHA RANGE 
neuro_train = [ve(1:floor(0.7*size(ve,1)),1:30);voe(1:floor(0.7*size(voe,1)),1:30);veu(1:floor(0.7*size(veu,1)),1:30);vie(1:floor(0.7*size(vie,1)),1:30);
    vo(1:floor(0.7*size(vo,1)),1:30);vu(1:floor(0.7*size(vu,1)),1:30)];
neuro_test = [ve(floor(0.7*size(ve,1))+1:end,1:30);voe(floor(0.7*size(voe,1))+1:end,1:30);veu(floor(0.7*size(veu,1))+1:end,1:30);vie(floor(0.7*size(vie,1))+1:end,1:30);
    vo(floor(0.7*size(vo,1))+1:end,1:30);vu(floor(0.7*size(vu,1))+1:end,1:30)];


cl = fitcecoc(neuro_train,labels_train);
v1 = predict(cl,neuro_test);

hf=figure;
confusionchart(hf,labels_test,v1,"RowSummary","row-normalized","ColumnSummary","column-normalized")
title("Confusion Matrix (0 - 30 Hz)")