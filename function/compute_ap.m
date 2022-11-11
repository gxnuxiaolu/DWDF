function ap = compute_ap(query,image_set,t)
    if strcmp(image_set,'Oxford5k')
        load(['..\datasets\',image_set,'\gnd_oxford5k.mat']);
    elseif strcmp(image_set,'Paris6k')
        load(['..\datasets\',image_set,'\gnd_paris6k.mat']);
    elseif strcmp(image_set,'Holidays')
        load(['..\datasets\',image_set,'\gnd_holidays.mat']);
    elseif strcmp(image_set,'Oxford105k')
        load(['..\datasets\',image_set,'\gnd_oxford105k.mat']);
    elseif strcmp(image_set,'Paris106k')
        load(['..\datasets\',image_set,'\gnd_paris106k.mat']);
    end
    
    old_recall=0.0;
    old_precision=1.0;
    ap=0.0;
    intersect_size=0;
    j=0;

    for i=1:size(query,2)
        if ismember(query(i),gnd(t).junk)
            continue;
        end
        if ismember(query(i),gnd(t).ok)
            intersect_size = intersect_size+1;
        end
        recall = intersect_size/size(gnd(t).ok,1);
        precision = intersect_size/(j+1.0);
        ap = ap+(recall-old_recall)*((old_precision+precision)/2.0);
        
        old_recall = recall;
        old_precision = precision;
        j = j+1;
    end
end

