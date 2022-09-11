function [resultado] = identificarImagem(nomeRede , nomeFicheiro , imagem)

    caminhoRede = append("Out\Redes\B_Best\",nomeRede);
    if(nomeFicheiro ~= "null")
        caminhoImagem = append("Imagens\start\square\",nomeFicheiro);
    else
        caminhoImagem = nomeFicheiro;
    end
    load(caminhoRede , 'net');

    matrizBinaria = imagemBinaria(caminhoImagem , imagem);
    out = sim(net , matrizBinaria);
    [~,b] = max(out);

    switch(b)
        case 1
            resultado = "circle";

        case 2
            resultado = "kite";

        case 3
            resultado = "parallelogram";

        case 4 
            resultado = "square";

        case 5 
            resultado = "trapezoid";

        case 6 
            resultado = "triangle";

        otherwise
            resultado = "Não foi possivel identificar";
    end

end