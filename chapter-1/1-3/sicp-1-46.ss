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
(define (iterative-improve good-enough improve)
  (lambda (x)
    (define (try guess)
      (let ((next ((improve x) guess)))
        (if (good-enough guess next)
            guess
            (try next))))
    (try 1.0)))

;; rewrite sqrt procedure
(define (sqrt x)
  (define (good-enough? x y)
    (< (abs (- x y)) 0.000001))
  (define (abs x)
    (if (< x 0)
        (- 0 x)
        x))

  ((iterative-improve good-enough? average-damp) x))


(define (average-damp x)
  (lambda (y) (average y (/ x y))))

(define (average x y)
  (/ (+ x y) 2.0))


;; fixed-point
