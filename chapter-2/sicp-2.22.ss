;; define for-each
(define (for-each proc lst)
  (if (null? lst)
      '()
      (begin
        (proc (car lst))
        (for-each proc (cdr lst)))))
