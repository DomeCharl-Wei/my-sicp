;; sicp-2-59: Implement the union-set operation for the unordered-list
;; representation of sets
(load "sicp-set.ss")

(define (union-set s1 s2)
  (cond ((null? s1) s2)
        ((null? s2) s1)
        ((not (element-of-set? (car s1) s2))
         (cons (car s1)
               (union-set (cdr s1) s2)))
        (else (union-set (cdr s1) s2))))
