;; sicp-2-22.ss: Louis Reasoner tries to rewrite the first square-list
;; procedure of exercise 2.21 so that it evolves an iterative process:
;; (define (square-list items)
;;   (define (iter things answer)
;;     (if (null? things)
;;         answer
;;         (iter (cdr things)
;;               (cons (square (car things))
;;                     answer))))
;;   (iter items null))
;;
;; Unfortunately, defining square-list this way procedures the answer list in
;; the reverse order of the one desired. Why?
;;
;; Louis then tries to fix his bug by interchanging the arguments to cons:
;; (define (square-list items)
;;   (define (iter things answer)
;;     (if (null? things)
;;         answer
;;         (iter (cdr things)
;;               (cons answer
;;                     (square-list (car things))))))
;;   (iter items null))
;;
;; This doesn't work either. Explain.


;; Louis Reasoner's first iterative square-list
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items null))

(square-list (list 1 2 3 4))
;;=> '(16 9 4 1)
;; The answer list is in the reverse order because of the property of function
;; cons and car. Square-list start from the head of the list, and place the
;; square of the first element of remaining list before the answer
;; We can rewrite Louis's square-list which start from the last item.
(load "sicp-2-18.ss")
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter (reverse items) null))

(square-list '(1 2 3 4))
;;=> '(1 4 9 16)


;; Louis's another iterative square-list
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter items null))

(square-list '(1 2 3 4))
;;=> '((((() . 1) . 4) . 9) . 16)
;; The answer of this square-list is empty list because of the first item
;; is null and the last item is not null.


;; my iterative square-list version
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (append answer
                      (list (square (car things)))))))
  (iter items '()))

(square-list '(1 2 3 4))
;;=> '(1 4 9 16)
