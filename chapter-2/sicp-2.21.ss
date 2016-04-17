;; define square-list

(define (square-list lst)
  (if (null? lst)
      '()
      (cons ((lambda (x) (* x x)) (car lst))
            (square-list (cdr lst)))))

(define (square-list lst)
  (map (lambda (x) (* x x))
       lst))


(square-list (list 1 2 3 4))
