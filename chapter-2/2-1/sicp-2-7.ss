;; sicp-2-7.ss: Alyssa's program is incomplete because she has not specified
;; the implementation of the interval abstraction. Here is a definition of the
;; interval constructor:
;; (define (make-interval a b) (cons a b))
;; Define selectors upper-bound and lower-bound to complete the implementataion

(define (make-interval a b)
  (cons a b))

(define (upper-bound x)
  (cdr x))

(define (lower-bound x)
  (car x))
