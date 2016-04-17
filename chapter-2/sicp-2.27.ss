;; define deep-reverse

(define (deep-reverse items)
  (cond ((null? items) '())
        ((pair? (car items)) (append (deep-reverse (cdr items))
                                     (list (deep-reverse (car items)))))
        (else (append (deep-reverse (cdr items))
                      (list (car items))))))

(define x (list (list 1 2) (list 3 4) (list 5 6 7)))
(define x (list (list 1 2) (list (list 3 4) (list 5 6 7))))

(deep-reverse x)
