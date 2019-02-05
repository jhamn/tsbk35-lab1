%% Läs in signaler
signal = audioread('speech.wav');
%signal = audioread('nuit04_8bit.wav');
%signal = audioread('hey04_8bit.wav');

%% Ändra range från -1,1 till -128,127

signal = signal*128 + 128;

p_hist = histcounts(signal); %används inte

%% en loop som räknar fördelningen

symbol_count = zeros(256, 1);

for i = 1:size(signal, 1)
    index = signal(i);
    symbol_count(index) = symbol_count(index) + 1;
end
    
%% sannolikheterna

p = symbol_count/size(signal, 1);

%%

a = find(p);

filtered_p = p(a);
% FRÅGA : varför blir p 232 och p_hist 122?


%% räkna ut entropin för H(X)

Hx = -sum(filtered_p.*log2(filtered_p));

%% räkna ut parsannolikheterna

%pairs = p.*p'; %fel?

pair_symbol_count = zeros(256);

for i = 1:size(signal, 1)-1
    index = signal(i);
    index2 = signal(i + 1);
    pair_symbol_count(index, index2) = pair_symbol_count(index, index2)+1;
end
%%

p_pairs = pair_symbol_count/(size(signal, 1) - 1);

%%

filtered_pairs = p_pairs(find(p_pairs));
%% räkna ut parentropin

Hxx = -sum(filtered_pairs.*log2(filtered_pairs));

%% räkna ut betingade sannolikheter

% H (X , Y ) = H (X ) + H (Y |X )

Hc = Hxx - Hx;
    
    
    