;; sicp-1-29.ss: Using Simpson's Rule, the integral of a function f between
;; a and b is approximated as
;; $\frac{h}{3}[y_0 + 4y_1 + 2y_2 + 4y_3 + ... + 2y_{n-2} + 4y_{n-1} + y_n]$
;; where h = (b - a)/n, for some even integer n, and y_k = f(a + kh).
;; (Increasing n increases the accuracy of the approximation.) Define a
;; procedure that takes as arguments f, a, b, and n and returns the value of
;; the integral, computed using Simpson's Rule. Use your procedure to integrate
;; cube between 0 and 1 (with n = 100 and n = 1000), and compare the results
;; to those of the integral procedure shown above.


;; sum procedure
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

;; integral procedure above
(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))


(define (even? x)
  (= (remainder x 2) 0))

;; Simpson's Rule integration
(define (simpson-rule-integration f a b n)
  (define h (/ (- b a) (* 1.0 n)))
  (define (y k) (f (+ a (* k h))))
  (define (term x)
    (cond ((or (= k 0) (= k n)) (y x))
          ((even? k) (* 2 (y x)))
          (else (* 4 (y x)))))
  (define (next x)
    (+ x 1))

  (* (/ h 3.0)
     (sum term 0 next n)))

(define (cube x) (* x x x))

(simpson-rule-integration cube 0 1 100)
(simpson-rule-integration cube 0 1 1000)
(integral cube 0 1 0.01)
(integral cube 0 1 0.001)
