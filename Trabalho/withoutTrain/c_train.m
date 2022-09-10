clc;
clear;
close all;

%load('Trabalho\Out\Redes\B_Best\B_Best_Network_Accuracy0.98' , 'net');
load('Trabalho\Out\Redes\C\C_RedeReTreino_Accuracy100_test' , 'net');

[matrizBinaria,targetMatrix]=tratamentoDeImagem("train");

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
%rede = "Trabalho\Out\Redes\C\C_Rede" + "_Accuracy" + accuracy + "_train" + ".mat";
rede = "Trabalho\Out\Redes\C\C_Test_RedeTreino" + "_Accuracy" + accuracy + "_train" + ".mat";
save(rede , 'net');

