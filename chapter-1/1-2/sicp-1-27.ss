;; sicp-1-27: Demonstrate that the Carmichael numbers listed in footnote-47
;; really do fool the Fermat test. That is, write a procedure that takes an
;; integer n and tests whether a^n is congruent to a modulo n for every a<n,
;; and try your procedure on the given Carmichael numbers.


;; define Carmichael function
(define (carmichael? n)
  (define (carmichael-iter a)
    (cond ((= a n) true)
          ((= (expmod a n n) a) (carmichael-iter (+ a 1)))
          (else false)))
  (carmichael-iter 0))

;; Carmichael numbers as follows:
;; 561, 1105, 1729, 2465, 2821, 6601
(for ([i '(561 1105 1729 2465 2821 6601)])
     (printf "(carmichael? ~a): ~a\n" i (carmichael? i)))
