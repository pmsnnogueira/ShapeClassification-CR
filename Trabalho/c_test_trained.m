clc;
clear;
close all;

load('Trabalho\Out\Redes\B_Best\B_Best_Network_Accuracy0.98' , 'net');

[matrizBinaria,targetMatrix]=tratamentoDeImagem("test");

[net,tr] = train(net , matrizBinaria , targetMatrix);
out = net(matrizBinaria);

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
rede = "Trabalho\Out\Redes\C\C_RedeReTreino" + "_Accuracy" + accuracy + "_test" + ".mat";
save(rede , 'net');

