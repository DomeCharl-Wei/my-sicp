;; sicp-1-3: define a procedure that takes three numbers as
;; arguments and returns the sum of the squares of the two
;; larger numbers

(define (square x)
  (* x x))

(define (max x y)
  (if (< x y)
      y
      x))

(define (min x y)
  (if (< x y)
      x
      y))

(define (sum-of-highest-squares x y z)
  (+ (square (max x y))
     (square (max (min x y) z))))
