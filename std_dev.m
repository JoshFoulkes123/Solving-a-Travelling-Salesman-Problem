function out = std_dev(range,mu,num,p)


xmin=1;
xmax=range;
n=num;
X = round(xmin + (xmax - xmin)*sum(rand(n,p),2)/p);

X = X+ mu-range/2;
for i=1: num
    if X(i) > xmax
        X(i) = X(i)-xmax;
    elseif X(i) < 1
        X(i) = xmax + X(i);
    end
end
out=X;

