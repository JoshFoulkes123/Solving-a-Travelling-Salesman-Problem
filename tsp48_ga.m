function [best_distance best_tour] = tsp48_ga(inputcities,popSize,elites_per,crossover)

%intialisation
num_cities = length(inputcities);
% crossover_prob = 0.95;
% num_elites = floor(pop_size * 0.2);
% pop_size = 5;

%Hyperparameters
pop_size = popSize;
num_elites = ceil(pop_size * elites_per);
num_parents = pop_size-num_elites;
crossover_prob = crossover;
mutation_prob = 1/num_cities;

%max iterarition
max_gen = floor(10000/pop_size);

%representation

%intial distribution
pop = randperm(num_cities);
for a = 2 : pop_size
    pop = cat(1,pop,randperm(num_cities));
end
pop;
fitness_track =3;

for gen =1 : max_gen-1

    %fitness calculation
    fitness_mat = zeros(pop_size,1);
    for i = 1 : pop_size
        init_cities_coordinates = inputcities(:,pop(i,:));
        fitness_mat(i,1) = distance(init_cities_coordinates);
        
    end

    if gen == 1
        fitness_track = min(fitness_mat);
    else
        fitness_track = cat(2,fitness_track,min(fitness_mat));
    end
    
    order = zeros(pop_size,1);
    order(:,1)=1:pop_size;
    ordered_fitness = sortrows(cat(2,fitness_mat,order),1,"ascend");
    
    
    %selection
    fitness_mat_s = max(fitness_mat)+100-fitness_mat;  %reverse fitness 
    for i = 1:pop_size % Begin: Compute Cumulative Distribution
        if i ==1 %.
            FCD(i) = fitness_mat_s(i); %...
        else %.....
            FCD(i) = FCD(i-1) + fitness_mat_s(i);%...
        end %.
    end
    r1 = rand(num_parents,1)*FCD(end);
    parents = zeros(num_parents,num_cities);
    for i = 1:num_parents
        idx = find(FCD >= r1(i),1);
        parents(i,:) = pop(idx,:);
    end

    %Reproduction

    rows = size(parents);
    P = randperm(rows(1));
    parents = parents(P, : );
    children =0;
    for i = 1:ceil(num_parents/2)
        parent_1 = parents(i*2-1,:);
        par_1= perm_to_inv(parents(i*2-1,:));
        if i*2 > num_parents
            parent_2 = parents(1,:);
            par_2 = perm_to_inv(parents(1,:));
        else
            parent_2 = parents(i*2,:);
            par_2= perm_to_inv(parents(i*2,:));
        end
        CrossoverIndex = randperm(num_cities,1);
        for k = 1 : size(CrossoverIndex,2)
            c1 = [par_1(1:CrossoverIndex) par_2(CrossoverIndex+1:end)];
            c2 = [par_2(1:CrossoverIndex) par_1(CrossoverIndex+1:end)];
        end
        c1 = inv_to_perm(c1);
        c2 = inv_to_perm(c2);
        rndm = rand();
        if rndm > crossover_prob
            c1 = parent_1;
            c2 = parent_2;
        end
        if i ==1
            children = c1;
            children = cat(1,children,c2);
        else
    
            children = cat(1,children,c1);
            children = cat(1,children,c2);
        end
    end
    children= children(1:num_parents,:);

    for n = 1 : num_parents

        curr_child = children(n,:);

        for m = 1: num_cities
            rnum = rand();
            if rnum < mutation_prob
                swap_idx(1) = randperm(num_cities,1);
                swap_idx(2) = std_dev(48,swap_idx(1),1,2);
                swap_idx = sort(swap_idx);
                curr_child=twoopt(curr_child, swap_idx(1), swap_idx(2));
            end       
        end
        children(n,:)= curr_child;
    end
    
    %elites
    elites = zeros(num_elites,num_cities);
    for i = 1:num_elites
        idx = ordered_fitness(i,2);
        elites(i,:) = pop(idx,:);
    end
    
    
    %combination of children, mutated population and elites to form new
    %population
    pop = cat(1,children,elites);

    if mod(gen,10)==0
        pop;
    end

end

%fitness calculation
fitness_mat = zeros(pop_size,1);
for i = 1 : pop_size
    init_cities_coordinates = inputcities(:,pop(i,:));
    fitness_mat(i,1) = distance(init_cities_coordinates);
    
end

fitness_track = cat(2,fitness_track,min(fitness_mat));
order = zeros(pop_size,1);
order(:,1)=1:pop_size;
ordered_fitness = sortrows(cat(2,fitness_mat,order),1,"ascend");

%output

best_tour = pop(ordered_fitness(1,2),:);
best_distance = fitness_track(end);
best_cities_coordinates = inputcities(:,best_tour);
% figure
plotcities(best_cities_coordinates)

% x = linspace(0,1,max_gen);
% figure
% plot(x,fitness_track)
