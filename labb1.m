%% Läs in signaler
signal = audioread('speech.wav');
%signal = audioread('nuit04_8bit.wav');
%signal = audioread('hey04_8bit.wav');

%% Ändra range från -1,1 till -128,127

signal = signal*128 + 128;


%% en loop som räknar fördelningen

%symbol_count = zeros(256, 1);

% for i = 1:size(signal, 1)
%     index = signal(i);
%     symbol_count(index) = symbol_count(index) + 1;
% end
%     
% %% sannolikheterna
% 
% p = symbol_count/size(signal, 1);
% 
% %%
% 
% a = find(p);
% 
% filtered_p = p(a);
% FRÅGA : varför blir p 232 och p_hist 122?

%% awesome dist

p = awesome_distribution(signal);

%% räkna ut entropin för H(X)

Hx = awesome_entropy(p);

%% räkna ut parsannolikheterna

pair_symbol_count = zeros(256);

for i = 1:size(signal, 1)-1
    index = signal(i);
    index2 = signal(i + 1);
    pair_symbol_count(index, index2) = pair_symbol_count(index, index2)+1;
end

p_pairs = pair_symbol_count/(size(signal, 1) - 1);

p_pairs = p_pairs(find(p_pairs));

%% räkna ut parentropin
% kan använda nansum också
Hxx = awesome_entropy(p_pairs);

%% räkna ut betingade entropin

% H (X , Y ) = H (X ) + H (Y |X )

Hc = Hxx - Hx;

%% Använder färdig huffman-kod

l = huffman(p);
l2 = huffman(p_pairs);    

%% en loop som beräknar skillnaden Y_i = Xi - Pi där Pi = Xi-1

Y_i = signal - skift(signal,1);

Y_i = Y_i - min(Y_i)+1;

pY = awesome_distribution(Y_i);
Hy = awesome_entropy(pY);
ly = huffman(pY);

%% en loop som beräknar skillnaden Y_i = Xi - Pi där Pi2 = 2*Xi-1-Xi-2

P_i2= 2*skift(signal,1) - skift(signal,2);
Y_i2 = signal - P_i2;

Y_i2 = Y_i2 - min(Y_i2)+1;


pY2 = awesome_distribution(Y_i2);
Hy2 = awesome_entropy(pY2);
ly2 = huffman(pY2);

function y=skift(signal,steps)
    y = zeros(size(signal));
    y(steps+1:end) = signal(1:end-steps);
end
