;;; n < 3, f(n) = n
;;; n >= 3, f(n) = f(n-1) + 2f(n-2) + 3f(n-3)

;;; recursively calculate
(define (func n)
  (define (func-iter x)
    (if (< x 3)
	x
	(+ (func-iter (- x 1))
	   (* (func-iter (- x 2)) 2)
	   (* (func-iter (- x 3)) 3))))
  (func-iter n))

;;; iteratively calculate
(define (funcc n)
  (define (f x1 x2 x3)
    (+ x1
       (* x2 2)
       (* x3 3)))
  (define (funcc-iter cnt f1 f2 f3)
    (cond ((= n 0) 0)
	  ((= n 1) 1)
	  ((= cnt n) f1)
	  (else (funcc-iter (+ cnt 1)
			    (f f1 f2 f3)
			    f1
			    f2))))
  (funcc-iter 2 2 1 0))


;;; The answer of `Bill the Lizard'
;;; recursively
(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1))
         (* 2 (f (- n 2)))
         (* 3 (f (- n 3))))))

;;; iteratively
(define (f n)
  (if (< n 3)
      n
      (f-iter 2 1 0 n)))
(define (f-iter a b c count)
  (if (< count 3)
      a
      (f-iter (+ a (* 2 b) (* 3 c))
              a
              b
              (- count 1))))
