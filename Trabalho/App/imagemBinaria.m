function[matrizBinaria] = imagemBinaria(caminhoImagem , imagem)

    img_res = [28 28];    %Tamanho do redimensionamento das imagens
    matrizBinaria = zeros(img_res(1) * img_res(2) , 1);
   
    if (caminhoImagem == "null")

         img = imresize(imagem , img_res);
    else

        img = imread(caminhoImagem);
        img = rgb2gray(img);
        img = imresize(img , img_res);
    
    end
    
    imagemBinaria = imbinarize(img); %usado para criar uma imagem binaria
    matrizBinaria( : , 1) =  reshape(imagemBinaria , 1 , []);    %dar reshape do array e colocar a imagem binaria
    
end