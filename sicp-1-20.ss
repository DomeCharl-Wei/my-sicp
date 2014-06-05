;;; the greatest common divisors
(define (gcd x y)
  (if (= y 0)
      x
      (gcd y (remainder x y))))

   (gcd 206 40)
=> (gcd 40 (remainder 206 40))
=> (gcd (remainder 206 40) (remainder 40 (remainder 206 40)))
=> ()
