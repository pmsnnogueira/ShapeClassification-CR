function [accuracy_global] = treinamentoDeRede(topologia,matrizBinaria,targetMatrix,epochsValue,trainFuction, ...
                                               fuctionActivationHidden,fuctionActivationOutput,fuctionDivision, ...
                                               trainValue,validateValue,testValue)

    disp(targetMatrix)
    %Treinar a Matriz
    net = feedforwardnet([topologia]);
    
    %Configurar as Camadas
    %funcao de treino
    
    %Tentar fazer depois passar estes valores por parametros !!!!
    net.trainFcn = trainFuction;
    
    net.layers{end}.transferFcn = fuctionActivationOutput;    %funcoes de ativacao da camada de saida
    net.layers{1:end-1}.transferFcn = fuctionActivationHidden; %funcoes de ativacao das camadas escondidas
    
    net.divideFcn = fuctionDivision;

    net.divideParam.trainratio = trainValue;

    net.divideParam.valRatio = validateValue;
    
    net.divideParam.testRatio = testValue;
    
    %Numero de treino
    net.trainParam.epochs = epochsValue;  %1000 por default
    
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
    
    accuracy_global = (r/size(out,2)*100);
end