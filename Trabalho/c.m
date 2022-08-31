clc;
clear;
close all;

load('Trabalho\Redes\C_RedeTreino' , 'net');
caminho = dir('Trabalho\Imagens\start\**\*.png');
ficheiroCaminho = string({caminho.folder}) + '/' + string({caminho.name});
str = ficheiroCaminho;
i = 1;
count = 0;

for st = str
    count = count + 1;
end

disp(count);

img_res = [28 28];    %Tamanho do redimensionamento das imagens
matrizBinaria = zeros(img_res(1) * img_res(2) * 3 , count);


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
    %img = rgb2gray(img);
    img = imresize(img , img_res);


    imagemBinaria = imbinarize(img); %usado para criar uma imagem binaria
    matrizBinaria( : , i) =  reshape(imagemBinaria , 1 , []);    %dar reshape do array e colocar a imagem binaria

    i = i + 1;

end

linha1 = repelem(1 , 5);
linha2 = repelem(2 , 5);
linha3 = repelem(3 , 5);
linha4 = repelem(4 , 5);
linha5 = repelem(5 , 5);
linha6 = repelem(6 , 5);
targetMatrix = [linha1 , linha2 , linha3 , linha4 , linha5 , linha6];

targetMatrix = onehotencode(targetMatrix , 1 , 'ClassNames' , 1:6);  %especificar as classes para serem codificadas obter dados logicos

out = sim(net , matrizBinaria);

r = 0;
for i = 1 : size(out , 2)
    [~ , b] = max(out(:,i));
    [~ , d] = max(targetMatrix(: , i));
    if b == d
        r = r + 1;
    end
end


plotconfusion(targetMatrix , out)
accuracy = (r / size(out , 2) ) * 100;
fprintf('Precisa total = %f\n' , accuracy);

%Guardar Rede
rede = "Trabalho\Redes\C_RedeTreino" + ".mat";
save(rede , 'net');

