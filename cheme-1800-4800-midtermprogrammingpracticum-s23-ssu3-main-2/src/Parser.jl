"""
build_compounds(data::Dict{String,Any}) -> Array{String, 1}

The function builds an array of string compounds using the JSON file.
"""

function build_compounds(data::Dict{String,Any})::Array{String, 1}
    list_of_metabolites = data["metabolites"];
    number_of_metabolites = length(list_of_metabolites);
    compounds = Array{String, 1}()
    for i ∈ 1:number_of_metabolites
        comp_formula = list_of_metabolites[i]["formula"]
        if !isnumeric(comp_formula[end])
            comp_formula *= "1"
        end
        push!(compounds, comp_formula)
    end
    return compounds
end

"""
build_compounds_mod_array(data::Dict{String,Any}) -> Array{MyChemicalCompoundModel, 1}

The function builds an array of type::MyChemicalCompoundModel using the JSON file. 
"""

function build_compounds_mod_array(data::Dict{String,Any})::Array{MyChemicalCompoundModel, 1}
        list_of_metabolites = data["metabolites"];
        number_of_metabolites = length(list_of_metabolites);
        compounds = Array{String, 1}()
        compound_model = Array{MyChemicalCompoundModel, 1}()
        for i ∈ 1:number_of_metabolites
            comp_formula = list_of_metabolites[i]["formula"]
            formula_char_array = collect(comp_formula)
            formula_arr_length = length(formula_char_array)
            new_formula_array = Array{Char, 1}()
            
            for i in 1:formula_arr_length
                if i == formula_arr_length 
                    if !isnumeric(formula_char_array[i])
                        push!(new_formula_array, formula_char_array[i])
                        push!(new_formula_array, '1')
                    else
                        push!(new_formula_array, formula_char_array[i])
                    end
                elseif !isnumeric(formula_char_array[i]) && !isnumeric(formula_char_array[i+1])
                    push!(new_formula_array, formula_char_array[i])
                    push!(new_formula_array, '1')
                else
                    push!(new_formula_array, formula_char_array[i]) 
                end
            end
            # println(formula_char_array, new_formula_array)
            # if !isnumeric(comp_formula[end])
            #     comp_formula *= "1"
            # end
            push!(compounds, join(new_formula_array))            
        end
        #println(compounds)
        for i ∈ 1:length(compounds)
            model = build(MyChemicalCompoundModel, list_of_metabolites[i]["name"], compounds[i])
            push!(compound_model, model)
            # println(model.name, model.composition)
            # model = build(type::Type{MyChemicalCompoundModel}, name::String, compound::String)
        end
        return compound_model

end