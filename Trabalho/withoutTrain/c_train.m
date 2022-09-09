clc;
clear;
close all;

%load('Trabalho\Out\Redes\B_Best\B_Best_Network_Accuracy0.98' , 'net');
load('Trabalho\Out\Redes\C\C_RedeReTreino_Accuracy100_test' , 'net');
caminho = dir('Trabalho\Imagens\train\**\*.png');
ficheiroCaminho = string({caminho.folder}) + '/' + string({caminho.name});
str = ficheiroCaminho;
i = 1;
count = 0;

for st = str
    count = count + 1;
end

disp(count);

img_res = [28 28];    %Tamanho do redimensionamento das imagens
matrizBinaria = zeros(img_res(1) * img_res(2), count);


for st = str

    numChar = strfind(st , ".");
    S = extractBefore(st , numChar);
    numChar1 = strfind(S , "/");

    St2 = extractBefore(S , numChar1);
    numChar2 = strfind(S , "/");

    St3 = extractAfter(S , numChar2);
    fileStList = St2 + '\' + St3 + '.png';
    %stt = sprintf(fileStList);
    
    img = imread(fileStList);
    img = imresize(img , img_res);
    img = rgb2gray(img);

    imagemBinaria = imbinarize(img); %usado para criar uma imagem binaria
    matrizBinaria( : , i) =  reshape(imagemBinaria , 1 , []);    %dar reshape do array e colocar a imagem binaria

    i = i + 1;

end

linha1 = repelem(1 , 50);
linha2 = repelem(2 , 50);
linha3 = repelem(3 , 50);
linha4 = repelem(4 , 50);
linha5 = repelem(5 , 50);
linha6 = repelem(6 , 50);
targetMatrix = [linha1 , linha2 , linha3 , linha4 , linha5 , linha6];

targetMatrix = onehotencode(targetMatrix , 1 , 'ClassNames' , 1:6);  %especificar as classes para serem codificadas obter dados logicos

out = sim(net , matrizBinaria);

r = 0;
for i = 1 : size(out , 2)
    [a , b] = max(out(:,i));
    [c , d] = max(targetMatrix(: , i));
    if b == d
        r = r + 1;
    end
end


plotconfusion(targetMatrix , out)
accuracy = (r / size(out , 2) ) * 100;
fprintf('Precisa total = %f\n' , accuracy);

%Guardar Rede
%rede = "Trabalho\Out\Redes\C\C_RedeTreino" + "_Accuracy" + accuracy + "_train" + ".mat";
rede = "Trabalho\Out\Redes\C\C_Test_RedeTreino" + "_Accuracy" + accuracy + "_train" + ".mat";
save(rede , 'net');

