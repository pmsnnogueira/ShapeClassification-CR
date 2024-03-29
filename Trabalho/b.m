clc;
clear;
close all;

neuronios = 10;

camadas = [neuronios];

[matrizBinaria,targetMatrix]=tratamentoDeImagem("train");

%Treinar a Matriz
net = feedforwardnet(camadas);     %10 neuronios

%Configurar as Camadas
%funcao de treino
%Variaveis

trainRatio = 0.7;
valRatio = 0.15;
testRatio = 0.15;

%Tentar fazer depois passar estes valores por parametros !!!!
net.trainFcn = 'trainlm';

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

r = 0;

for i = 1 : size(out , 2)
    [~ , c] = max(out(:,i));
    [~ , e] = max(targetMatrix(: , i));
    if c == e
        r = r + 1;
    end
end


accuracy_global = (r/size(out,2));
fprintf('Precisão Global = %f\n' , accuracy_global*100);

plotconfusion(targetMatrix,out); %% plot da matriz de confusão

TInput = matrizBinaria(:, tr.testInd);
TTargetss = targetMatrix(:, tr.testInd);


out = sim(net, TInput);

r=0;
for i=1:size(tr.testInd,2)               
    [~, c] = max(out(:,i));          
    [~, e] = max(TTargetss(:,i));  
    if c == e                       
        r = r+1;
    end
end

accuracy_teste = r/size(tr.testInd,2);
fprintf('Precisao Teste = %f\n', accuracy_teste*100);
plotconfusion(TTargetss, out);

%% Save best neural networks


if (accuracy_global >= 0.8)
    
    stringCamadas = extractAfter(num2str(size(camadas)),3);

    nomeRede = "Trabalho/Out/Redes/B_TreinoPoligno_" + net.trainFcn + "_TrainR" + num2str(trainRatio) + "_VR" + num2str(valRatio) + "_TestR" + num2str(testRatio) +"_Camadas" + stringCamadas + "_Neuronios" + neuronios + "_Accuracy" + accuracy_global + ".mat";
    nomeConfusion= "Trabalho/Out/Confusion/B_Confusion_" + net.trainFcn + "_TrainR" + num2str(trainRatio) + "_VR" + num2str(valRatio) + "_TestR" + num2str(testRatio) +"_Camadas " + stringCamadas + "_Neuronios" + neuronios + "_Accuracy" + accuracy_global + ".fig";


    savefig(nomeConfusion); %salvar a matriz de confusao
    save(nomeRede, 'net');  %salvar a melhor rede

end









