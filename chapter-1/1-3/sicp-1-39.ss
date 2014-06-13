;; sicp-1-39.ss: A continued fraction representation of the tangent function
;; was published in 1770 by the German mathematician J.H.Lambert:
;; \tan{r} = \frac{r}{1 - \frac{r^2}{3 - \frac{r^2}{5 - ...}}}
;; where x is in radians. Define a procedure (tan-cf x k) that computes an
;; approximation to the tangent function based on Lambert's formula.
;; k specifies the number of terms to compute, as in exercise 1.37

(define (tan-cf x k)
  (define (d i) (- (* 2.0 i) 1.0))
  (define (square x) (* x x))
  (define (iter i result)
    (if (= i 0)
        result
        (iter (- i 1)
              (- (d i)
                 (/ (square x) result)))))

  (/ x (iter k (/ (square x) (d k)))))


(tan 45)
;;=> 1.6197751905438615
(tan-cf 45 100)
;;=> 1.6197751905438595
