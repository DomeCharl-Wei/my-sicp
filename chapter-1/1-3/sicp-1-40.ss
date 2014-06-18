;; sicp-1-40.ss: Define a procedure cubic that can be used together with the
;; newtons-method procedure in expression of the form
;; (newtons-method (cubic a b c) 1)
;; to approximate zeros of the cubic x^3 + ax^2 + bx + c

;; define fixed-point
(define (fixed-point f first-guess)
  (define tolerance 0.00001)
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

;; define newtons-method
(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(define (deriv g)
  (define dx 0.000001)
  (lambda (x)
    (/ (- (g (+ x dx)) (g x))
       dx)))

(define (newton-transform g)
  (lambda (x)
    (- x (/ (g x) ((deriv g) x)))))


;; define cubic
(define (cube x) (* x x x))

(define (square x) (* x x))

(define (cubic a b c)
  (newton-transform (lambda (x) (+ (cube x)
                                   (* a (square x))
                                   (* b x)
                                   c))))

;; a = 2, b = 3, c = 4
(newtons-method (cubic 2 3 4) 1.0)
