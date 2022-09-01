clc;
clear;
close all;

neuronios = 10;
camadas = [neuronios neuronios neuronios neuronios neuronios neuronios];

caminho = dir('Trabalho\Imagens\start\**\*.png');

fileID = fopen("a_testes.csv", "a");

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

%Treinar a Matriz
net = feedforwardnet([neuronios]);     %10 neuronios

%Configurar as Camadas
%funcao de treino

%Tentar fazer depois passar estes valores por parametros !!!!
net.trainFcn = 'trainbr';

net.layers{end}.transferFcn = 'purelin';    %funcoes de ativacao da camada de saida
net.layers{1:end-1}.transferFcn = 'tansig'; %funcoes de ativacao das camadas escondidas

net.divideFcn = 'dividerand';

net.divideParam.trainratio = 0.70;

net.divideParam.valRatio = 0.15;

net.divideParam.testRatio = 0.15;

%Numero de treino
net.trainParam.epochs = 1000;  %1000 por default

%Treinar a rede

[net,tr] = train(net , matrizBinaria , targetMatrix);

out = net(matrizBinaria);
disp(tr);

r = 0;

for i = 1 : size(out , 2)
    [~ , c] = max(out(:,i));
    [~ , e] = max(targetMatrix(: , i));
    if c == e
        r = r + 1;
    end
end

accuracy_global = (numel(find(targetMatrix == uint8(round(out)))) / numel(targetMatrix))*100;
fprintf(fileID, "%d_topologia,%s_fTreino,%s_fCamadaSaida,%s_fCamadaEntrada,%s_fDivisao,%f_trainRatio,%f_valRation,%f_testRatio," + ...
    "%d_epochs,%f_accuracy\n", neuronios,net.trainFcn , ...
net.layers{end}.transferFcn,...
net.layers{1:end-1}.transferFcn,net.divideFcn,net.divideParam.trainratio ,...
net.divideParam.valRatio,net.divideParam.testRatio,net.trainParam.epochs, ...
accuracy_global);

fprintf('Precisa Global = %f\n' , accuracy_global);

fclose(fileID);








