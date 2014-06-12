;; sicp-1-27: Demonstrate that the Carmichael numbers listed in footnote-47
;; really do fool the Fermat test. That is, write a procedure that takes an
;; integer n and tests whether a^n is congruent to a modulo n for every a<n,
;; and try your procedure on the given Carmichael numbers.

(define (square x) (* x x))

(define (even? x)
  (= (remainder x 2) 0))

;; normal prime test
(define (prime? n)
  (= (smallest-divisor n) n))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

;; expmod
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m)) m))
        (else
         (remainder (* base (expmod base (- exp 1) m)) m))))

;; define Carmichael function
(define (carmichael? n)
  (define (carmichael-iter a)
    (cond ((= a n) true)
          ((= (expmod a n n) a) (carmichael-iter (+ a 1)))
          (else false)))
  (and (not (prime? n))   ;; make sure n is not prime
       (carmichael-iter 0)))

;; Carmichael numbers as follows:
;; 561, 1105, 1729, 2465, 2821, 6601
(for ([i '(561 1105 1729 2465 2821 6601)])
     (printf "(carmichael? ~a): ~a\n" i (carmichael? i)))
