clc;
clear;
close all;

load('Trabalho\Out\Redes\C\C_Best\C_RedeAllTreino_Accuracy98.3333_test' , 'net');

[matrizBinaria,~]=tratamentoDeImagem("extra");

out = round(sim(net , matrizBinaria));

r = 0;

for i = 1 : size(out , 2)
    [~ , b] = max(out(:,i));

    switch(b)
        case 1
            fprintf("circle\n");

        case 2
            fprintf("kite\n");

        case 3
            fprintf("parallelogram\n");

        case 4
            fprintf("square\n");

        case 5
            fprintf("trapezoid\n");

        case 6
            fprintf("triangle\n");

        otherwise
            fprintf("Não foi possivel identificar");
    end
end