function y=skift_2d(signal,steps)
    y = zeros(size(signal));
    y(steps+1:end,) = signal(1:end-steps,);
end

