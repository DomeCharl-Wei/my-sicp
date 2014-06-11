;; sicp-1-22.ss: write a procedure search-for-primes that checks the
;; primality of consecutive odd integers in a specified range. Use your
;; procedure to find the three smallest primes larger than 1000; larger
;; than 10000; larger than 100000; larger than 1000000. Note the time
;; needed to test each prime. Since the testing algorithm has order of
;; growth of \theta(\sqrt{n}), you should expect that testing for primes
;; around 10000 should take about \sqrt{10} times as long as testing for
;; primes around 10000 should take about \sqrt{10} times as long as testing
;; for primes around 1000. Do your timing data bear this out? How well do
;; the data for 100000 and 1000000 support the \sqrt{n} prediction? Is your
;; result compatible with the notion that programs on your machine run in
;; time proportional to the number of steps required for the computation?

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (square x) (* x x))

(define (divides? a b)
  (= (remainder b a) 0))

(define (primes? n)
  (= (smallest-divisor n) n))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (current-inexact-milliseconds)))

(define (start-prime-test n start-time)
  (cond ((prime? n) (report-prime (- (current-inexact-milliseconds) start-time)))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (even? n)
  (= (remainder n 2) 0))

(define (search-for-primes-iter start end)
  (define (next)
    (if (even? start)
        (+ start 1)
        (+ start 2)))
  (cond ((< start end) (begin
                         (timed-prime-test start)
                         (search-for-primes-iter (next) end)))))

(define (search-for-primes a b)
  (search-for-primes-iter a b))
