"""
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

"""
    recursive_compound_parser(compounds::Dict{String, MyChemicalCompoundModel})->Dict{String,MyChemicalCompoundModel}

    Argument 
    'compounds': Dict that contains the element name and element compound. 

    Recursive parser method that takes molecular composition data (ie. element and its subscript) and stores it in a dictionary with element as keys and value as values. 

TODO: Describe what this function does, the args and what we expect it to return 
"""
function recursive_compound_parser(compounds::Dict{String, MyChemicalCompoundModel})::Dict{String,MyChemicalCompoundModel}

    for (name, model) ∈ compounds  
    

    # TODO: Implement a function that computes a composition dictionary of type Dict{Char,Int} for each of the compounds in the compounds dictionary
        composition = Dict{Char,Int}()
        q = Queue{Char}()
        element = Array{Char,1}()
        value = Array{Int,1}()
        

    #string = dict["beta-D-Glucose"].compound 
    
    character_arr = collect(model.compound)
    for c ∈ character_arr
        enqueue!(q, c);
    end
    # the parsering logic should be written in the _recursive_compound_parser function.

    _recursive_compound_parser(q, element, value);

    #@show (value, model)

    count = 1 
    for (index, letter) ∈ enumerate(element)
        @show (index, letter)
        composition[letter] = value[index];
        count += 1 
    end
    model.composition= composition
end

 
return compounds;

end