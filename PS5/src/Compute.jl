"""
    build_data_matrix(data::DataFrame) --> Array{Float64,2}

This function builds an X matrix utilizing data from DataFrame. 
The matrix is a (R*3)x(2) matrix where the rows sum to the total
number of experiments for S concentrations and the first column takes 
on values of 1.0 while the second column takes on values of (1/S). 
"""
function build_data_matrix(data::DataFrame)::Array{Float64,2}

    experiments = 3;
    (R,C) = size(data);
    X = Array{Float64,2}(undef, experiments*R, 2);
    concentration = Array{Float64,1}();
    for i ∈ 1:R
        substrate = data[i,:S];
        for j ∈ 1:experiments
            push!(concentration,(1/substrate));
        end
    end
    
    for i ∈ 1:experiments:(experiments*R)
        for j ∈ i:(i+experiments-1)
            substrate = concentration[j];
    
            X[j,1] = 1.0;
            X[j,2] = substrate
        end
    end

    return X
end


"""
    build_output_vector(data::DataFrame) --> Array{Float64,1}

    This function builds an Y matrix utilizing data from DataFrame. 
    The matrix is a (R*3)x(1) matrix where the rows sum to the total
    number of experiments for S concentrations and the first column takes 
    on values of 1/v; the inverse rate of reaction. 
"""
function build_output_vector(data::DataFrame)::Array{Float64,1}
    
    experiments = 3;
    (R,C) = size(data);

    Y = Array{Float64,1}();
    for i ∈ 1:R
        for j ∈ 1:experiments
            v = data[i,j+1];
            push!(Y, (1/v));
        end
    end
    
    return Y
end

"""
    build_error_distribution(residuals::Array{Float64,1}) -> Normal

Takes error found between the data point and the model equation y-output and creates a 
normal distribution by calculating the sample mean and sample variance of the error difference. 

"""
function build_error_distribution(residuals::Array{Float64,1})::Normal

    # initialize -
    μ = 0.0; # default value, replace with your value
    σ = 0.0; # default value, replace with your value
    
    μ = mean(residuals)
    σ = std(residuals)
    
    # return -
    return Normal(μ, σ);
end

