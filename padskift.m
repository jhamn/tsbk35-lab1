function Y = padskift(X,offset,padval)
    temp = circshift(padarray(X,[1 1],padval,'both'),offset);
    Y = temp(2:end-1,2:end-1);
end