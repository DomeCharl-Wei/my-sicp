;; define split

(define (split op1 op2)
  (lambda (painter)
    (op1 painter
         (op2 painter painter))))

(define right-split (split beside below))
(define up-split (split below beside))
