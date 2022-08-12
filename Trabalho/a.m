clc;
clear;
close all;

neuronios = 10;
camadas = [];
caminho = dir('Trabalho\Imagens\start\**\*.png');

ficheiroCaminho = string({caminho.folder}) + '/' + string({caminho.name});
str = ficheiroCaminho;
i = 1;
count = 0;



for st = str
    count = count + 1;
end

disp(count);

img_res = [25 25];    %Tamanho do redimensionamento das imagens
matrizBinaria = zeros(img_res(1) * img_res(2) * 3 , count);


for st = str
    
    numChar = strfind(st , ".");
    S = extractBefore(st , numChar);
    numChar1 = strfind(S , "/");

    St2 = extractBefore(S , numChar1);
    numChar2 = strfind(S , "/");

    St3 = extractAfter(S , numChar2);
    fileStList = St2 + '\' + St3 + '.png';
    stt = sprintf(fileStList);

   % img = imread(str)
  %  img = rgb2gray(img);
  %  img = imresize(img , img_res);
  %  binarizedImg = imbinarize(img);
   % matrizBinaria(: , count) = reshape(binarizedImg , 1 ,[]);
end