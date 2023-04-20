abstract type AbstractChemicalCompoundModel end

"""
    MyChemicalCompoundModel

Holds data for the chemical compound records
"""
mutable struct MyChemicalCompoundModel <: AbstractChemicalCompoundModel

    # data -
    name::String
    compound::String
    composition::Dict{Char,Float64}

    # constuctor
    MyChemicalCompoundModel() = new()
end

"""
MyStoichiometricNetworkMatrixModel

Holds data for the stoichiometric coefficient records for each reaction
"""
mutable struct MyStoichiometricNetworkMatrixModel

    # data -
    S::Array{Float64,2}
    bounds::Array{Float64,2}
    species::Array{String,1}
    reactions::Array{String,1}

    # constructor -
    MyStoichiometricNetworkMatrixModel() = new()
end

"""
MyAtomCompoundMatrixModel

The variable compounds stores the list of compounds.
The matrix A: Each column represents the atoms of each element and each row represents a specific compound. 
"""
mutable struct MyAtomCompoundMatrixModel

    # data -
    A::Array{Float64,2}
    compounds::Array{MyChemicalCompoundModel,1}

    # constructor -
    MyAtomCompoundMatrixModel() = new()
end