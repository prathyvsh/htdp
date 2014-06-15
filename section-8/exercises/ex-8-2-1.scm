;1. x
;is a valid variable name and hence an expression of the form <var>
;2. (= y z)
;is a valid condition and hence an expression of the form <con>
;3. (= (= y z) 0)
;is a valid condition containing a condition and hence an expression

;1. (3 + 4)
;uses postfix addition which is illegal in scheme

;2. empty?(l)
;is a malformed expression

;3. (x)
;contains only a variable but not a function but Scheme dictates that a bracket should have at least one more expression after the variable.
