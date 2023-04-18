
"""
    _build_right_handside_vector(N::Int64, κ::Float64, h::Float64, Cₒ::Float64) -> Array{Float64,1}
Internal function that constructs the right-hand side vector for the chemical decay problem
"""
function _build_right_handside_vector(N::Int64, κ::Float64, h::Float64, Cₒ::Float64)::Array{Float64,1}
    
    # b=Array{Float64,1}(0.0,N)
    b = zeros(Float64, N)
    #b=Array{Float64,1}(undef,N)
    b[1]=Cₒ*(1-h*κ)
    return b

end

        
"""
    _build_system_matrix(N::Int64, κ::Float64, h::Float64) -> Array{Float64,2}
Internal function that constructs the system matrix for the chemical decay problem
"""
function _build_system_matrix(N::Int64, κ::Float64, h::Float64)::Array{Float64,2}

    # A= Array{Float64,2}(0.0,N,N)
    A = zeros(Float64, N, N)
    for i in 1:N
        A[i, i] = 1.0
        if i > 1
                A[i, i-1] = h*κ - 1
            end
        end
        return A
end


"""
    build(type::Type{MyChemicalDecayModel}; 
        κ::Float64 = 0.0, h::Float64 = 0.0, N::Int64 = 0, Cₒ::Float64 = 0.0) -> MyChemicalDecayModel
Build an instance of MyChemicalDecayModel and sets the value of the model parameters. 
Default model parameters are zero
"""
function build(type::Type{MyChemicalDecayModel}; κ::Float64 = 0.0, h::Float64 = 0.0, N::Int64 = 0, Cₒ::Float64 = 0.0)::MyChemicalDecayModel

    # build an empty model -
    model = MyChemicalDecayModel()

    # set parameters on the model
    model.κ = κ
    model.h = h
    model.N = N
    model.Cₒ = Cₒ
    model.A = _build_system_matrix(N, κ, h)
    model.b = _build_right_handside_vector(N, κ, h, Cₒ) 
    #return
    return model
end

