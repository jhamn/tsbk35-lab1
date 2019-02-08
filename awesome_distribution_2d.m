function p=awesome_distribution_2d(signal)

    symbol_count = zeros(max(max(signal)), 1);

    for row = 1:size(signal, 1)
        for col = 1:size(signal,2) 
            index = signal(row,col);
            symbol_count(index) = symbol_count(index) + 1;
        end
    end
    
    p = symbol_count/numel(signal);
end
