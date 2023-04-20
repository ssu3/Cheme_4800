# include the include -
# ...
include("Include.jl")
# load (and parse) the reaction file -
# ...
path_to_json_file = joinpath(_PATH_TO_DATA,"e_coli_core.json");
data = readmodelfile(path_to_json_file);
# build the compounds array -
# ...
# Array is of Type MyChemicalCompoundModel
compounds = build_compounds_mod_array(data)
# build the A matrix model -
# ...
atom_matrix_model = build(MyAtomCompoundMatrixModel, compounds)
A1 = atom_matrix_model.A
# build the stochiometric matrix model -
# ...
stoich_matrix_model = build(MyStoichiometricNetworkMatrixModel, data)
S1 = stoich_matrix_model.S
# Compute Δ = transpose(A)*S
# ...
Δ = transpose(A1) * S1

sum_columns_Δ = sum(Δ; dims=1)
k = 1
for val in vec(sum_columns_Δ)
    if  val != 0.0
        println("Value=$val, Reaction Number=$k")
    end
    global k += 1
end