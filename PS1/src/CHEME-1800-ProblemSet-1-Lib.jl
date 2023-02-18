"""
    encrypt(plaintext::String) -> Dict{Int64,String}

    Encrypts a plain-text message using codon cryptography. 

    Returns a dictionary indexed by the order of the letters in 
    the plain-text message and stores each corresponding codon sequence. 

    ...
    # Arguments
    - 'plaintext::String': the message we want to encrypt.

"""
function encrypt(plaintext::String)::Dict{Int64,String}
    
    # initialize -
    message = Dict{Int64,String}()
    counter = 0;

    # build encryptionkey -
    encryption_model = _build(DNAEncryptionKey);
    encryptionkey = encryption_model.encryptionkey;

    for c ∈ uppercase(plaintext)

        # encrypt -
        message[counter] = encryptionkey[c]

        # update the counter -
        counter = counter + 1
    end

    # return -
    return message

end


"""
    decrypt(encrypteddata::Dict{Int64,String}) -> String

    Decrypts a codon dictionary into a plain-text message using codon cryptography. 

    Returns a string message. 

    ...
    # Arguments
    - "encrypteddata::Dict{Int64,String}": the codon dictionary with the message we want 
        to decrypt.
"""
function decrypt(encrypteddata::Dict{Int64,String})::String
       # initialize -
   number_of_chars = length(encrypteddata)
   inverse_encryptionkey_dict = Dict{String, Char}()
   plaintext = Vector{Char}()

   # build encryptionkey -
   encryption_model = _build(DNAEncryptionKey);
   encryptionkey = encryption_model.encryptionkey;

   # build the inverse_key -
   for (key, value) ∈ encryptionkey
       inverse_encryptionkey_dict[value] = key
   end

   for i ∈ 0:(number_of_chars - 1)
       
       codon = encrypteddata[i]
       value = inverse_encryptionkey_dict[codon]
       push!(plaintext, value)
   end

   # return -
   return String(plaintext)
end