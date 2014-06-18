;; sicp-2-9.ss: The width of an interval is half to the difference between its
;; upper and lower bounds. The width is a measure of the uncertainty of the
;; number specified by the interval. For some arithmetic operations the width
;; of the result of combining two intervals is a function only of the widths
;; of the argument intervals, whereas for others the width of the sum (or
;; difference) of two intervals is a function only of the widths of the
;; intervals being added (or subtracted). Give examples to show that this is
;; not true for multiplication or division.

(load "sicp-2-7.ss")
(load "sicp-2-8.ss")

(define (width x)
  (/ (- (upper-bound x) (lower-bound x)) 2.0))


(define a (make-interval -2 -1))
(define b (make-interval -2 1))

(define a-width (width a))
;;=> 0.5
(define b-width (width b))
;;=> 1.5

(width (add-interval a b))
;;=> 2.0
(width (sub-interval a b))
;;=> -1.0

(width (mul-interval a b))
;;=> 3.0
(width (div-interval a b))
;;=> 1.5

(define (checking-width a b)
  (let ((a-width (width a))
        (b-width (width b)))
    (printf "add-interval: ~a\n" (= (width (add-interval a b))
                                  (+ a-width b-width)))
    (printf "sub-interval: ~a\n" (= (width (sub-interval a b))
                                    (- a-width b-width)))
    (printf "mul-interval: ~a\n" (= (width (mul-interval a b))
                                    (* a-width b-width)))
    (printf "div-interval: ~a\n" (= (width (div-interval a b))
                                    (/ a-width b-width)))))

(checking-width a b)
;;=> add-interval: #t
;;=> sub-interval: #t
;;=> mul-interval: #f
;;=> div-interval: #f
