;; sicp-2-39.ss: Complete the following definitions of reverse (exercise 2.18)
;; in terms of fold-right and fold-left from exerice 2.38:
;; (define (reverse seq)
;;   (fold-right (lambda (x y) <??>) null seq))
;;
;; (define (reverse seq)
;;   (fold-left (lambda (x y) <??>) null seq))


;; define fold-right and fold-left
(define (fold-left op init seq)
  (if (null? seq)
      init
      (fold-left op (op init (car seq)) (car seq))))

(define (fold-right op init seq)
  (if (null? seq)
      init
      (fold-right op (op (car seq) init) (cdr seq))))

;; define reverse
(define (reverse seq)
  (fold-right (lambda (x y)
                (if (null? x)
                    (append x y)
                    (cons x y)))
              null
              seq))

;; testing
(reverse '(1 2 3 4))
;;=> '(4 3 2 1)

(define (reverse seq)
  (fold-left (lambda (x y)
               (if (null? y)
                   (append y x)
                   (cons y x)))
             null
             seq))

;; testing
(reverse '(1 2 3 4))
;;=> '(4 3 2 1)
