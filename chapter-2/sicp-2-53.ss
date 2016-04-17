;; sicp-2-53: whta would the interpreter print in response to evaluating each
;; of the following expressions?

(list 'a 'b 'c)
;; => '(a b c)

(list (list 'george))
;; => '((george))

(car '((x1 x2) (y1 y2)))
;; => '(x1 x2)

(cadr '((x1 x2) (y1 y2)))
;; => '(y1 y2)

(pair? (car '(a short list)))
;; => #f

(memq 'red '((red shoes) (blue socks)))
;; => #f
;; memq: find an element using eq?
;; (define (memq item x)
;;   (cond ((null? x) false)
;;         ((eq? item (car x)) x)
;;         (else (memq item (cdr x)))))


(memq 'red '(red shoes blue socks))
;; => #t
