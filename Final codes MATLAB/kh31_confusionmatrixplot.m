%lh S Temp sup
labels_test = [];labels_train=[];
for i=1:1:floor(0.7*(size(vo_lhStemps,1)))
    labels_train = [labels_train 1];
end
for i=1:1:floor(0.7*(size(voe_lhStemps,1)))
    labels_train = [labels_train 2];
end
for i=1:1:floor(0.7*(size(veu_lhStemps,1)))
    labels_train = [labels_train 3];
end
for i=1:1:floor(0.7*(size(vie_lhStemps,1)))
    labels_train = [labels_train 4];
end
for i=1:1:floor(0.7*(size(ve_lhStemps,1)))
    labels_train = [labels_train 5];
end
for i=1:1:floor(0.7*(size(vu_lhStemps,1)))
    labels_train = [labels_train 6];
end
for i =1:1:size(vo_lhStemps,1)-floor(0.7*(size(vo_lhStemps,1)))
    labels_test = [labels_test 1];
end
for i =1:1:size(voe_lhStemps,1)-floor(0.7*(size(voe_lhStemps,1)))
    labels_test = [labels_test 2];
end
for i =1:1:size(veu_lhStemps,1)-floor(0.7*(size(veu_lhStemps,1)))
    labels_test = [labels_test 3];
end
for i =1:1:size(vie_lhStemps,1)-floor(0.7*(size(vie_lhStemps,1)))
    labels_test = [labels_test 4];
end
for i =1:1:size(ve_lhStemps,1)-floor(0.7*(size(ve_lhStemps,1)))
    labels_test = [labels_test 5];
end
for i =1:1:size(vu_lhStemps,1)-floor(0.7*(size(vu_lhStemps,1)))
    labels_test = [labels_test 6];
end

neuro_train = [vo_lhStemps(1:floor(0.7*(size(vo_lhStemps,1))),:);voe_lhStemps(1:floor(0.7*(size(voe_lhStemps,1))),:);veu_lhStemps(1:floor(0.7*(size(veu_lhStemps,1))),:);vie_lhStemps(1:floor(0.7*(size(vie_lhStemps,1))),:);
    ve_lhStemps(1:floor(0.7*(size(ve_lhStemps,1))),:);vu_lhStemps(1:floor(0.7*(size(vu_lhStemps,1))),:)];

neuro_test = [vo_lhStemps(floor(0.7*(size(vo_lhStemps,1)))+1:size(vo_lhStemps,1),:);voe_lhStemps(floor(0.7*(size(voe_lhStemps,1)))+1:size(voe_lhStemps,1),:);veu_lhStemps(floor(0.7*(size(veu_lhStemps,1)))+1:size(veu_lhStemps,1),:);vie_lhStemps(floor(0.7*(size(vie_lhStemps,1)))+1:size(vie_lhStemps,1),:);
    ve_lhStemps(floor(0.7*(size(ve_lhStemps,1)))+1:size(ve_lhStemps,1),:);vu_lhStemps(floor(0.7*(size(vu_lhStemps,1)))+1:size(vu_lhStemps,1),:)];


cl = fitcecoc(neuro_train,labels_train);
v1 = predict(cl,neuro_test);

hf=figure;
confusionchart(hf,labels_test,v1,"RowSummary","row-normalized","ColumnSummary","column-normalized")
title("Confusion Matrix for lh S temp sup")


%% lh G front middle
labels_test = [];labels_train=[];
for i=1:1:floor(0.7*(size(vo_lhGfrm,1)))
    labels_train = [labels_train 1];
end
for i=1:1:floor(0.7*(size(voe_lhGfrm,1)))
    labels_train = [labels_train 2];
end
for i=1:1:floor(0.7*(size(veu_lhGfrm,1)))
    labels_train = [labels_train 3];
end
for i=1:1:floor(0.7*(size(vie_lhGfrm,1)))
    labels_train = [labels_train 4];
end
for i=1:1:floor(0.7*(size(ve_lhGfrm,1)))
    labels_train = [labels_train 5];
end
for i=1:1:floor(0.7*(size(vu_lhGfrm,1)))
    labels_train = [labels_train 6];
end
for i =1:1:size(vo_lhGfrm,1)-floor(0.7*(size(vo_lhGfrm,1)))
    labels_test = [labels_test 1];
end
for i =1:1:size(voe_lhGfrm,1)-floor(0.7*(size(voe_lhGfrm,1)))
    labels_test = [labels_test 2];
end
for i =1:1:size(veu_lhGfrm,1)-floor(0.7*(size(veu_lhGfrm,1)))
    labels_test = [labels_test 3];
end
for i =1:1:size(vie_lhGfrm,1)-floor(0.7*(size(vie_lhGfrm,1)))
    labels_test = [labels_test 4];
end
for i =1:1:size(ve_lhGfrm,1)-floor(0.7*(size(ve_lhGfrm,1)))
    labels_test = [labels_test 5];
end
for i =1:1:size(vu_lhGfrm,1)-floor(0.7*(size(vu_lhGfrm,1)))
    labels_test = [labels_test 6];
end

neuro_train = [vo_lhGfrm(1:floor(0.7*(size(vo_lhGfrm,1))),:);voe_lhGfrm(1:floor(0.7*(size(voe_lhGfrm,1))),:);veu_lhGfrm(1:floor(0.7*(size(veu_lhGfrm,1))),:);vie_lhGfrm(1:floor(0.7*(size(vie_lhGfrm,1))),:);
    ve_lhGfrm(1:floor(0.7*(size(ve_lhGfrm,1))),:);vu_lhGfrm(1:floor(0.7*(size(vu_lhGfrm,1))),:)];

neuro_test = [vo_lhGfrm(floor(0.7*(size(vo_lhGfrm,1)))+1:size(vo_lhGfrm,1),:);voe_lhGfrm(floor(0.7*(size(voe_lhGfrm,1)))+1:size(voe_lhGfrm,1),:);veu_lhGfrm(floor(0.7*(size(veu_lhGfrm,1)))+1:size(veu_lhGfrm,1),:);vie_lhGfrm(floor(0.7*(size(vie_lhGfrm,1)))+1:size(vie_lhGfrm,1),:);
    ve_lhGfrm(floor(0.7*(size(ve_lhGfrm,1)))+1:size(ve_lhGfrm,1),:);vu_lhGfrm(floor(0.7*(size(vu_lhGfrm,1)))+1:size(vu_lhGfrm,1),:)];


cl = fitcecoc(neuro_train,labels_train);
v1 = predict(cl,neuro_test);

hf=figure;
confusionchart(hf,labels_test,v1,"RowSummary","row-normalized","ColumnSummary","column-normalized")
title("Confusion Matrix for lh S temp sup")

%% lh 
labels_test = [];labels_train=[];
for i=1:1:floor(0.7*(size(vo_lh,1)))
    labels_train = [labels_train 1];
end
for i=1:1:floor(0.7*(size(voe_lh,1)))
    labels_train = [labels_train 2];
end
for i=1:1:floor(0.7*(size(veu_lh,1)))
    labels_train = [labels_train 3];
end
for i=1:1:floor(0.7*(size(vie_lh,1)))
    labels_train = [labels_train 4];
end
for i=1:1:floor(0.7*(size(ve_lh,1)))
    labels_train = [labels_train 5];
end
for i=1:1:floor(0.7*(size(vu_lh,1)))
    labels_train = [labels_train 6];
end
for i =1:1:size(vo_lh,1)-floor(0.7*(size(vo_lh,1)))
    labels_test = [labels_test 1];
end
for i =1:1:size(voe_lh,1)-floor(0.7*(size(voe_lh,1)))
    labels_test = [labels_test 2];
end
for i =1:1:size(veu_lh,1)-floor(0.7*(size(veu_lh,1)))
    labels_test = [labels_test 3];
end
for i =1:1:size(vie_lh,1)-floor(0.7*(size(vie_lh,1)))
    labels_test = [labels_test 4];
end
for i =1:1:size(ve_lh,1)-floor(0.7*(size(ve_lh,1)))
    labels_test = [labels_test 5];
end
for i =1:1:size(vu_lh,1)-floor(0.7*(size(vu_lh,1)))
    labels_test = [labels_test 6];
end

neuro_train = [vo_lh(1:floor(0.7*(size(vo_lh,1))),:);voe_lh(1:floor(0.7*(size(voe_lh,1))),:);veu_lh(1:floor(0.7*(size(veu_lh,1))),:);vie_lh(1:floor(0.7*(size(vie_lh,1))),:);
    ve_lh(1:floor(0.7*(size(ve_lh,1))),:);vu_lh(1:floor(0.7*(size(vu_lh,1))),:)];

neuro_test = [vo_lh(floor(0.7*(size(vo_lh,1)))+1:size(vo_lh,1),:);voe_lh(floor(0.7*(size(voe_lh,1)))+1:size(voe_lh,1),:);veu_lh(floor(0.7*(size(veu_lh,1)))+1:size(veu_lh,1),:);vie_lh(floor(0.7*(size(vie_lh,1)))+1:size(vie_lh,1),:);
    ve_lh(floor(0.7*(size(ve_lh,1)))+1:size(ve_lh,1),:);vu_lh(floor(0.7*(size(vu_lh,1)))+1:size(vu_lh,1),:)];


cl = fitcecoc(neuro_train,labels_train);
v1 = predict(cl,neuro_test);

hf=figure;
confusionchart(hf,labels_test,v1,"RowSummary","row-normalized","ColumnSummary","column-normalized")
title("Confusion Matrix for left hippocampus")

%% lh G precentral
labels_test = [];labels_train=[];
for i=1:1:floor(0.7*(size(vo_lhGpc ,1)))
    labels_train = [labels_train 1];
end
for i=1:1:floor(0.7*(size(voe_lhGpc,1)))
    labels_train = [labels_train 2];
end
for i=1:1:floor(0.7*(size(veu_lhGpc,1)))
    labels_train = [labels_train 3];
end
for i=1:1:floor(0.7*(size(vie_lhGpc,1)))
    labels_train = [labels_train 4];
end
for i=1:1:floor(0.7*(size(ve_lhGpc,1)))
    labels_train = [labels_train 5];
end
for i=1:1:floor(0.7*(size(vu_lhGpc,1)))
    labels_train = [labels_train 6];
end
for i =1:1:size(vo_lhGpc,1)-floor(0.7*(size(vo_lhGpc,1)))
    labels_test = [labels_test 1];
end
for i =1:1:size(voe_lhGpc,1)-floor(0.7*(size(voe_lhGpc,1)))
    labels_test = [labels_test 2];
end
for i =1:1:size(veu_lhGpc,1)-floor(0.7*(size(veu_lhGpc,1)))
    labels_test = [labels_test 3];
end
for i =1:1:size(vie_lhGpc,1)-floor(0.7*(size(vie_lhGpc,1)))
    labels_test = [labels_test 4];
end
for i =1:1:size(ve_lhGpc,1)-floor(0.7*(size(ve_lhGpc,1)))
    labels_test = [labels_test 5];
end
for i =1:1:size(vu_lhGpc,1)-floor(0.7*(size(vu_lhGpc,1)))
    labels_test = [labels_test 6];
end

neuro_train = [vo_lhGpc(1:floor(0.7*(size(vo_lhGpc,1))),:);voe_lhGpc(1:floor(0.7*(size(voe_lhGpc,1))),:);veu_lhGpc(1:floor(0.7*(size(veu_lhGpc,1))),:);vie_lhGpc(1:floor(0.7*(size(vie_lhGpc,1))),:);
    ve_lhGpc(1:floor(0.7*(size(ve_lhGpc,1))),:);vu_lhGpc(1:floor(0.7*(size(vu_lhGpc,1))),:)];

neuro_test = [vo_lhGpc(floor(0.7*(size(vo_lhGpc,1)))+1:size(vo_lhGpc,1),:);voe_lhGpc(floor(0.7*(size(voe_lhGpc,1)))+1:size(voe_lhGpc,1),:);veu_lhGpc(floor(0.7*(size(veu_lhGpc,1)))+1:size(veu_lhGpc,1),:);vie_lhGpc(floor(0.7*(size(vie_lhGpc,1)))+1:size(vie_lhGpc,1),:);
    ve_lhGpc(floor(0.7*(size(ve_lhGpc,1)))+1:size(ve_lhGpc,1),:);vu_lhGpc(floor(0.7*(size(vu_lhGpc,1)))+1:size(vu_lhGpc,1),:)];


cl = fitcecoc(neuro_train,labels_train);
v1 = predict(cl,neuro_test);

hf=figure;
confusionchart(hf,labels_test,v1,"RowSummary","row-normalized","ColumnSummary","column-normalized")
title("Confusion Matrix for lh G precentral")


%% lhGtempm
labels_test = [];labels_train=[];
for i=1:1:floor(0.7*(size(vo_lhGtempm ,1)))
    labels_train = [labels_train 1];
end
for i=1:1:floor(0.7*(size(voe_lhGtempm,1)))
    labels_train = [labels_train 2];
end
for i=1:1:floor(0.7*(size(veu_lhGtempm,1)))
    labels_train = [labels_train 3];
end
for i=1:1:floor(0.7*(size(vie_lhGtempm,1)))
    labels_train = [labels_train 4];
end
for i=1:1:floor(0.7*(size(ve_lhGtempm,1)))
    labels_train = [labels_train 5];
end
for i=1:1:floor(0.7*(size(vu_lhGtempm,1)))
    labels_train = [labels_train 6];
end
for i =1:1:size(vo_lhGtempm,1)-floor(0.7*(size(vo_lhGtempm,1)))
    labels_test = [labels_test 1];
end
for i =1:1:size(voe_lhGtempm,1)-floor(0.7*(size(voe_lhGtempm,1)))
    labels_test = [labels_test 2];
end
for i =1:1:size(veu_lhGtempm,1)-floor(0.7*(size(veu_lhGtempm,1)))
    labels_test = [labels_test 3];
end
for i =1:1:size(vie_lhGtempm,1)-floor(0.7*(size(vie_lhGtempm,1)))
    labels_test = [labels_test 4];
end
for i =1:1:size(ve_lhGtempm,1)-floor(0.7*(size(ve_lhGtempm,1)))
    labels_test = [labels_test 5];
end
for i =1:1:size(vu_lhGtempm,1)-floor(0.7*(size(vu_lhGtempm,1)))
    labels_test = [labels_test 6];
end

neuro_train = [vo_lhGtempm(1:floor(0.7*(size(vo_lhGtempm,1))),:);voe_lhGtempm(1:floor(0.7*(size(voe_lhGtempm,1))),:);veu_lhGtempm(1:floor(0.7*(size(veu_lhGtempm,1))),:);vie_lhGtempm(1:floor(0.7*(size(vie_lhGtempm,1))),:);
    ve_lhGtempm(1:floor(0.7*(size(ve_lhGtempm,1))),:);vu_lhGtempm(1:floor(0.7*(size(vu_lhGtempm,1))),:)];

neuro_test = [vo_lhGtempm(floor(0.7*(size(vo_lhGtempm,1)))+1:size(vo_lhGtempm,1),:);voe_lhGtempm(floor(0.7*(size(voe_lhGtempm,1)))+1:size(voe_lhGtempm,1),:);veu_lhGtempm(floor(0.7*(size(veu_lhGtempm,1)))+1:size(veu_lhGtempm,1),:);vie_lhGtempm(floor(0.7*(size(vie_lhGtempm,1)))+1:size(vie_lhGtempm,1),:);
    ve_lhGtempm(floor(0.7*(size(ve_lhGtempm,1)))+1:size(ve_lhGtempm,1),:);vu_lhGtempm(floor(0.7*(size(vu_lhGtempm,1)))+1:size(vu_lhGtempm,1),:)];


cl = fitcecoc(neuro_train,labels_train);
v1 = predict(cl,neuro_test);

hf=figure;
confusionchart(hf,labels_test,v1,"RowSummary","row-normalized","ColumnSummary","column-normalized")
title("Confusion Matrix for lh G temporal middle ")