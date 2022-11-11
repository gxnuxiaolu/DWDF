function [Xtest,Xquery] = pca_whitening(Xtest,Xtrain,Xquery,d)
Xtest =  norm2(Xtest);
Xtrain =  norm2(Xtrain);
mu = mean(Xtrain);
Xcov = cov(Xtrain, 'omitrows');
Xcov(isnan(Xcov)) = 0;
[u,s,~] = svd(Xcov);

Xtest = Xtest - mu;
xRot = Xtest * u;
epsilon=1*10^(-5);
x = xRot * diag(1./(sqrt(diag(s)+epsilon)));
x(isnan(x)) = 0;
Xtest = x(:,1:d);

Xquery =  norm2(Xquery);
Xquery = Xquery - mu;
xRot = Xquery * u;

x = xRot * diag(1./(sqrt(diag(s)+epsilon)));
x(isnan(x)) = 0;
Xquery = x(:,1:d);

Xtest =  norm2(Xtest);
Xquery =  norm2(Xquery);
end


