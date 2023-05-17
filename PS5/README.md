## Problem Set 5: Estimating kinetic parameters from experimental data

The purpose of Problem Set 5 was to utilize experimentally recorded data of an enzyme-catalyzed reaction in order to determine two unknown parameters: the maximum reaction velocity, $V_{max}$ , and the Michaelis-Menten model, $K_{M}\$. An input matrix and output matrix were created to represent the inverse of S, the substrate concentration and the inverse of v, the rate of reaction, respectively. From this, it was found that ${\beta_{1}}$= $K_{M}\$/ $V_{max}$ = .0028923 and ${\beta_{2}}$ =1/ $V_{max}$ = .379258. After, the normal distribution for error in y-output, $\frac{1}{v}$ was found to be N{5.893x10^-17,.005556}. Finally, a normal distribution was found for the two unknown parameters, where ${\beta_{1}}$ ~N\{.00283529,.000377561} and ${\beta_{2}}$ ~N\{0.379258, .00136625} when n sample size was 50,000. 

We have an enzyme catalyzed reaction whose rate of reaction $v$ follows [Michaelis–Menten kinetics](https://en.wikipedia.org/wiki/Michaelis–Menten_kinetics):

$$
v = \frac{V_{max}S}{K_{M}+S}
$$

where $S$ denotes the substrate concentration (units: $\mu{M}$), $V_{max}$ denotes the maximum reaction velocity (units: $\mu{M}\cdot{s}^{-1}$) and $K_{M}$ denotes the Michaelis-Menten constant (units: $\mu{M}$). The parameters $V_{max}$ and $K_{M}$ can be estimated from data by inverting the rate expression:

$$
\frac{1}{v} = \frac{K_{M}}{V_{max}}\left(\frac{1}{S}\right) + \frac{1}{V_{max}}
$$

The `PS5-dataset-w-repeats.csv` file contains measurements of the rate of reaction $v$ as a function of substrate concentration $S$. The substrate concentration has units of $\mu{M}$, while the rate measurements have units of $\mu{M}\cdot{s}^{-1}$. Each row contains a substrate concentration record, where each column (following the substrate concentration value) is a rate measurement. Three repeats were performed for each substrate value.

