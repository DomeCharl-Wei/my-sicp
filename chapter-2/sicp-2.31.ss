;; define tree-map

(define (tree-map func t)
  (cond ((null? t) '())
        ((not (pair? t)) (func t))
        (else (cons (tree-map func (car t))
                    (tree-map func (cdr t))))))


(define (square-tree t)
  (tree-map (lambda (x) (* x x))
            t))


(square-tree (list 1 (list 2 (list 3 4))))
