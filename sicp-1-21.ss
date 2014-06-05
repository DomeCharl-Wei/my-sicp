;;; smallest divisor
(define (smallest-divisor n)
  (define (square x) (* x x))
  (define (divides? a b)
    (= (remainder a b)) 0)
  (define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? n test-divisor) test-divisor)
          (else (find-divisor n (+ test-divisor 1)))))
  (find-divisor n 2))

(smallest-divisor 199)
(smallest-divisor 1999)
(smallest-divisor 19999)
