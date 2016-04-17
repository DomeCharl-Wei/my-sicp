;; sicp 2.61

(load "sicp-utils.ss")
;; define adjoin-set with order
(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((= x set) set)
        ((< (car set) x) (cons x set))
        (else (adjoin-set x (cdr set)))))
