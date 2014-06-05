;;; complete a procedure for computing Fibonacci numbers in a logarithmic number of steps.

(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (even? x)
  (= (remainder x 2) 0))

(define (square x) (* x x))


;;; a_1 = (a_0 + b_0)*q + a_0*p
;;; b_1 = a_0*q + b_0*p
;;; b_2 = a_1*q + b_1*p
;;;     = ((a_0 + b_0)*q + a_0*p)*q + (a_0*q + b_0*p)*p
;;;     = a_0*(2*p*q + q^2) + b_0*(p^2 + q^2)
;;; => q' = 2*p*q + q^2
;;; => p' = p^2 + q^2
(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count) (fib-iter a
                                 b
                                 (+ (square p) (square q))
                                 (+ (* 2 p q) (square q))
                                 (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))
