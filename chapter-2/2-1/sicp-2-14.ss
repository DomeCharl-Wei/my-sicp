;; sicp-2-14.ss: Demonstrate that Lem is right. Investigate the behavior of
;; the system on a variety of arithmetic expressions. Make some intervals
;; A and B, and use them in computing the expressions A/A and A/B. You will
;; get the most insight by using intervals whose width is a small percentage
;; of the center value. Examine the results of the computation in
;; center-percent form (see exercise 2.12).

(load "sicp-2-7.ss")
(load "sicp-2-12.ss")

(define a (make-center-percent 5 0.01))
(define b (make-center-percent 10 0.05))

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (div-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))

(par1 a b)
;;=> '(88.46287128712872 . 112.47727272727272)
(par2 a b)
;;=> '(3.2543252595155714 . 3.409967845659164)
