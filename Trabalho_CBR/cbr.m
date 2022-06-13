function [] = cbr()

    similarity_threshold = 0.9;

     case_library = readtable('13Melbourne_Samples_SelectAtribs_SemBedroom2.xlsx', ...
                              'Format','auto');
    
    


    % New case data
    new_case.suburb = 'Brighton';
    new_case.address = '119 North Rd';
    new_case.rooms = 4;
    new_case.type = 'u';
    new_case.price = 640000;
    new_case.distance = 2.8;
    new_case.bathroom = 1;
    new_case.car = 1;
    new_case.landsize = 0;
    new_case.buildingarea = 64;
    new_case.yearbuilt = 2003;
    new_case.councilarea = 'Melbourne City Council';

    fprintf('\nStarting retrieve phase...\n\n');

    

    [retrieved_indexes, similarities, new_case] = retrieve(case_library, new_case, similarity_threshold);

    
    %removevars(Tabela,nome_da_coluna);

    
