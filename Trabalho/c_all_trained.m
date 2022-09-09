clc;
clear;
close all;

load('Trabalho\Out\Redes\B_Best\B_Best_Network_Accuracy0.98' , 'net');
[matrizBinariaStart,targetMatrixStart]=tratamentoDeImagem("start");
[matrizBinariaTrain,targetMatrixTrain]=tratamentoDeImagem("train");
[matrizBinariaTest,targetMatrixTest]=tratamentoDeImagem("test");

matrizBinaria = [matrizBinariaStart matrizBinariaTrain matrizBinariaTest];
targetMatrix = [targetMatrixStart targetMatrixTrain targetMatrixTest];

[reReTrainedNet, tr] = train(net, matrizBinaria, targetMatrix);

%out = reReTrainedNet(matrizBinariaStart);
%out = reReTrainedNet(matrizBinariaTrain);
out = reReTrainedNet(matrizBinariaTest);
r = 0;

for i = 1 : size(out , 2)
    [a , b] = max(out(:,i));
    %[c , d] = max(targetMatrixStart(: , i));
    %[c , d] = max(targetMatrixTrain(: , i));
    [c , d] = max(targetMatrixTest(: , i));
    if b == d
        r = r + 1;
    end
end


%plotconfusion(targetMatrixStart , out)
%plotconfusion(targetMatrixTrain , out)
plotconfusion(targetMatrixTest , out)

accuracy = (r / size(out , 2) ) * 100;
fprintf('Precisa total = %f\n' , accuracy);

%Guardar Rede
%rede = "Trabalho\Out\Redes\C\C_RedeAllTreino" + "_Accuracy" + accuracy + "_start" + ".mat";
%rede = "Trabalho\Out\Redes\C\C_RedeAllTreino" + "_Accuracy" + accuracy + "_train" + ".mat";
rede = "Trabalho\Out\Redes\C\C_RedeAllTreino" + "_Accuracy" + accuracy + "_test" + ".mat";

save(rede , 'net');

