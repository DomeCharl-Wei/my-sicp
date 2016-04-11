;; Using primitive multiplier, adder, and constant constraints, define a
;; procedure averager that takes three connectors a, b, and c as inputs
;; and establishes the constraint that the value of c is the average of
;; the values a and b.

(load "/Users/enzo/test/scheme/constraint.ss")

(define (averager a b c)
  (let ((sum (make-connector))
        (half (make-connector)))
    (adder a b sum)
    (constant 0.5 half)
    (multiplier sum half c)
    'ok))


(define a (make-connector))
(define b (make-connector))
(define c (make-connector))
(averager a b c)

(probe 'A a)
(probe 'B b)
(probe 'C c)
(set-value! a 5 'user)
(set-value! b 10 'user)
