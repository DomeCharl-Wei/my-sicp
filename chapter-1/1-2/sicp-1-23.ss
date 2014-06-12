;; sicp-1-23: Define a procedure next that returns odd except for 2. Modify
;; the smallest-divisor procedure to use (next test-divisor) instead of
;; (+ test-divisor 1). With timed-prime-test incorporating this modified
;; version of smallest-divisor, run the test for each of the 12 primes found
;; in exercise 1.22. Since this modification halves the number of test steps
;; you should except it to run about twice as fast. Is this exceptation
;; confirmed? If not, what is the observed ratio of the speeds of the two
;; algorithms, and how do you explain the fact that it is different from 2?

;; old version
(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (square x) (* x x))

(define (divides? a b)
  (= (remainder b a) 0))


;; new version
(define (smallest-divisor-new n)
  (find-divisor-new n 2))

(define (find-divisor-new n test-divisor)
  (define (next)
    (if (= test-divisor 2)
        (+ test-divisor 1)
        (+ test-divisor 2)))
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor-new n (next)))))


(define (prime? n)
  (= (smallest-divisor n) n))


(define (prime-new? n)
  (= (smallest-divisor-new n) n))

;; timed-prime-test old
(define (timed-prime-test n)
  (start-prime-test n (current-inexact-milliseconds)))

(define (start-prime-test n start-time)
  (display n)
  (cond ((prime? n) (report-prime (- (current-inexact-milliseconds) start-time)))))

;; timed-prime-test new
(define (timed-prime-test-new n)
  (start-prime-test-new n (current-inexact-milliseconds)))

(define (start-prime-test-new n start-time)
  (display n)
  (cond ((prime-new? n) (report-prime (- (current-inexact-milliseconds) start-time)))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time)
  (newline))

(define (calculate-test-prime-elapsed-time test-prime-fn n)
  (let ((start-time (current-inexact-milliseconds)))
    (if (test-prime-fn n)
        (- (current-inexact-milliseconds) start-time)
        0)))

(for ([i '(1009 1013 1019 10007 10009 10037 100003 100019 100043 1000003 1000033 1000037)])
     (let ((old-time (calculate-test-prime-elapsed-time prime? i))
           (new-time (calculate-test-prime-elapsed-time prime-new? i)))
       (printf "old version timed-prime-test ~a elapsed-time: ~a\n" i old-time)
       (printf "new version timed-prime-test ~a elapsed-time: ~a\n" i new-time)
       (printf "the ratio is ~a\n\n" (/ old-time new-time))))


;; We're seeing a clear improvement in the new procedure, but it's not quite
;; as fast as we expected. The first thing that needs to be explained in this
;; data is the fact that the first three values show very little performance
;; gain, the next three a little more, then fairly consistent results for the
;; remaining data. I think this can be explained by other processes running on
;; the computer. Measuring shorter runs of the procedure (those in the 100-500
;; millisecond range) is going to be much more sensitive to measurement error
;; due to being interrupted by background processes. These errors will be a
;; less significant proportion of the total run time for longer runs of the
;; procedure.

;; We're also seeing that the procedure is only running approximately 1.85
;; times as fast, instead of the expected factor of 2. This may be explained
;; by the fact that we replaced a primitive operation, (+ test-divisor 1), by
;; a user-defined operation, (next). Each time that user-defined operation is
;; called, an extra if must be evaluated (to check if the input is 2). Other
;; than this small discrepancy, I think the improvement is quite good for such
;; a small change to the code.
