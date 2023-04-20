
|Row|  Case 1 | 
|---- | ----- | 
| $det(A) \ne 0$ | Yes | Yes | Yes |
| Diagonally Dominant | Yes | Yes | No |
| Jacobi Solver | Yes | Yes | No |
| Gauss Seidel Solver | Yes | Yes | No |
| Error Jacobi| 0.0019 | 0.0 | 1.586e175 |
| Error Gauss Seidel| 4.41e-15 | 0.0 |1.585e175 |

|Reaction #|  $$ \mathbf{\Delta} $$ by column | 
|---- | ----- | 
| Reaction 25 | -175 |
| Reaction 44 | -7 | 
| Reaction 45 | -7 | 
| Reaction 46 | -14 | 
| Reaction 47 | -3 |
| Reaction 48 | -9 |
| Reaction 49 | -4 |
| Reaction 50 | -24 |
| Reaction 51 | -10 | 
| Reaction 52 | -24 | 
| Reaction 53 | -20 | 
| Reaction 54 | -18 | 
| Reaction 55 | -1 | 
| Reaction 56 | -3 | 
| Reaction 57 | -11 |
| Reaction 58 | -13 | 
| Reaction 59 | -5 | 
| Reaction 60 | -2 | 
| Reaction 61 | -6 | 
| Reaction 62 | -9 | 
| Reaction 63 | -12 | 

[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/kVgVqUvf)
# CHEME 1800/4800: Midterm Practicum

## Introduction
One of the challenges of constructing stoichiometric models of large reaction networks is quality assurance of the proposed chemical reactions, i.e., all the reactions we include in the model must be chemically balanced. If we have only a few reactions, we can check the correctness of the reactions by hand. However, this is not possible when we have models with hundreds or thousands of reactions (which are common when dealing with biochemical models). Thus, we need a method to identify when a reaction is not balanced that can be used for many reactions.

### Atom matrix
One way to check many reactions is to construct the atom matrix $\mathbf{A}$. The rows of the atom matrix $\mathbf{A}$ correspond to compounds, while the columns correspond to elements, e.g., $C,H,N,\dots$. Once we have the atom matrix $\mathbf{A}$, we can compute the matrix $\mathbf{\Delta}$:

$$
\mathbf{\Delta} = \mathbf{A}^{T}\mathbf{S}
$$

where $\mathbf{A}^{T}$ denotes the transpose of the atom matrix, and $\mathbf{S}$ denotes the stoichiometric matrix. Non-zero values in the columns of the $\mathbf{\Delta}$ matrix indicate unbalanced reactions. 

## Tasks
Let's check the reactions in the _E.coli_ model contained in the `e_coli_core.json` file downloaded from the [BiGG models database](http://bigg.ucsd.edu/models/e_coli_core) and stored in the `data` subdirectory.

1. Fill in the missing implementations in the template code to build the atom matrix $\mathbf{A}$ for the elements $\left(C,H,N,O,P,S\right)$ for the metabolites in the _E.coli_ model.
1. Fill in the missing implementations in the template code to build the stoichiometric matrix $\mathbf{S}$ for the reactions in the _E.coli_ model.
1. Compute the $\mathbf{\Delta} = \mathbf{A}^{T}\mathbf{S}$ matrix. 
    1. Which reactions in the _E.coli_ model are _unbalanced_?

### Assessment
* The teaching team will execute the `Submit.jl` script with your program functions. 
* The teaching team will evaluate style components: variable and function names should be informative, and functions should have informative docstrings. 
* The teaching team will evaluate whether the submission guidelines were followed.

### Rules, deadlines, and submission guidelines
* The mid-term practicum is due on __Tuesday, April 18, 2023__ by __11:50 PM__ ITH time. 
* You may use your course materials and any literature resources (as well as the internet) to formulate your solutions.
* You may __NOT__ work in terms. This is an __individual assignment__. Submit your solution to the GitHub Classroom link by the deadline. 
