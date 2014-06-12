;;; design a iterative procedure for fast-multiply

(define (fast-multiply a b)
  (define (double x) (+ x x))
  (define (even? x)
    (= (remainder x 2) 0))
  (define (fast-multiply-iter x y acc)
    (cond ((= y 0) acc)
          ((even? y) (fast-multiply-iter (double x)
                                         (/ y 2)
                                         acc))
          (else (fast-multiply-iter x
                                    (- y 1)
                                    (+ acc x)))))
  (fast-multiply a b 0))
