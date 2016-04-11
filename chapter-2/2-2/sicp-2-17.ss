;; sicp-2-17.ss: Define a procedure last-pair that returns the list that
;; contains only the last element of a given (nonempty) list:
;; (last-pair (list 23 72 149 34))
;; (34)

(define (last-pair items)
  (define (last-pair-iter rest cur)
    (if (null? rest)
        cur
        (last-pair-iter (cdr rest) (car rest))))
  (if (null? items)
      null
      (last-pair-iter (cdr items) (car items))))
