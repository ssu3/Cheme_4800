## Problem Set 5: Estimating kinetic parameters from experimental data

The purpose of Problem Set 5 was to utilize experimentally recorded data of an enzyme-catalyzed reaction in order to determine two unknown parameters: the maximum reaction velocity,$V_{max}$, and the Michaelis-Menten model, $K_{M}\$. An input matrix and output matrix were created to represent the inverse (1/S) where S is the substrate concentration and (1/v) where v is the rate of reaction, respectively. From this, it was found that {\beta_{1}}=frac{K_{M}}{V_{max}}=.0028923 and {\beta_{2}}=frac{1}{V_{max}}=.379258. After, the normal distribution for error in y-output, or \frac{1}{v} was N{5.893x10^{-17},.005556}. Finally, a normal distribution was found for the two unknown parameters, where {\beta_{1}}~N{.00283529,.000377561} and {\beta_{2}}~N{0.379258, .00136625}. 

We have an enzyme catalyzed reaction whose rate of reaction $v$ follows [Michaelis–Menten kinetics](https://en.wikipedia.org/wiki/Michaelis–Menten_kinetics):

$$
v = \frac{V_{max}S}{K_{M}+S}
$$

where $S$ denotes the substrate concentration (units: $\mu{M}$), $V_{max}$ denotes the maximum reaction velocity (units: $\mu{M}\cdot{s}^{-1}$) and $K_{M}$ denotes the Michaelis-Menten constant (units: $\mu{M}$). The parameters $V_{max}$ and $K_{M}$ can be estimated from data by inverting the rate expression:

$$
\frac{1}{v} = \frac{K_{M}}{V_{max}}\left(\frac{1}{S}\right) + \frac{1}{V_{max}}
$$

The `PS5-dataset-w-repeats.csv` file contains measurements of the rate of reaction $v$ as a function of substrate concentration $S$. The substrate concentration has units of $\mu{M}$, while the rate measurements have units of $\mu{M}\cdot{s}^{-1}$. Each row contains a substrate concentration record, where each column (following the substrate concentration value) is a rate measurement. Three repeats were performed for each substrate value.

### Prerequisites
* `PS5` requires that the [Distributions.jl](https://github.com/JuliaStats/Distributions.jl), [CSV.jl](https://github.com/JuliaData/CSV.jl), and [DataFrames.jl](https://github.com/JuliaData/DataFrames.jl) packages be installed using the [Julia package manager included in the standard library](https://docs.julialang.org/en/v1/stdlib/Pkg/).

### Tasks
1. In `Submit.jl` load the experimental `PS5-dataset-w-repeats.csv` data set contained in the `data` directory using the `loaddataset` function in `Files.jl`.
1. Implement the `build_data_matrix` function in the `Compute.jl` file. The `build_data_matrix` function takes the experimental `DataFrame` and returns the system data matrix $\mathbf{X}$.
1. Implement the `build_output_vector` function in the `Compute.jl` file. The `build_output_vector` function takes the experimental `DataFrame` and returns the output vector $\mathbf{y}$.
1. In `Submit.jl` call your `build_data_matrix` and `build_output_vector` functions, and solve for the unknown parameter vector $\mathbf{\beta}$.
1. Update the implementation of the `build_error_distribution` function in `Compute.jl`. The `build_error_distribution` function takes the model residual vector and returns a [Normally distributed error model](https://juliastats.org/Distributions.jl/stable/univariate/#Distributions.Normal).
1. In `Submit.jl` build an error model by calling your implementation of the `build_error_distribution` function.
1. In `Submit.jl` compute the mean and standard deviation for each model parameter by sampling your error model (see the `Lab-9d` solution).

### Assessment
* The teaching team will execute the `Submit.jl` script with your program functions. 
* The teaching team will evaluate style components: variable and function names should be informative, and functions should have informative docstrings. 
* The teaching team will evaluate whether the submission guidelines were followed.

### Rules, deadlines, and submission guidelines
* Problem Set 5 is due on __Saturday, April 1, 2023__ by __11:59 PM__ ITH time. 
* You may use your course materials and any literature resources (as well as the internet) to formulate your solutions.
* You may work in teams. All codes must be stored in a GitHub repository, and the link to that repository (and team information) must be entered into the [teaching team spreadsheet on box](https://cornell.box.com/s/77qu4ubry3wgkw8p7s0qrfl0lb5u0spb) by the deadline. 

#### Notes on the GitHub repository
* Each student on the problem set team must be a collaborator on the problem set GitHub repository. 
* The problem set repository should include a `README.md` file that describes the problem set, lists the team members, and the contributions of each team to completing the problem set.

For help with setting up a GitHub repository: [How to set up a GitHub repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-new-repository). For help with GitHub markdown: [Help with markdown syntax for your README.md file](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax)
