function c = flw(im,feature_mat)
[w,h,m]=size(feature_mat);
[~,~,~,I] = rgb2hsi(im);
ldim = gaborlv(I);
ldim=imresize(ldim,[w,h]);

sx=max(max(max(feature_mat)));
xx=min(min(min(feature_mat)));
ldim=normalize(ldim,'range',[xx,sx]);


tu = sum(ldim);

dist = zeros(1,m);
feature = sum(feature_mat);
a = feature(:,:,1);
for i=2:m
    b = feature(:,:,i);
    a = cat(1,a,b);
end
for i=1:m
    dist(i) = sum((tu-a(i,:)).^2);
end
c = (dist./sum(dist)).^(1/2);
end

