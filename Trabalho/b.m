clc;
clear;
close all;

neuronios = 10;
camadas = [neuronios neuronios neuronios neuronios neuronios neuronios];
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

linha1 = repelem(1 , 10);
linha2 = repelem(2 , 10);
linha3 = repelem(3 , 10);
linha4 = repelem(4 , 10);
linha5 = repelem(5 , 10);
linha6 = repelem(6 , 10);
targetMatrix = [linha1 , linha2 , linha3 , linha4 , linha5 , linha6];

targetMatrix = onehotencode(targetMatrix , 1 , 'ClassNames' , 1:6);  %especificar as classes para serem codificadas obter dados logicos

%Treinar a Matriz
net = feedforwardnet(camadas);     %6 neuronios

%Configurar as Camadas
%funcao de treino
%Variaveis

trainRatio = 0.70;
valRatio = 0.15;
testRatio = 0.15;
%Tentar fazer depois passar estes valores por parametros !!!!
net.trainFcn = 'traingdx';

net.layers{end}.transferFcn = 'purelin';    %funcoes de ativacao da camada de saida
net.layers{1:end-1}.transferFcn = 'tansig'; %funcoes de ativacao das camadas escondidas

net.divideFcn = 'dividerand';

net.divideParam.trainratio = trainRatio;

net.divideParam.valRatio = valRatio;

net.divideParam.testRatio = testRatio;

%Numero de treino
net.trainParam.epochs = 1000;  %1000 por default



%Treinar a rede

[net,tr] = train(net , matrizBinaria , targetMatrix);
out = net(matrizBinaria);
disp(tr);

TInput = matrizBinaria(:, tr.testInd);
TTargetss = targetMatrix(:, tr.testInd);

r = 0;
for i = 1 : size(out , 2)
    [~ , c] = max(out(:,i));
    [~ , e] = max(targetMatrix(: , i));
    if c == e
        r = r + 1;
    end
end


accuracy_test = numel(find(targetMatrix(tr.testInd) == uint8(round(out(tr.testInd))))) / numel(tr.testInd);
fprintf('Precisão Teste = %f\n' , accuracy_test*100);

accuracy_global = numel(find(targetMatrix == uint8(round(out)))) / numel(targetMatrix);
fprintf('Precisão Global = %f\n' , accuracy_global*100);

plotconfusion(targetMatrix,out); %% plot da matriz de confusão

%% Save best neural networks


if (accuracy_global >= 0.8)
    
    stringCamadas = extractAfter(num2str(size(camadas)),3);

    numChar = strfind(num2str(round(accuracy_global , 2)),'.') + 1;
    ValorAccuracy = extractBefore(num2str(accuracy_global * 100, 2) , numChar);
    nomeRede = "Trabalho/Out/Redes/B_TreinoPoligno_" + net.trainFcn + "_TrainR" + num2str(trainRatio) + "_VR" + num2str(valRatio) + "_TestR" + num2str(testRatio) +"_Camadas" + stringCamadas + "_Accuracy" + ValorAccuracy + ".mat";
    nomeConfusion= "Trabalho/Out/Confusion/B_Confusion_" + net.trainFcn + "_TrainR" + num2str(trainRatio) + "_VR" + num2str(valRatio) + "_TestR" + num2str(testRatio) +"_Camadas " + stringCamadas + "_Accuracy" + ValorAccuracy + ".fig";


    savefig(nomeConfusion); %salvar a matriz de confusao
    save(nomeRede, 'net');  %salvar a melhor rede

end









