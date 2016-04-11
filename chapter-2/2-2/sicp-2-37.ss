;; sicp-2-37.ss: Write the procedures for computing matrix operations.

;;  accumulate
(define (accumulate op init seq)
  (if (null? seq)
      init
      (accumulate op (op (car seq) init) (cdr seq))))

;; accumulate-n
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      null
      (cons (accumulate op init (map (lambda (x) (car x)) seqs))
            (accumulate-n op init (map (lambda (x) (cdr x)) seqs)))))


;; dot-product
(define (dot-product v w)
  (accumulate + 0 (map * v w)))

;; matrix-*-vector
(define (matrix-*-vector m v)
  (map (lambda (x)
         (dot-product x v))
       m))

;; transpose
(define (transpose mat)
  (accumulate-n (lambda (x y)
                  (if (null? y)
                      (cons x y)
                      (append y (list x))))
                null
                mat))


;; matrix-*-matrix
(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (x)
           (matrix-*-vector cols x))
         m)))


;; testing
(define a '((1 2 3)
            (4 5 6)
            (7 8 9)
            (10 11 12)))

(define b '((1 3)
            (5 7)
            (9 11)))

(define c '(3 4 5))

(matrix-*-vector a c)
;;=> '(26 62 98 134)

(transpose a)
;;=> '((1 4 7 10)
;;     (2 5 8 11)
;;     (3 6 9 12))

(matrix-*-matrix a b)
;;=> '((38 50)
;;     (83 113)
;;     (128 176)
;;     (173 239))
