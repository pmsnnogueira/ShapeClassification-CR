function[accuracy_global] = carregarRede(nomeRede , nomePasta)

    caminhoRede = append("Trabalho\Out\Redes\App\",nomeRede);
    load(caminhoRede , 'net');
    
    [matrizBinaria , targetMatrix] = tratamentoDeImagem(nomePasta);
    
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

end

