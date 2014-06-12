;; sicp-1-25.ss: Is the procedure as follows correct?
;; (define (expmod base exp m)
;;   (remainder (fast-expt base exp) m))

;; basic functions
(define (even? n)
  (= (remainder n 2) 0))

(define (square n) (* n n))

;; the former expmod
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))


;; the fast expt
(define (fast-expt base exp)
  (define (fast-expt-iter base exp product)
    (cond ((= exp 0) product)
          ((even? exp) (fast-expt-iter (square base) (/ exp 2) product))
          (else (fast-expt-iter base (- exp 1) (* product base)))))
  (fast-expt-iter base exp 1))

(define (expmod-new base exp m)
  (remainder (fast-expt base exp) m))


;; calculate elapsed time
(define (calculate-elapsed-time fn . rest)
  (let ((start-time (current-inexact-milliseconds)))
    (apply fn rest)
    (printf "elapsed-time: ~a\n" (- (current-inexact-milliseconds) start-time))))


;; compare the elpased time between expmod and expmod-new
(for ([i '(1009 1013 1019 10007 10009 10037 100003 100019 100043 1000003 1000033 1000037)])
  (let ((random-number (random i)))
    (printf "function (expmod ~a ~a ~a) " random-number i i)
    (calculate-elapsed-time expmod random-number i i)
    (printf "function (expmod-new ~a ~a ~a) " random-number i i)
    (calculate-elapsed-time expmod-new random-number i i)))

;; As we can see, method expmod and expmod-new take same steps to calculate.
;; `expmod' applies square or multiply to the remainder, while `expmod-new'
;; does not. As a result, `expmod' takes less seconds than `expmod-new' when
;; calculates the large arguments.
