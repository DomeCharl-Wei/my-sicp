;; define reverse
(define (reverse lst)
  (if (null? lst)
      '()
      (append (reverse (cdr lst))
              (list (car lst)))))

(reverse (list 1 4 9 16 25))
