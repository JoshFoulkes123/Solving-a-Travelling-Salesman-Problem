function [best_distance best_tour] = tsp48_sa(inputcities,temperature,coolingrate,absolutetemp)

%hyperparameters
% Temperature = 1000;
% deltaDistance = 0;
% coolingRate = 0.999;
% absoluteTemp = 0.001;

Temperature = temperature;
deltaDistance = 0;
coolingRate = coolingrate;
absoluteTemp = absolutetemp;

%intialisation
num_cities = length(inputcities);
iter = 10000;
flag = 0;

while iter > 0 && flag==0
    
    % Generate an initial solution
    % You can generate a random solution as the inital solution. 
    % If you execute your algorithm several times, you have the hill climbing
    % algorithm with random restart. 
    best_tour = randperm(num_cities);
    best_cities_coordinates = inputcities(:,best_tour);
    best_distance = distance(best_cities_coordinates);
    iter= iter-1;
    while flag==0 && Temperature > absoluteTemp
        idx = sort(randperm(num_cities,2));
        curr_tour = twoopt(best_tour, idx(1), idx(2));
        curr_cities_coordinates = inputcities(:,curr_tour);
        curr_distance = distance(curr_cities_coordinates);
        iter= iter-1;
        deltaDistance = curr_distance - best_distance;
        if (deltaDistance < 0) || (best_distance > 0 && exp(-deltaDistance / Temperature) > rand())
            best_distance = curr_distance;
            best_tour = curr_tour;
%             plotcities(curr_cities_coordinates);             
        end

        Temperature= Temperature*coolingRate;
        if iter<1
            flag = 1;
            break;
        end

    end   
end


%overall_best_route
best_cities_coordinates = inputcities(:,best_tour);
plotcities(best_cities_coordinates);
end

