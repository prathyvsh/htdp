(define x (cons 1 "x"))
Here the quoted x is bound on the variable declaration.
The right-hand side of this variable definition is
not a legal scheme expression since the bound variable
requires a definition before it can be binded.
