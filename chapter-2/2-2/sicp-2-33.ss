;; sicp-2-33.ss: Fill in the missing expression to complete the following
;; definitions of some basic list-manipulation operations as accumulations:
;; (define (map p sequence)
;;   (accumulate (lambda (x y) <??>) null sequence))
;; (define (append seq1 seq2)
;;   (accumulate cons <??> <??>))
;; (define (length sequence)
;;   (accumulate <??> 0 sequence))

(define (accumulate fn initial seq)
  (if (null? seq)
      initial
      (fn (car seq)
          (accumulate fn initial (cdr seq)))))

(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) null sequence))
;; testing map
(map (lambda (x) (* x x)) '(1 2 3 4))
;;=> '(1 4 9 16)

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))
;; testing append
(append '(1 2 3) '(4 5 6))
;;=> '(1 2 3 4 5 6)

(define (length sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence))
