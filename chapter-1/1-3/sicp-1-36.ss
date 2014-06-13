;; sicp-1-36.ss: Modify fixed-point so that it prints the sequence of
;; approximations it generates, using the newline and display primitives shown
;; in exercise 1.22. Then find a solution to x^x = 1000 by finding a fixed
;; point of x -> log(1000)/log(x). Compare the number of steps this takes with
;; and without average damping. (Note that you cannot start fixed-point with
;; a guess of 1, as this would cause division by log(1) = 0.)


(define tolerance 0.00001)
(define (fixed-point-steps f first-guess)
  (define steps 0)
  (define (close-enough? x y)
    (< (abs (- x y)) tolerance))
  (define (try guess)
    (let* ((next (f guess))
          (_ (newline))
          (_ (display "try "))
          (_ (display guess)))
      (set! steps (+ steps 1))
      (if (close-enough? guess next)
          next
          (try next))))

  (try first-guess)
  (newline)
  (display "steps: ")
  (display steps)
  (newline))


;; find a solution to x^x = 1000 by finding a fixed point of x ->
;; log(1000)/log(x)
(define (f x)
  (/ (log 1000.0) (log x)))

(define (damping x)
  (average x (/ (log 1000.0) (log x))))

;; comapre the number of steps between with and without average damping
(fixed-point-steps f 2.0)
(fixed-point-steps damping 2.0)
