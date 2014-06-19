;; sicp-2-31.ss: Abstract your answer to exercise 2.30 to produce a procedure
;; tree-map with the property that square-tree could be defined as
;; (define (square-tree tree) (tree-map square tree))

(define (tree-map fn tree)
  (cond ((null? tree) null)
        ((not (pair? tree)) (fn tree))
        (else (cons (tree-map fn (car tree))
                    (tree-map fn (cdr tree))))))

;; testing
(define (square-tree tree) (tree-map square tree))
(define (square x) (* x x))

(square-tree '(1 (2 (3 4) 5) (6 7)))
;;=> '(1 (4 (9 16) 25) (36 49))
