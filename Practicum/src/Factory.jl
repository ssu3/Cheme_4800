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
    # ...
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
    # ...
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
    # ...
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
    # ...
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
This is a helper function for the function build_composition_dictionary. 

    _recursive_compound_parser(q::Queue{Char}, element::Array{Char,1},value::Array{Int,1})
    Arguments
    'q::Qeue' : Array data structure that contains the chemical name and the chemical formula separated by a ','.
    'element' : Array data structure that contains the letter name of the element (eg. 'C' for Carbon).
    'value' : Array data structure that contain the subscript number of the element.
    Recursive parser method to encode the string that represents the chemical formula. 
    Return Dict with chemical formula letter as keys and chemical formula subscript as values. 
    TODO: Describe what this function does, the args and what we expect it to return
"""
function _recursive_compound_parser(q::Queue{Char}, element::Array{Char,1},value::Array{Int,1})
    # TODO: Implement me
    if (isempty(q) == true) 
        return nothing
    else 
        next_char = dequeue!(q)
        if (isnumeric(next_char) == false)
            
            push!(element,next_char)
        
        elseif (isempty(q) == false)

            next_char2=dequeue!(q)

            if (isnumeric(next_char2)==true)
                bignum=string(next_char,next_char2)
                numbers2=parse(Int,bignum)
                push!(value,numbers2)
        
            else
                push!(value,parse(Int,next_char))
                push!(element,next_char2)
            end
        else
            push!(value,parse(Int,next_char))
        end
    end

    _recursive_compound_parser(q, element, value);
    
end

function _build_composition_dictionary(compound::String)::Dict{Char,Float64}

    # initialize -
    composition_dict = Dict{Char,Float64}()
    q = Queue{Char}()
    element = Array{Char,1}()
    value = Array{Int,1}()
    # TODO: Fill in the composition_dictionary for this compound -
    # HINT: See PS2 
    # ...
    character_arr = collect(compound)
    for c ∈ character_arr
        enqueue!(q, c);
    end

    # the parsering logic should be written in the _recursive_compound_parser function.

    _recursive_compound_parser(q, element, value);

    #@show (value, model)

    count = 1 
    for (index, letter) ∈ enumerate(element)
        # @show (index, letter)
        composition_dict[letter] = value[index];
        count += 1 
    end

    # return -
    return composition_dict;
end

"""
_build_atom_matrix(compounds::Array{MyChemicalCompoundModel,1}) -> Array{Float64,2}

This function takes an array of type::MyChemicalCompoundModel and it builds a matrix where each row represents a metabolite and each 
column represents the atoms of each element for the specific metabolite. If an element was not present in a metabolite, we assume the atom to equal to 0. 
"""
function _build_atom_matrix(compounds::Array{MyChemicalCompoundModel,1})::Array{Float64,2}

    # initialize -
    number_of_atoms = 6 # we are going to balance on {C,H,N,O,P,S}
    number_of_compounds = length(compounds);
    atom_matrix = Array{Float64,2}(undef, number_of_compounds, number_of_atoms);

    # TODO: Fill in the elements of the atom_matrix -
    # ...
    for j in 1:number_of_compounds
        if haskey(compounds[j].composition, 'C')
            atom_matrix[j,1] = compounds[j].composition['C']
        else 
            atom_matrix[j,1] = 0.0
        end
        if haskey(compounds[j].composition, 'H')
            atom_matrix[j,2] = compounds[j].composition['H']
        else 
            atom_matrix[j,2] = 0.0
        end
        if haskey(compounds[j].composition, 'N')
            atom_matrix[j,3] = compounds[j].composition['N']
        else 
            atom_matrix[j,3] = 0.0
        end
        if haskey(compounds[j].composition, 'O')
            atom_matrix[j,4] = compounds[j].composition['O']
        else 
            atom_matrix[j,4] = 0.0
        end
        if haskey(compounds[j].composition, 'P')
            atom_matrix[j,5] = compounds[j].composition['P']
        else 
            atom_matrix[j,5] = 0.0
        end
        if haskey(compounds[j].composition, 'S')
            atom_matrix[j,6] = compounds[j].composition['S']
        else 
            atom_matrix[j,6] = 0.0
        end
    end

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
build(type::Type{MyStoichiometricNetworkMatrixModel}, data::Dict{String,Any}) -> MyStoichiometricNetworkMatrixModel

The function builds a matrix where the rows represent the metabolite and the columns represent a reaction. 
The matrix is filled with stoichiometric coefficients, where a positive value represents a metabolite that 
is a product and a negative value represents a metabolite that is a reactant in each respective reaction. 
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
build(type::Type{MyAtomCompoundMatrixModel}, compounds::Array{MyChemicalCompoundModel,1}) -> MyAtomCompoundMatrixModel

This function builds a type::MyAtomCompoundMatrixModel
In the structure, compounds represents each metabolite. The variable::A represents a matrix where the columns are elements 
and the rows are the metabolites. The matrix is filled with the atoms of each element for each respective compound. 
"""
function build(type::Type{MyAtomCompoundMatrixModel}, compounds::Array{MyChemicalCompoundModel,1})::MyAtomCompoundMatrixModel

    # build an empty compound model -
    model = MyAtomCompoundMatrixModel();

    # construct the model elements, add them to the model -
    model.compounds = compounds;
    model.A = _build_atom_matrix(compounds);

    # return -
    return model;
end
# ======================================================================================================================== #