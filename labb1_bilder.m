
%% Ladda in bilder
image = double(imread('baboon.png'))+1;
%image = double(imread('boat.png'));
%image = double(imread('woodgrain.png'));

%% Entropin för en symbol

p_single = awesome_distribution_2d(image);
H_single = awesome_entropy(p_single);

%% Entropi för osv

p_horz = awesome_distribution_2d_pair(image,[0 1]);
p_vert = awesome_distribution_2d_pair(image,[1 0]);

H_horz = awesome_entropy(p_horz);
H_vert = awesome_entropy(p_vert);

H_horz_cond = H_horz-H_single;
H_vert_cond = H_vert-H_single;

%% Huffmankodning för single
l_single = huffman(p_single);

%% Koda lite skillnader (huffman för prediktion)
P_horz = padskift(image,[0 1],128);
P_vert = padskift(image,[1 0],128);
P_diag = padskift(image,[1 1],128);

Y1 = minskift(image - P_horz);
Y2 = minskift(image - P_vert);
Y3 = minskift(image - (P_vert + P_horz - P_diag));

%%
p_Y1 = awesome_distribution_2d(Y1);
p_Y2 = awesome_distribution_2d(Y2);
p_Y3 = awesome_distribution_2d(Y3);

H_Y1 = awesome_entropy(p_Y1);
H_Y2 = awesome_entropy(p_Y2);
H_Y3 = awesome_entropy(p_Y3);

l_Y1 = huffman(p_Y1);
l_Y2 = huffman(p_Y2);
l_Y3 = huffman(p_Y3);

function y=minskift(x)
    y = x - min(x)+1;
end