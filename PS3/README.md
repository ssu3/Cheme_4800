## Objective: 
In Problem Set 3, we implemented two functions to build a system matrix and used two iterative methods, Jacobi and Gaus-Siedel, to solve for the decay of compound A over time at various rate constant values. 


|Row|  Case 1 | Case 2 | Case 3|
|---- | ----- | -----| ----|
| $det(A) \ne 0$ | Yes | Yes | Yes |
| Diagonally Dominant | Yes | Yes | No |
| Jacobi Solver | Yes | Yes | No |
| Gauss Seidel Solver | Yes | Yes | No |
| Error Jacobi| 0.0019 | 0.0 | 1.586e175 |
| Error Gauss Seidel| 4.41e-15 | 0.0 |1.585e175 |
