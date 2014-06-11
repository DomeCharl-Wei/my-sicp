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
(begin
  (display "function (expmod 2 10 10) ")
  (calculate-elapsed-time expmod 2 10 10)
  (display "function (expmod-new 2 10 10) ")
  (calculate-elapsed-time expmod-new 2 10 10))
