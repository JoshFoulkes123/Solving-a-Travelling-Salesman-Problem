function inv = perm_to_inv(perm)

N = size(perm,2);
inv_t = zeros(1,N);

for i =1:N
    m =1;
    inv_t(1,i) = 0;
    while perm(m) ~= i
        if perm(m) > i
            inv_t(1,i) = inv_t(1,i) + 1;
        end
        m = m+1;
    end
end

inv = inv_t;