%% Swap two cities
function newroute = twoopt(route, i, k)
% Step 1: take $route[1]$ to $route[i-1]$ and add them in order to
% $newroute$ 

a = route(1,1:i-1);


% Step 2: take $route[i]$ to $route[k]$ and add them in reverse order to
% $newroute$ 
% Hint: type help fliplr

b = fliplr(route(1,i:k));

d = cat(2,a,b);


% Step 3: take $route[k+1]$ to end and add them in order to new $newroute$
c= route(1,k+1:end);
e = cat(2,d,c);

newroute = e;

end