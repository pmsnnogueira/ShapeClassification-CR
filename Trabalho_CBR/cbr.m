function [] = cbr()
    
     case_library = readtable('13Melbourne_Samples_SelectAtribs_SemBedroom2.xlsx', ...
                              'Format','auto');