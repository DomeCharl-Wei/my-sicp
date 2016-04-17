;; sicp-2-55: Eva Lu Ator types to the interpreter the expressiion
;; (car ''abracadabra)
;; To her surprise, the interpreter prints back quote. Explain

;; The ' just shorthand for quote, so the expression (car ''abracadabra)
;; equals to (car (quote (quote abracadabra))). The sub-expression
;; (quote (quote abracadabra)) is equivalent to '(quote abracadabra); so
;; the interpreter will take expression to 'quote
