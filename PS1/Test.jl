include("Include.jl")

plaintext = "hello"
e_dict = encrypt(plaintext)
println(e_dict)

d_message = decrypt(e_dict)
println(d_message)