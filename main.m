clear all
load("cities.mat")

test_size = 30;
out_ga = zeros(1,test_size);
out_sa = zeros(1,test_size);

%%%%simulated annealing

overall_best_dist = 10000000;
overall_best_route = 0;

avg_distance = 0;
for i =1 :test_size
    [best_distance best_route] = tsp48_sa(cities,10000,0.999,0.01);

    if best_distance < overall_best_dist
        overall_best_route = best_route;
        overall_best_dist = best_distance;
    end
    out_sa(i) = best_distance;
    best_distance
    avg_distance = avg_distance + best_distance;

end
avg_distance = avg_distance/30
% best_cities_coordinates = cities(:,overall_best_route);
% plotcities(best_cities_coordinates);


%%%%genetic algorithm

overall_best_dist = 10000000;
overall_best_route = 0;

avg_distance = 0;
for i =1 :test_size
    [best_distance best_route] = tsp48_ga(cities,5,0.3,0.9);

    if best_distance < overall_best_dist
        overall_best_route = best_route;
        overall_best_dist = best_distance;
    end
    out_ga(i) = best_distance;
    best_distance
    avg_distance = avg_distance + best_distance;

end
avg_distance = avg_distance/30
% best_cities_coordinates = cities(:,overall_best_route);
% plotcities(best_cities_coordinates);

%%%%wilcoxon signed rank test

[p,h,stats] = signrank(out_ga,out_sa)


