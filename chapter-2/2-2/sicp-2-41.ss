;; sicp-2-41.ss: Write a procedure to find all ordered triples of distinct
;; positive integers i, j, and k less than or equal to a given integer n
;; that sum to a given integer s.


(define (triples n s)
  (define (equal-to-s? triple)
    (= (+ (car triple)
          (cadr triple)
          (caddr triple)) s))
  (filter equal-to-s? (generate-triples n)))

(define (filter fn seq)
  (cond ((null? seq) null)
        ((fn (car seq)) (cons (car seq)
                              (filter fn (cdr seq))))
        (else (filter fn (cdr seq)))))

(define (generate-triples n)
  (flatmap (lambda (i)
             (flatmap (lambda (j)
                    (map (lambda (k)
                           (list i j k))
                         (enumerate-interval 1 n)))
                  (enumerate-interval 1 n)))
           (enumerate-interval 1 n)))

(define (enumerate-interval low high)
  (if (> low high)
      null
      (cons low (enumerate-interval (+ low 1) high))))

(define (flatmap proc seq)
  (accumulate append null (map proc seq)))

(define (accumulate op init seq)
  (if (null? seq)
      init
      (op (car seq)
          (accumulate op init (cdr seq)))))


;; testing
(triples 4 3)
;;=> '((1 1 1))
(triples 5 4)
;;=> '((1 1 2) (1 2 1) (2 1 1))
(triples 6 5)
;;=> '((1 1 3) (1 2 2) (1 3 1) (2 1 2) (2 2 1) (3 1 1))
