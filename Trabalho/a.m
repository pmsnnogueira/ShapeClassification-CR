clc;
clear;
close all;

neuronios = 50;

fileID = fopen("a_testes.csv", "a");

[matrizBinaria,targetMatrix]=tratamentoDeImagem("start");

%Treinar a Matriz
net = feedforwardnet([neuronios neuronios neuronios]);     %10 neuronios

%Configurar as Camadas
%funcao de treino

%Tentar fazer depois passar estes valores por parametros !!!!
net.trainFcn = 'traingdx';

net.layers{end}.transferFcn = 'purelin';    %funcoes de ativacao da camada de saida
net.layers{1:end-1}.transferFcn = 'tansig'; %funcoes de ativacao das camadas escondidas

net.divideFcn = '';

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

accuracy_global = (r/size(out,2)*100);

fprintf(fileID, "%d_topologia,%s_fTreino,%s_fCamadaSaida,%s_fCamadaEntrada,%s_fDivisao" + ...
    "%d_epochs,%f_accuracy\n", neuronios,net.trainFcn , ...
net.layers{end}.transferFcn,...
net.layers{1:end-1}.transferFcn,net.divideFcn,...
net.trainParam.epochs, ...
accuracy_global);

fprintf('Precisa Global = %f\n' , accuracy_global);

fclose(fileID);








