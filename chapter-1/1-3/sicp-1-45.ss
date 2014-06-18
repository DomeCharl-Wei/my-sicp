;; sicp-1-45.ss: We saw section 1.3.3 that attempting to compute square roots
;; by naively finding a fixed point of y -> x/y does not converge, and that this
;; can be fixed by average damping. The same method works for finding cube roots
;; as fixed point of the average-damped y -> x/y^2. Unfortunately, the process
;; does not work for fourth roots --- a single average damp is not enough to
;; make a fixed-point search for y -> x/y^3 converge. On the other hand, if we
;; average damp twice (i.e., use the average damp of the average damp of
;; y -> x/y^3) the fixed-point search does converge. Do some experiments to
;; determine how many average damps are required to compute nth roots as a
;; fixed-point search based upon repeated average damping of y -> x/y^{n-1}.
;; Use this to implement a simple procedure for computing nth roots using
;; fixed-point, average-damp, and the repeated procedure of exercise 1.43.
;; Assume that any arithmetic operations you need are available as primitives.


;; fixed point
(define (fixed-point f first-guess)
  (define tolerance 0.0000001)
  (define (abs x)
    (if (< x 0)
        (- 0 x)
        x))
  (define (close-enough? x y)
    (< (abs (- x y)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          guess
          (try next))))

  (try first-guess))

;; average-damp
(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (average x y)
  (/ (+ x y) 2.0))


;; repeated
(define (repeated f n)
  (define (iter c result)
    (if (> c n)
        result
        (iter (+ c 1) (f result))))
  (lambda (x) (iter 1 (f x))))


;; forth-root
(define (forth-root x)
  (fixed-point ((repeated average-damp 2) (lambda (y) (/ x (* y y y))))
               1.0))

;; fifth-root
(define (fifth-root x)
  (fixed-point ((repeated average-damp 3) (lambda (y) (/ x (* y y y y))))
               1.0))

;; sixth-root
(define (sixth-root x)
  (fixed-point ((repeated average-damp 4) (lambda (y) (/ x (* y y y y y))))
               1.0))


;; nth-root
(define (nth-root n x)
  (cond ((< n 2) (error "n must bigger than 1"))
        ((= n 2) (fixed-point (average-damp (lambda (y) (/ x y)))
                              1.0))
        (else
         (fixed-point ((repeated average-damp (- n 2)) (lambda (y)
                                                         (/ x (pow (- n 1) y))))
                      1.0))))

(define (pow n x)
  (define (iter c result)
    (if (> c n)
        result
        (iter (+ c 1) (* result x))))
  (iter 1 1.0))
