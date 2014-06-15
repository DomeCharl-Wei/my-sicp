;; sicp-1-46.ss: Several of the numerical methods described in this chapter are
;; instances of an extremely general computational strategy known as iterative
;; improvement. Iterative improvement says that, to compute something, we start
;; with an initial guess for the answer, test if the guess is good enough, and
;; otherwise improve the guess and continue the process using the improved guess
;; as the new guess. Write a procedure iterative-improve that takes two
;; procedures as arguments: a method for telling whether a guess is good enough
;; and a method for improving a guess. Iterative-improve should return as its
;; value a procedure that takes a guess as argument and keeps improving the
;; guess until it is good enough. Rewrite the sqrt procedure of section 1.1.7
;; and the fixed-point procedure of section 1.3.3 in terms of iterative-imporve.

;; iterative improve
(define (iterative-improve good-enough? improve)
  (define (try guess)
    (let ((next (improve guess)))
      (if (good-enough? guess next)
          guess
          (try next))))
  (lambda (x) (try x)))

;; rewrite sqrt procedure
(define (sqrt x)
  (define (close-enough? a b)
    (< (abs (- a b)) 0.000001))
  (define (improve a)
    ((average-damp (lambda (y) (/ x y))) a))

  ((iterative-improve close-enough? improve) 1.0))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (average x y)
  (/ (+ x y) 2.0))

(define (abs x)
  (if (< x 0)
      (- 0 x)
      x))

;; fixed-point original version
(define (fixed-point f first-guess)
  (define tolerance 0.00000001)
  (define (close-enough? x y)
    (< (abs (- x y)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          guess
          (try next))))

  (try first-guess))


;; fixed-point with iterative-improve
(define (fixed-point-iter f first-guess)
  (define (close-enough? x y)
    (< (abs (- x y)) 0.00000001))
  ((iterative-improve close-enough? f) first-guess))

;; sqrt with fixed-point-iter
(define (sqrt-iter x)
  (fixed-point-iter (average-damp (lambda (y) (/ x y)))
                    1.0))
