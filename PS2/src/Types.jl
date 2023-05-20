abstract type AbstractChemicalCompoundModel end

"""
    MyChemicalCompoundModel

Holds data for the chemical compound records
"""
mutable struct MyChemicalCompoundModel <: AbstractChemicalCompoundModel

    # data -
    name::String
    compound::String
    composition::Dict{String,Int}

    # constuctor
    MyChemicalCompoundModel() = new()
end