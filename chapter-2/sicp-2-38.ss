;; sicp-2-38.ss: The accumulate procedure is also known as fold-right, because
;; it combines the first element of the sequence with the result of combining
;; all the elements to the right. There is also a fold-left, which is similar
;; to fold-right, except that it combines elements working in the opposite
;; direction:
;;
;; (define (fold-left op init seq)
;;   (define (iter result rest)
;;     (if (null? rest)
;;         result
;;         (iter (op result (car rest))
;;               (cdr rest))))
;;   (iter init seq))
;;
;; Give a property that op should satisfy to guarantee that fold-right and
;; fold-left will produce the same values for any sequence.

;; also we can define fold-left iteratively like this:
(define (fold-left op init seq)
  (if (null? seq)
      init
      (fold-left op
                 (op init (car seq))
                 (cdr seq))))


;; and the procedure fold-right
(define (fold-right op init seq)
  (if (null? seq)
      init
      (fold-right op
                  (op (car seq) init)
                  (cdr seq))))


;; we can find the difference between *fold-left* and *fold-right* is the
;; order in the op. To meet the requirement of the title, the property of op
;; must be order-irrelevance. For instance, the operation +, *

(fold-left + 0 '(1 2 3 4))
;;=> 10
(fold-right + 0 '(1 2 3 4))
;;=> 10

(fold-left * 1 '(1 2 3 4))
;;=> 24
(fold-right * 1 '(1 2 3 4))
;;=> 24
