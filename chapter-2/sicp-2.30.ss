;; define square-list
(define (square x) (* x x))

;; define directly
(define (square-tree t)
  (cond ((null? t) '())
        ((not (pair? t)) (square t))
        (else (cons (square-tree (car t))
                    (square-tree (cdr t))))))
(square-tree (list 1 (list 2 (list 3))))

;; define with map
(define (square-tree t)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (square-tree sub-tree)
             (square sub-tree)))
       t))

(square-tree (list 1 (list 2 (list 3))))
