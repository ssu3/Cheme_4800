using Plots
# include -
include("Include.jl")

# Constant Parameters 
T_f = 20 # hr
h = 0.1
N = Int((T_f - 0.0)/h)
Cₒ = 10.0
# Case 1
κ_1 = 1.0
κ_2 = 10.0
κ_3 = 100.0

model_1 = build(MyChemicalDecayModel; κ=1.0, h, N, Cₒ)
model_2 = build(MyChemicalDecayModel; κ=10.0, h, N, Cₒ)
model_3 = build(MyChemicalDecayModel; κ=100.0, h, N, Cₒ)
xₒ = zeros(N)

x_GS1 =  solve(GaussSeidelIterationSolver(), model_1, xₒ)
x_JC1 =  solve(JacobiIterationSolver(), model_1, xₒ)
x_MatSol1 = inv(model_1.A) * model_1.b 
err_GS1 = norm(x_GS1 .- x_MatSol1)
err_JC1 = norm(x_JC1 .- x_MatSol1)

x_GS2 =  solve(GaussSeidelIterationSolver(), model_2, xₒ)
x_JC2 =  solve(JacobiIterationSolver(), model_2, xₒ)
x_MatSol2 = inv(model_2.A) * model_2.b 
err_GS2 = norm(x_GS2 .- x_MatSol2)
err_JC2 = norm(x_JC2 .- x_MatSol2)

x_GS3 =  solve(GaussSeidelIterationSolver(), model_3, xₒ)
x_JC3 =  solve(JacobiIterationSolver(), model_3, xₒ)
x_MatSol3 = inv(model_3.A) * model_3.b 
err_GS3 = norm(x_GS3 .- x_MatSol3)
err_JC3 = norm(x_JC3 .- x_MatSol3)

print("Solved")

