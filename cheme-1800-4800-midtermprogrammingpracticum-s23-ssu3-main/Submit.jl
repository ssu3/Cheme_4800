# include the include -
include("Include.jl")

# load (and parse) the reaction file -
path_to_json_file = joinpath(_PATH_TO_DATA,"e_coli_core.json");
data = readreactionfile(path_to_json_file);

# build the compounds array -
# ...

# build the A matrix model -
# ...

# build the stochiometric matrix model -
# ...

# Compute Δ = transpose(A)*S
# ...