
"""
Creation of a mutable structure that is a stoichiometric matrix where the reactions are the columns of the matrix and the species are the rows of the matrix.
    mutable struct MyStoichiometricNetworkModel
"""
mutable struct MyStoichiometricNetworkModel

    # data -
    S::Array{Float64,2}
    bounds::Array{Float64,2}
    species::Array{String,1}
    reactions::Array{String,1}

    # constructor -
    MyStoichiometricNetworkModel() = new()
end