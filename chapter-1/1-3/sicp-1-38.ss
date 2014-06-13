;; sicp-1-38.ss: In 1737, the Swiss mathematician Leonhard Euler published a
;; memoir De Fractionibus Continuis, which included a continued fraction
;; expansion for e-2, where e is the base of the natuaral logarithms. In this
;; fraction, the N_i are all 1, and the D_i are successively 1, 2, 1, 1, 4, 1,
;; 1, 6, 1, 1, 8, .... Write a program that uses your cont-frac procedure from
;; exercise 1.37 to approximate e, based on Euler's expansion.

(define (cont-frac n d k)
  (define (iter i result)
    (if (= i 0)
        result
        (iter (- i 1)
              (+ (d i) (/ (n (+ i 1)) result)))))

  (/ (n 1) (iter (- k 1) (d k))))



(define (N i) 1.0)
(define (D i)
  (if (= (remainder (* 2 (+ i 1)) 3) 0)
      (/ (* 2.0 (+ i 1.0)) 3.0)
      1.0))

(define (approximate-natural-base)
  (+ 2 (cont-frac N D 100)))
;;=> 2.7182818284590455
