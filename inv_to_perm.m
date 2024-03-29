function perm = inv_to_perm(inv)

N = size(inv,2);
perm_t = zeros(1,N);
perm_out = zeros(1,N);
for a =1:N
    i = N+1 -a;
    for m = i+1 : N
        if perm_t(1,m) >= (inv(1,i)+1)
            perm_t(1,m) = perm_t(1,m) +1;
        end
        perm_t(1,i)=inv(1,i)+1;
    end
end

for i = 1 :N
    idx = perm_t(1,i);
    if idx == 0
    else
        perm_out(1,idx) = i;
    end    
end
perm_out(perm_out==0)=N;
perm = perm_out;
