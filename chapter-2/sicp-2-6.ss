;; sicp-2-6.ss: Define one and two directly (not in terms of zero and add-1).
;; (Hint: Use substitution to evaluate (add-1 zero)). Give a direct definition
;; of the addition procedure + (not in terms of repeated application of add-1)
;;
;; In case representing pairs as procedures wasn't mind-boggling enough,
;; consider that, in a language that can manipulate procedures, we can get by
;; without numbers (at least insofar as nonnegative integers are concerned) by
;; implementing 0 and the operation of adding 1 as
;; (define zero (lambda (f) (lambda (x) x)))
;; (define (add-1 n)
;;   (lambda (f) (lambda (x) (f ((n f) x)))))
;; This representation is known as Church numerals, after its inventor, Alonzo
;; Church, the logician who invented the \lambda calculus.


;; A church numeral is a procedure that takes one argument, and that argument
;; is itself another procedure that also takes one argument. The procedure
;; zero represents the integer 0 by returning a procedure that applies its
;; input procedure zero times. The Church numeral one should return a procedure
;; that applies its input procedure once, two should return a procedure that
;; applies its input procedure twice, and so on. This is how Church numerals
;; represent integers, by applying their input procedure the exact number of
;; times that the numerals are supposed to represent.

(define zero (lambda (f) (lambda (x) x)))
(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

;; Testing Church numerals
(define (inc n)
  (+ n 1))

((zero inc) 0)
;; => 0
((zero inc) 1)
;; => 1

(define one (add-1 zero))
((one inc) 0)
;; => 1
((one inc) 1)
;; => 2

(define two (add-1 one))
((two inc) 0)
;; => 2
((two inc) 1)
;; => 3

;; substitute (add-1 zero)
;;    (add-1 zero)
;; => (lambda (f) (lambda (x) (f ((zero f) x))))
;; => (lambda (f) (lambda (x) (f (((lambda (f) (lambda (y) y)) f) x))))
;; => (lambda (f) (lambda (x) (f ((lambda (y) y) x))))
;; => (lambda (f) (lambda (x) (f x)))
;; so one can be defined:
(define one (lambda (f) (lambda (x) (f x))))

;; also substitute (add-1 one)
;;    (add-1 one)
;; => (lambda (f) (lambda (x) (f ((one f) x))))
;; => (lambda (f) (lambda (x) (f (((lambda (f) (lambda (y) (f y))) f) x))))
;; => (lambda (f) (lambda (x) (f ((lambda (y) (f y)) x))))
;; => (lambda (f) (lambda (x) (f (f x))))
;; so two can be defined:
(define two (lambda (f) (lambda (x) (f (f x)))))
