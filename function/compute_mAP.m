function mAP = compute_mAP(feature,query_feature,K,image_set,type)
    file_num = size(query_feature,1);
    ranklist = zeros(size(query_feature,1),size(feature,1));
    sum_ap = 0;
    for i = 1:size(query_feature,1)
        dist = compute_nn(feature,query_feature(i,:),type);
        [~,index] = sort(dist);
        % ------execute QE-----------
        if K
            qe_data = zeros(1,size(query_feature,2));
            for k = 1:K
                qe_data = qe_data + feature(index(k),:);
            end
            qe_data = norm2(qe_data);
            dist = compute_nn(feature,qe_data,type);
            [~,index] = sort(dist);
        end
        % ----------end------------
        ranklist(i,:) = index;
        ap = compute_ap(ranklist(i,:),image_set,i);
        sum_ap = sum_ap+ap;
    end
    ranklist = ranklist';
    if K
        save(['..\results\DWDF\',image_set,'\ranklist\','ranklist',num2str(size(query_feature,2)),'_',num2str(K),'.mat'],'ranklist');
    else
        save(['..\results\DWDF\',image_set,'\ranklist\','ranklist',num2str(size(query_feature,2)),'.mat'],'ranklist');
    end
    mAP = sum_ap/file_num;
end

