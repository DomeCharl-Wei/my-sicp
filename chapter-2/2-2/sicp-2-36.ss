;; sicp-2-36.ss: The procedure accumulate-n is similar to accumulate except
;; that it takes as its third argument a sequence of sequences, which are all
;; assumed to have the same number of elements. It applies the designated
;; accumulation procedure to combine all the first elements of the sequences,
;; all the second elements of the sequences, and so on, and returns a sequence
;; of the results. For instance, if s is a sequence containing four sequences,
;; ((1 2 3) (4 5 6) (7 8 9) (10 11 12)), then the value of (accumulate-n + 0 s)
;; should be the sequence (22 26 30). Fill in the missing expressionss in the
;; following definition of accumulate-n:
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      null
      (cons (accumulate op init (map (lambda (x) (car x)) seqs))
            (accumulate-n op init (map (lambda (x) (cdr x)) seqs)))))

(define (accumulate op init seq)
  (if (null? seq)
      init
      (op (car seq)
          (accumulate op init (cdr seq)))))


;; testing
(accumulate-n + 0 '((1 2 3) (4 5 6) (7 8 9) (10 11 12)))
;;=> '(22 26 30)