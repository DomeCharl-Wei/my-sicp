;; sicp-2-18.ss: Define a procedure reverse that takes a list as arguemtn and
;; returns a list of the same elements in reverse order:
;; (reverse (list 1 4 9 16 25))
;; (25 16 9 4 1)

(define (reverse items)
  (define (reverse-iter rest new)
    (if (null? rest)
        new
        (reverse-iter (cdr rest) (cons (car rest) new))))
  (if (null? items)
      null
      (reverse-iter items null)))
