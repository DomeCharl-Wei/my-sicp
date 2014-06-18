;; sicp-2-15.ss: Eva Lu Ator, another user, has also noticed the different
;; intervals computed by different but algebraically equivalent expressions.
;; She says that a formula to compute with intervals using Alyssa's system
;; will produce tighter error bounds if it can be written in such a form that
;; no variable that represents an uncertain number is repeated. Thus, she says
;; par2 is a "better" program for parallel resistances than par1. Is she right?
;; Why?

;; the formulas are algebraically equivalent, but they don't give the same
;; answer. Why could that be? The answer lies in the trick we used just now to
;; show equivalence. We used the ratios R1/R1 and R2/R2 to change the formula
;; and said that it was okay because that's just like multiplying by 1. But R1
;; and R2 represent resistor values, which are intervals, and we saw in
;; exercise 2.14 that dividing an interval by itself doesn't equal 1, it just
;; approximates it. Transforming the equation in this way introduces error.
;; That's why the observation that we can get tighter error bounds if we avoid
;; repeating variables that represent uncertain numbers is correct.
