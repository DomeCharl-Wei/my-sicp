;; sicp-1-35.ss: Show that the golden ratio \phi (section 1.2.2) is a fixed
;; point of the transformation x -> 1 + 1/x, and use this fact to compute
;; \phi by means of the fixed-point procedure.

(define tolerance 0.0001)
(define (fixed-point f first-guess)
  (define (close-enough? x y)
    (< (abs (- x y)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (phi)
  (fixed-point (lambda (x) (+ 1 (/ 1.0 x)))
               1.0))
