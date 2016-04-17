;; define last-pair
(define (last-pair lst)
  (cond ((null? lst) '())
        ((null? (cdr lst)) lst)
        (else
         (last-pair (cdr lst)))))

;; testing
(last-pair (list 23 72 149 34))
(last-pair '())
(last-pair '(34))
