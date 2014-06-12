;; sicp-1-24.ss: Modify the timed-prime-test procedure of exercise 1.22
;; to use fast-prime? (the Fermat method), and test each of the 12 primes
;; you found in that exercise. Since the Fermat test has \Theta{\log{n}}
;; growth, how would you expect the time to test primes near 1,000,000 to
;; compare with the time needed to test primes near 1000? Do your data bear
;; this out? Can you explain any discrepancy you find?


;; fast-prime?
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (square x) (* x x))

(define (even? n)
  (= (remainder n 2) 0))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (fast-prime-ten-times? n)
  (fast-prime? n 10))

;; prime?
(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (square x) (* x x))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= (smallest-divisor n) n))

;; timed-prime-test
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (current-inexact-milliseconds)))

(define (start-prime-test n start-time)
  (cond ((fast-prime? n 10) (report-prime (- (current-inexact-milliseconds) start-time)))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

;; calculate test prime time
(define (calculate-test-prime-time test-prime-fn n)
  (let ((start-time (current-inexact-milliseconds)))
    (if (test-prime-fn n)
        (- (current-inexact-milliseconds) start-time)
        0)))


;; compare the speed between fast-prime? and prime?
(for ([i '(1009 1013 1019 10007 10009 10037 100003 100019 100043 1000003 1000033 1000037)])
     (let ((normal (calculate-test-prime-elapsed-time prime? i))
           (fast (calculate-test-prime-elapsed-time fast-prime-ten-times? i)))
       (printf "The elapsed time which using prime? is ~a\n" normal)
       (printf "The elapsed time which using fast-prime? is ~a\n" fast)
       (printf "The ratio is ~a\n\n" (/ fast normal))))


;; We can see the rule of fast-prime? method that the bigger the fast.

;; The timing numbers from the Fermat test start out looking pretty poor
;; compared to what we've seen previously. This has mostly todo with the
;; completely arbitrary number of random values I chose to test each prime
;; with. As we increase the size of the numbers we're testing, you can see
;; that the time using the Fermat test barely increases at all. We can
;; verify that the time increase is logarithmic by observing that as the
;; numbers under test increase by a factor of 10, the ratio column increases
;; by a factor of roughly three. This logarithmic characteristic is due to
;; the fact that the expmod procedure used in fermat-test has a logarithmic
;; time complexity


;; compare the time to test primes near 1000000 and near 1000
(begin
  (printf "The time to test primes near 1000000 is ~a\n"
          (calculate-test-prime-elapsed-time fast-prime-ten-times? 1000003))
  (printf "The time to test primes near 1000 is ~a\n"
          (calculate-test-prime-elapsed-time fast-prime-ten-times? 1009)))
