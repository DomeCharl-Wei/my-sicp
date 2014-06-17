;; sicp-2-7.ss: Alyssa's program is incomplete because she has not specified
;; the implementation of the interval abstraction. Here is a definition of the
;; interval constructor:
;; (define (make-interval a b) (cons a b))
;; Define selectors upper-bound and lower-bound to complete the implementataion

(define (make-interval a b)
  (cons a b))

(define (upper-bound x)
  (cdr x))

(define (lower-bound x)
  (car x))


(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (min a b c d)
  (define (_min_ x y)
    (if (< x y)
        x
        y))
  (_min_ a (_min_ b (_min_ c d))))

(define (max a b c d)
  (define (_max_ x y)
    (if (> x y)
        x
        y))
  (_max_ a (_max_ b (_max_ c d))))


(define (div-interval x y)
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))
