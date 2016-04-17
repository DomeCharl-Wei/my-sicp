;; sicp-2-21.ss: The procedure square-list takes a list of numbers as argument
;; and returns a list of the squares of those numbers
;; (square-list (list 1 2 3 4))
;; => (1 4 9 16)
;; Here are two different definition of square-list. Complete both of them by
;; filling the missing expression:
;; (define (square-list items)
;;   (if (null? items)
;;       null
;;       (cons <??> <??>)))
;; (define (square-list items)
;;   (map <??> <??>))

(define (square x) (* x x))

(define (square-list items)
  (if (null? items)
      null
      (cons (square (car items))
            (square-list (cdr items)))))

(square-list (list 1 2 3 4 5))
;;=> '(1 4 9 16 25)


(define (square-list items)
  (map (lambda (x) (* x x)) items))

(square-list (list 1 2 3 4 5))
;;=> '(1 4 9 16 25)
