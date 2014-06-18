;; sicp-1-41.ss: Define a procedure double that takes a procedure of one
;; argument and returns a procedure that applies the original procedure twice.
;; For example, if inc is a procedure that adds 1 to its argument, then
;; (double inc) should be a procedure that adds 2. What value is returned by
;; (((double (double double)) inc) 5)

;; define double
(define (double f)
  (lambda (x) (f (f x))))

(define (inc x) (+ x 1))

(((double (double double)) inc) 5)
;; 21

;; (((double (double double)) inc) 5)
