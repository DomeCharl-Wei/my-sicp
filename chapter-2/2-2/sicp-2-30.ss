;; sicp-2-30.ss: Define a procedure square-tree analogous to the square-list
;; procedure of exercise 2.21. That is, square-tree should behave as follows:
;; (square-tree
;;  (list 1
;;        (list 2 (list 3 4) 5)
;;        (list 6 7)))
;;=> (1 (4 (9 16) 25) (36 49))
;;
;; Define square-tree both directly (i.e. without using any higher-order
;; procedure) and also by using map and recursion.

(define tr '(1 (2 (3 4) 5) (6 7)))

;; without using any higher order procedure
(define (square-tree tree)
  (cond ((null? tree) null)
        ((not (pair? tree)) (square tree))
        (else (cons (square-tree (car tree))
                    (square-tree (cdr tree))))))

(define (square x) (* x x))

(square-tree tr)
;;=> '(1 (4 (9 16) 25) (36 49))

;; using map
(define (square-tree tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (square-tree sub-tree)
             (square sub-tree)))
       tree))

(square-tree tr)
;;=> '(1 (4 (9 16) 25) (36 49))
