;; sicp-2-1.ss: Define a better version of make-rat that handles both positive
;; and negative arguments. Make-rat should normalize the sign so that if the
;; rational number is positive, both the numerator and denominator are positive
;; and if the rational number is negative, only the numerator is negative.

;; gcd
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (abs x)
  (if (< x 0)
      (- 0 x)
      x))

(define (make-rat n d)
  (let ((g (abs (gcd n d))))
    (if (or (and (< n 0) (< d 0))
            (and (> n 0) (< d 0)))
        (cons (/ (- 0 n) g)
              (/ (- 0 d) g))
        (cons (/ n g)
              (/ d g)))))
