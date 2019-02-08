function H = awesome_entropy(p)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
p_flat = reshape(p.',1,[]);
H = -nansum(p_flat.*log2(p_flat));
end

