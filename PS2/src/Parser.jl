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
function _recursive_compound_parser(q::Queue{Char}, element::Array{String,1},value::Array{Int,1})
    # TODO: Implement me
    if (isempty(q) == true) 
        return nothing
    else 
        next_char = dequeue!(q)
        if (isnumeric(next_char) == false)
            # assume the current character is an upper case letter
            elem = string(next_char)
            # check if the next character is a lower case letter
            if (isempty(q) == false)
                peek_char = first(q)
                if (islowercase(peek_char) == true)
                    # check if the current character is an upper case letter
                    if (isuppercase(next_char) == true)
                        # if yes, then combine the two characters as one element
                        next_char2 = dequeue!(q)
                        elem = elem * next_char2
                    else
                        # if not, then push the current character as a single element and enqueue the next character back to the queue
                        push!(element, elem)
                        enqueue!(q, next_char2)
                        # return to avoid pushing the same element twice
                        return _recursive_compound_parser(q, element, value)
                    end
                end
            end
            # push the element to the array
            push!(element, elem)
            
            # check if the next character is numeric or not
            if (isempty(q) == false)
                peek_char = first(q)
                if (isnumeric(peek_char) == true)
                    # if yes, then dequeue the next character and parse it as a value
                    next_char3 = dequeue!(q)
                    val = parse(Int, next_char3)
                    # check if the next character is also numeric or not
                    if (isempty(q) == false)
                        peek_char2 = first(q)
                        if (isnumeric(peek_char2) == true)
                            # if yes, then dequeue the next character and append it to the value
                            next_char4 = dequeue!(q)
                            val = val * 10 + parse(Int, next_char4)
                        end
                    end
                    # push the value to the array
                    push!(value, val)
                else
                    # if not, then the element has a default value of 1
                    push!(value, 1)
                end
            else
                # if the queue is empty, then the element has a default value of 1
                push!(value, 1)
            end
        
        elseif (isempty(q) == false)

            next_char2=dequeue!(q)

            if (isnumeric(next_char2)==true)
                bignum=string(next_char,next_char2)
                numbers2=parse(Int,bignum)
                push!(value,numbers2)
        
            else
                push!(value,parse(Int,next_char))
                push!(element,string(next_char2))
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
        composition = Dict{String,Int}()
        q = Queue{Char}()
        element = Array{String,1}()
        value = Array{Int,1}()
        

    #string = dict["beta-D-Glucose"].compound 
    
    character_arr = collect(model.compound)
    for c ∈ character_arr
        # convert each character to a string
        enqueue!(q, c);
    end
    # the parsering logic should be written in the _recursive_compound_parser function.

    _recursive_compound_parser(q, element, value);

    #@show (value, model)

    count = 1 
    for (index, letter) ∈ enumerate(element)
        @show (index, letter, value[index])
        composition[letter] = value[index];
        count += 1 
    end
    model.composition= composition
end

 
return compounds;

end
