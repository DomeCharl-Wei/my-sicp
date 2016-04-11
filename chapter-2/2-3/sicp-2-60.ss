;; sicp-2-60: We specified that a set would be represented as a list with no
;; duplicates. Now suppose we allow duplicates. For instance, the set {1,2,3}
;; could be represented as the list (2 3 2 1 3 2 2). Design procedures
;; element-of-set?, adjoin-set, union-set, and intersection-set that operate
;; on this representation. How does the efficiency of each compare with the
;; corresponding procedure for the non-duplicate representation? Are there
;; applications for which you would use this representation in preference to
;; the non-duplicate one?

(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((= x (car set)) #t)
        ((> x (car set)) (element-of-set? x (cdr set)))
        (else #f)))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((= x (car set)) set)
        ((> x (car set)) (cons (car set)
                               (adjoin-set x (cdr set))))
        ((< x (car set)) (cons x set))))

(define (union-set s1 s2)
  (cond ((null? s1) s2)
        ((null? s2) s1)
        ((not (element-of-set? (car s1) s2))
         (union-set (cdr s1) (adjoin-set (car s1) s2)))
        (else (union-set (cdr s1) s2))))

(define (intersection-set s1 s2)
  (cond ((or (null? s1) (null? s2)) '())
        ((element-of-set? (car s1) s2) (cons (car s1)
                                             (intersection-set (cdr s1) s2)))
        (else (intersection-set (cdr s1) s2))))
