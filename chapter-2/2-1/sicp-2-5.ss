;; sicp-2-5.ss: Give the corresponding definitions of the procedures cons, car
;; and cdr to represent the pair a and b as the integer that is the product
;; 2^a 3^b

(define (cons a b)
  (* (power 2 a)
     (power 3 b)))

(define (power base exp)
  (define (iter c result)
    (if (= c exp)
        result
        (iter (+ c 1) (* base result))))
  (iter 0 1.0))

(define (count base n)
  (define (iter remain c)
    (if (= (remainder remain base) 0)
        (iter (/ remain base) (+ c 1))
        c))
  (iter n 0))

(define (car x)
  (count 2 x))

(define (cdr x)
  (count 3 x))


;; an interesting solution
(define (cons a b) (* (expt 2 a) (expt 3 b)))

(define (logb b n) (floor (/ (log n) (log b))))

(define (car x) (logb 2 (/ x (gcd x (expt 3 (logb 3 x))))))

(define (cdr x) (logb 3 (/ x (gcd x (expt 2 (logb 2 x))))))
