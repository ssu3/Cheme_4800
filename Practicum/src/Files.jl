"""
readmodelfile(path::String) -> Dict{String,Any}

The function reads a JSON file in the given path and converts it into a dictionary. 
"""
function readmodelfile(path::String)::Dict{String,Any}
    return JSON.parsefile(path)
end