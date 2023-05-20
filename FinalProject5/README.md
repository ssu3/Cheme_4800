## Objective: 
In Final Project #5, I utilized the chemical reaction database [KEGG database](https://www.kegg.jp) as well as a list of compounds found online via  https://byjus.com/chemical-compound-formulas/, which characterizes the compound's name, molecular weight, and molecular formula. 

In Final Project 5, I must design and implement a program that tokenizes and analyzes chemical formula strings. For “pathological” strings, e.g., strings that fail to produce the proper composition dictionary with my parser, the program should recommend a replacement formula string that keeps the chemical formula the same but allows the parser to create the appropriate composition dictionary. 

The two problems I wanted to highlight and tackle in this project in regards to "pathelogical strings" is both elements that take on 2 letters and elements that have a subscript of one at any place within the molecular formula. The final goal is when a chemical such as Sodium Chloride, NaCl is the input, the output is Na->1, Cl->1. 

Three Goals of Final Project #5:
1. Load necessary external packages, specifically DataFrames
2. Allow the code to parse through “non-pathelogical strings”
    Eg. [beta-D-Glucose:C6H12O6] returns [C->6, H->12, O->6] 
3. Allow the code to parse through “pathelogical strings”
    Eg. [Calcium Carbonate:CaCO3] returns [Ca->1, C->1, O->3] 