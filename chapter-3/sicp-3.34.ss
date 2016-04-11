;; Louis Reasoner wants to build a squarer, a constraint device with two
;; terminals such that the value of connector b on the second terminal will
;; always be the square of the value a on the first terminal. He proposes
;; the following simple device made from a multiplier:
;;
;; (define (squarer a b)
;;   (multiplier a a b))
;;
;; There is a serious flaw in this idea. Explain.

(load "/Users/enzo/test/scheme/constraint.ss")

(define (squarer a b)
  (multiplier a a b))

(define a (make-connector))
(define b (make-connector))
(define s (squarer a b))
(probe 'A a)
(probe 'B b)

(forget-value! a 'user)
(forget-value! b 'user)
(set-value! a 2 'user)
;; => done
;;
;; Probe: A = 2
;; Probe: B = 4

(forget-value! a 'user)
(forget-value! b 'user)
(set-value! b 4 'user)
;; => done
;;
;; Probe: B = 4

;; so what's the value of connector a
