function dist = compute_nn(feature,query_feature,type)
    switch type
        case {1,'L1'}
            dist = sum(abs(feature - query_feature),2);
        case {2,'L2'}
            dist = pdist2(feature,query_feature,'squaredeuclidean');
        case {3,'Cosine'}
            dist = pdist2(feature,query_feature,'cosine');
        case {4,'Correlation'}
            dist = pdist2(feature,query_feature,'correlation');
    end
        
end