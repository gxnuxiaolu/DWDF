function a1 = sw(feature_mat)
[~,h,k] = size(feature_mat);

feature = sum(feature_mat);

a = feature(:,:,1);
dist = zeros(1,k);
for i=2:k
    b = feature(:,:,i);
    a = cat(1,a,b);
end
a1 = a;
for i=1:k
    b = a(i,:);
    for j=1:k
        if j == i
            dist(j) = 0;
        else
            dist(j) = sum((b-a(j,:)).^2);
        end
    end
    dist = normalize(dist);
    t=0;
    for j=1:k
        if dist(j) >= 0
            dist(j) = 0;
        end
        if dist(j) < 0
            dist(j) = -dist(j);
            t = t + 1;
        end
    end
    he = sum(dist);
    avg = he/t;
    feature1 = zeros(1,h);
    for j=1:k
        if dist(j)>avg && j~=i
            feature1 = feature1+(a(j,:).^2).*dist(j);
        end
    end
    feature1 = (feature1./sum(feature1)).^(1/2);
    a1(i,:) = a1(i,:).*feature1;
end
a1 = sum(a1,2);
a1 = a1';
end

