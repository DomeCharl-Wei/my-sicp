;; define fringe

(define (fringe items)
  (cond ((null? items) '())
        ((not (pair? (car items))) (append (list (car items))
                                           (fringe (cdr items))))
        (else (append (fringe (car items))
                      (fringe (cdr items))))))

(define x (list (list 1 2) (list 3 4)))

(fringe x)

(fringe (list x x))
