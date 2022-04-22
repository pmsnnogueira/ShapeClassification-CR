function [journey, new_case] = revise(retrieved_cases, new_case, new_price)
    
    retrieved_codes = retrieved_cases{:,1};
    code = str2double('-');
        
    while isnan(code) || fix(code) ~= code || ismember(code, retrieved_codes) == 0
        fprintf('From the retrieved cases, which is the one that better matches your journey?\n');
        code = str2double(input('Journey Code: ','s'));
    end
    
    journey = fix(code);
    %REVISE Holiday type
    lista = {'Active', 'Bathing', 'City', 'Education', 'Language', 'Recreation', 'Skiing', 'Wandering'}; 
    fprintf('\nUpdate holiday type? (y/n)\n');
    option = input('Option: ', 's');

    if option == 'y' || option == 'Y'
        v = input('Holiday Type?','s');
        while(~ismember(lista, v))
            v = input('Holiday Type?');
        end
        new_case.holiday_type = v;
    end

    %REVISE Price
    if new_price == -1
        fprintf("\nUpdate your price (y\n)\n");
        option = input('Option: ', 's');
        if option == 'y' || option == 'Y'
            p = str2double('-');
            while isnan(p)
                 p = str2double(input('Price: ','s'));
            end
        end
    else
        fprintf('\nUpdate your journey price with the new estimated value? (y/n)\n');
        option = input('Option: ', 's');
        if option == 'y' || option == 'Y'
            new_case.price = new_price;
        end
    end
    
        %REVISE Number Of Persons
        fprintf('\nUpdate number of persons? (y/n)\n');
        option = input('Option: ', 's');
    
        if option == 'y' || option == 'Y'
            npersons = str2double('-');
            while isnan (npersons)
                npersons = str2double(input('Number of persons: '));
            end 
            new_case.number_persons = npersons;
        end
end
