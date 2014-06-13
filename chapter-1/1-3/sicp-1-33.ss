;; sicp-1-33.ss: Write filtered-accumulate as a procedure which combines only
;; only those terms derived from values in the range that satisfy a specified
;; condition. Show how to express the following using filtered-accumulate:
;;
;;
;; a. the sum of the squares of the prime numbers in the interval a to b (
;; assuming that you have a prime? predicate already written)

;; recursive filtered-accumulate
(define (filtered-accumulate filter? combine null-value term a next b)
  (cond ((> a b) null-value)
        ((filter? a) (filtered-accumulate filter?
                                         combine
                                         (combine (term a) null-value)
                                         term
                                         (next a)
                                         next
                                         b))
        (else (filtered-accumulate filter?
                                   combine
                                   null-value
                                   term
                                   (next a)
                                   next
                                   b))))

;; prime?
(define (prime? x)
  (if (< x 2)
      false
      (= (smallest-divisor x) x)))

(define (smallest-divisor x)
  (find-divisor x 2))

(define (find-divisor x test-divisor)
  (cond ((> (square test-divisor) x) x)
        ((divides? test-divisor x) test-divisor)
        (else
         (find-divisor x (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (square x) (* x x))


;; sum-combiner
(define (sum-combiner a b)
  (+ a b))

;; prod-combiner
(define (prod-combiner a b)
  (* a b))

;; inc
(define (inc x) (+ x 1))


(define (sum-up-primes a b)
  (filtered-accumulate prime?        ;; filter
                       sum-combiner  ;; combiner
                       0             ;; null-value
                       (lambda (x) x);; term
                       a             ;; a
                       inc           ;; next
                       b))           ;; b


;; b. the product of all the positive integers less than n that are relatively
;; prime to n (i.e., all positive integers i < n such that GCD(i, n) = 1).
(define (gcd a b)
  (if (= a 0)
      b
      (gcd (remainder b a) a)))

(define (prod-relative-prime a b n)
  (define (relative-prime? x)
    (cond ((or (< x 1) (>= x n)) false)
          ((= (gcd x n) 1) true)
          (else false)))
  (filtered-accumulate relative-prime?
                       prod-combiner
                       1
                       (lambda (x) x)
                       a
                       inc
                       b))
