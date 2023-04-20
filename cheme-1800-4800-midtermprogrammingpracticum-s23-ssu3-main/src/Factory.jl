# === PRIVATE METHODS BELOW HERE ========================================================================================= #

"""
_build_bounds_array(data::Dict{String,Any}) -> Array{Float64,2}

The function is taking each compound in the reaction from the JSON file and creating a matrix where each row is a compound and each column is its lower and upper bound. 
"""
function _build_bounds_array(data::Dict{String,Any})::Array{Float64,2}

    # initialize -
    list_of_reactions = data["reactions"];
    number_of_reactions = length(list_of_reactions)
    bounds_array = Array{Float64,2}(undef,number_of_reactions,2)

    # TODO: fill in the entries of the bounds array, first col is the lower bound, second col is the upper bound
    # HINT see PS6 
    for i ∈ 1:number_of_reactions
        reaction = list_of_reactions[i];
        L = reaction["lower_bound"];
        U = reaction["upper_bound"];
        bounds_array[i,1] = L
        bounds_array[i,2] = U
    end

    # return -
    return bounds_array
end

"""
_build_reaction_id_array(data::Dict{String,Any}) -> Array{String,1}

The function is taking a list of reactions dictionary from the JSON file. In each reaction, it takes out "id" in the reactions dictionary and fills an array for each compound's respective id. 
"""
function _build_reaction_id_array(data::Dict{String,Any})::Array{String,1}
    
    # initialize -
    reaction_id_array = Array{String,1}()

    # TODO: fill the reaction_id_array with the reaction id's from the data dictionary
    # HINT see PS6 
    reactions = data["reactions"];
    for reaction ∈ reactions
        id_value = reaction["id"]
        push!(reaction_id_array, id_value);
    end

    # return -
    return reaction_id_array;
end

"""
_build_metabolite_id_array(data::Dict{String,Any}) -> Array{String,1}

The function is taking a list of reactions dictionary from the JSON file. In each reaction, it takes out "metabolite" in the reactions dictionary and fills an array for each compound's respective id. 
"""
function _build_metabolite_id_array(data::Dict{String,Any})::Array{String,1}

    # initialize -
    metabolite_id_array = Array{String,1}()

    # TODO: fill the metabolite_id_array with the metabolite id's from the data dictionary
    # HINT see PS6 
    metabolites = data["metabolites"];
    for metabolite ∈ metabolites
        id_value = metabolite["id"];
        push!(metabolite_id_array, id_value);
    end
    # return -
    return metabolite_id_array;
end

"""
_build_stoichiometric_matrix(data::Dict{String,Any}) -> Array{Float64,2}

The function is taking the original data dictionary in the JSON file. It takes the list of metabolites and the list of reactions and loops through the list of metabolites. 
For each metabolite, it goes through a inner loop of reactions. If the metabolite takes part in the reaction, it will fill the array with the stoichiometric value for the specified metabolite. 
"""
function _build_stoichiometric_matrix(data::Dict{String,Any})::Array{Float64,2}
    
    # initialize -
    list_of_metabolites = data["metabolites"];
    list_of_reactions = data["reactions"];
    number_of_reactions = length(list_of_reactions);
    number_of_metabolites = length(list_of_metabolites);
    S = Array{Float64,2}(undef, number_of_metabolites, number_of_reactions);
    
    # TODO: fill in the entries of the stochiometric matrix
    # HINT see PS6 

    # fill w/zeros -
    fill!(S,0.0);

    # build the stochiometric matrix -
    for i ∈ 1:number_of_metabolites
        
        # get a metabolite -
        metabolite_id = list_of_metabolites[i]["id"]
        
        for j ∈ 1:number_of_reactions

            # grab the reaction object, and then metabolites dictionary -
            metabolite_dictionary = list_of_reactions[j]["metabolites"]
            if (haskey(metabolite_dictionary, metabolite_id) == true)
                S[i,j] = metabolite_dictionary[metabolite_id];
            end
        end
    end

    # return -
    return S
end

"""
TODO: Fill me in
"""
function _build_composition_dictionary(compound::String)::Dict{Char,Float64}

    # initialize -
    composition_dictionary = Dict{Char,Float64}()

    # TODO: Fill in the composition_dictionary for this compound -
    # HINT: See PS2 
    # ...

    # return -
    return composition_dictionary;
end

"""
TODO: Fill me in
"""
function _build_atom_matrix(compounds::Array{MyChemicalCompoundModel,1})::Array{Float64,2}

    # initialize -
    number_of_atoms = 6 # we are going to balance on {C,H,N,O,P,S}
    number_of_compounds = length(compounds);
    atom_matrix = Array{Float64,2}(undef, number_of_atoms, number_of_compounds);

    # TODO: Fill in the elements of the atom_matrix -
    # ...

    # return -
    return atom_matrix;
end

# ======================================================================================================================== #

# === PUBLIC METHODS BELOW HERE ========================================================================================== #

"""
    build(type::Type{MyChemicalCompoundModel}, name::String, compound::String)::MyChemicalCompoundModel

Factory method to build an instance of the MyChemicalCompoundModel type. MyChemicalCompoundModel is a model of the
information contained in the JSON model file
"""
function build(type::Type{MyChemicalCompoundModel}, name::String, compound::String)::MyChemicalCompoundModel

    # check: name, reactants and products correct?
    # in production, we'd check this. Assume these are ok now

    # initialize -
    model = MyChemicalCompoundModel(); # build an empty model 

    # add data to the model -
    model.name = name;
    model.compound = compound;
    model.composition = _build_composition_dictionary(compound);

    # return -
    return model;
end

"""
TODO: Fill me in
"""
function build(type::Type{MyStoichiometricNetworkMatrixModel}, data::Dict{String,Any})::MyStoichiometricNetworkMatrixModel

    # build an empty instance of our model -
    model = MyStoichiometricNetworkMatrixModel();

    # construct model elements -
    model.species = _build_metabolite_id_array(data);
    model.reactions = _build_reaction_id_array(data);
    model.bounds = _build_bounds_array(data);
    model.S = _build_stoichiometric_matrix(data);

    # return -
    return model;
end

"""
TODO: Fill me in
"""
function build(type::Type{MyAtomCompoundMatrixModel}, compounds::Array{MyChemicalCompoundModel,1})::MyAtomCompoundMatrixModel

    # build an empty compound model -
    model = MyChemicalCompoundModel();

    # construct the model elements, add them to the model -
    model.compounds = compounds;
    model.A = _build_atom_matrix(compounds);

    # return -
    return model;
end
# ======================================================================================================================== #