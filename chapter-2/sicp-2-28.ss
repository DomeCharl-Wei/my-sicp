;; sicp-2-28.ss: Write a procedure fringe that takes as argument a tree
;; (represented as a list) and returns a list whose elements are all the leaves
;; of the tree arranged in left-to-right order. For example,
;; (define x (list (list 1 2) (list 3 4)))
;; (fringe x)
;; (1 2 3 4)
;; (fringe (list x x))
;; (1 2 3 4 1 2 3 4)

(define (fringe items)
  (cond ((null? items) null)
        ((pair? (car items)) (append (fringe (car items))
                                     (fringe (cdr items))))
        (else (append (list (car items))
                      (fringe (cdr items))))))

;; testing
(define x '((1 2) (3 4)))
(fringe x)
;;=> '(1 2 3 4)
(fringe (list x x))
;;=> '(1 2 3 4 1 2 3 4)

(define y '(1 (2 (3 (4 (5 6))))))
(fringe y)
;;=> '(1 2 3 4 5 6)
