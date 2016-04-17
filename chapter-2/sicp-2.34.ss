;; sicp 2.34 horner-eval

(load "sicp-utils.ss")
(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms) (+ (* x higher-terms) this-coeff))
              0
              coefficient-sequence))

(horner-eval 2 '(1 3 0 5 0 1))
;; => 79
