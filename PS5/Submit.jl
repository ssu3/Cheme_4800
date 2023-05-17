# TODO: Fill me in with your program to compute the uknown model parameters from the data

include("Include.jl")
ps5_dataset=joinpath(_PATH_TO_DATA,"PS5-dataset-w-repeats.csv")

dataset=loaddataset(ps5_dataset)

X = build_data_matrix(dataset)
Y = build_output_vector(dataset)
Beta = inv(transpose(X)*X)*transpose(X)*Y

error=build_error_distribution(Y-X*Beta)

samples = 50000
parameters=2
simulated_parameters= Array{Float64,2}(undef,samples,2)
for s ∈ 1:samples
    β = Beta - inv(transpose(X)*X)*transpose(X)*rand(error,300)
    for p ∈ 1:parameters
        simulated_parameters[s,p] = β[p]
    end
end
μ_beta_1 = mean(simulated_parameters[:,1]);
μ_beta_2 = mean(simulated_parameters[:,2]);

σ_beta_1 = std(simulated_parameters[:,1]);
σ_beta_2 = std(simulated_parameters[:,2]);

header = ["Parameters","Actual","μ","σ"]
#initialize table for normal distribution parameters comparison to actual parameter values
table = Array{Any,2}(undef, 2,4);
table[1,1] = "Beta 1"
table[2,1] = "Beta 2"
table[1,2] = Beta[1];
table[2,2] = Beta[2];
table[1,3] = μ_beta_1
table[1,4] = σ_beta_1
table[2,3] = μ_beta_2
table[2,4] = σ_beta_2
pretty_table(table; header)
