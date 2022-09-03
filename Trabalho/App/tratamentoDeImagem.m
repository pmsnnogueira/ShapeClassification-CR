function [matrizBinaria, targetMatrix] = tratamentoDeImagem(nomePasta)

    disp(nomePasta)
    
    switch nomePasta
        case "start"
            caminho = dir('Trabalho\Imagens\start\**\*.png');
            colunas = 5;
        case "train"
            caminho = dir('Trabalho\Imagens\train\**\*.png');
            colunas = 50;
        case "test"
            caminho = dir('Trabalho\Imagens\test\**\*.png');
            colunas = 10;
        case "extra"
            caminho = dir('Trabalho\Imagens\extra\**\*.png');
        otherwise
            return;
    end
    
    
    ficheiroCaminho = string({caminho.folder}) + '/' + string({caminho.name});
    str = ficheiroCaminho;
    i = 1;
    count = 0;
    
    
    
    for st = str
        count = count + 1;
    end
    
    disp(count);
    
    img_res = [28 28];    %Tamanho do redimensionamento das imagens
    matrizBinaria = zeros(img_res(1) * img_res(2) , count);
    
    
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
        img = imresize(img , img_res);
        img = rgb2gray(img);
    
    
    
        imagemBinaria = imbinarize(img); %usado para criar uma imagem binaria
        matrizBinaria( : , i) =  reshape(imagemBinaria , 1 , []);    %dar reshape do array e colocar a imagem binaria
    
        i = i + 1;
    
    end
    
    linha1 = repelem(1 , colunas);
    linha2 = repelem(2 , colunas);
    linha3 = repelem(3 , colunas);
    linha4 = repelem(4 , colunas);
    linha5 = repelem(5 , colunas);
    linha6 = repelem(6 , colunas);
    targetMatrix = [linha1 , linha2 , linha3 , linha4 , linha5 , linha6];
    
    targetMatrix = onehotencode(targetMatrix , 1 , 'ClassNames' , 1:6);  %especificar as classes para serem codificadas obter dados logicos
    
end