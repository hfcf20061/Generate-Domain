function [ n ] = check( i, N )

if i > N
    n = i - N;
else
    n = i;
end
end
