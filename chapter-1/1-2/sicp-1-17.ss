;;; design a multiplication procedure analogous to fast-expt that uses a logarithmic number of steps
;;; a iteratively method
(define (fast-multiply a b)
  (define (double x) (+ x x))
  (define (even? x)
    (= (remainder x 2) 0))
  (define (fast-multiply-iter x y product)
    (cond ((= x 0) 0)
          ((= y 0) product)
          ((even? y) (fast-multiply-iter (* x 2)
                                         (/ y 2)
                                         product))
          (else (fast-multiply-iter x
                                    (- y 1)
                                    (+ x product)))))
  (fast-multiply-iter a b 0))
