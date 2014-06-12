;; sicp-1-21.ss: Use the smallest divisor procedure to find the smallest
;; divisor of each of the following numbers: 199, 1999, 19999
(define (smallest-divisor n)
  (define (square x) (* x x))
  (define (divides? a b)
    (= (remainder a b) 0))
  (define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? n test-divisor) test-divisor)
          (else (find-divisor n (+ test-divisor 1)))))
  (find-divisor n 2))

(smallest-divisor 199)
;; => 199
(smallest-divisor 1999)
;; => 1999
(smallest-divisor 19999)
;; => 7

;; The smallest-divisor procedure finds the smallest integral divisor
;; of a given number n in a straightforward way, by testing to see if
;; n is divisible by each integer from 2 to \sqrt{n}. Since the number
;; of steps is between 1 and \sqrt{n}, the order of growth of the algorithm
;; is O(\sqrt{n})
