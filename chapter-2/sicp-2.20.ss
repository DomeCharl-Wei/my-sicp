;; define same-parity

(define (filter fn lst)
  (cond ((null? lst) '())
        ((fn (car lst)) (cons (car lst)
                              (filter fn (cdr lst))))
        (else (filter fn (cdr lst)))))

(define (same-parity x . lst)
  (if (odd? x)
      (filter odd? lst)
      (filter even? lst)))

(same-parity 2 2 3 4 5 6 7)
