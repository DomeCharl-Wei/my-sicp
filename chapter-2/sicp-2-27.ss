;; sicp-2-27.ss: Modify your reverse procedure of exercise 2.18 to procedure
;; a deep-reverse procedure that takes a list as argument and returns as its
;; value the list its elements reversed and with all sublists deep-reversed as
;; well. For example,
;; (define x (list (list 1 2) (list 3 4)))
;; x
;; '((1 2) (3 4))
;; (reverse x)
;; ((3 4) (1 2))
;; (deep-reverse x)
;; ((4 3) (2 1))
(define (deep-reverse items)
  (cond ((null? items) null)
        ((pair? (car items)) (combine (deep-reverse (cdr items))
                                      (deep-reverse (car items))))
        (else (combine (deep-reverse (cdr items))
                       (car items)))))

(define (combine x y)
  (if (or (null? x) (null? y))
      (append x y)
      (list x y)))


;; test
(define x '((1 2) (3 4)))
(deep-reverse x)
;;=> '((4 3) (2 1))

(define y '(1 (2 (3 (4 (5 6))))))
(deep-reverse y)
;;=> '(((((6 5) 4) 3) 2) 1)

(define z '(1 (2 3) 4 (5 6) (7 (8 (9 10)))))
(deep-reverse z)
;;=> '(((((((10 9) 8) 7) (6 5)) 4) (3 2)) 1)
