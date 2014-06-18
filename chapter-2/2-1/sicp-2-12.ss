;; sicp-2-12.ss: Define a constructor make-center-percent that takes a center
;; and a percentage tolerance and produces the desired interval. You must also
;; define a selector percent that produces the percentage tolerance for a given
;; interval. The center selector is the same as the one shown above.

(define (make-center-percent c p)
  (make-interval (- c (* c p))
                 (+ c (* c p))))

(define (center x)
  (/ (+ (lower-bound x) (upper-bound x)) 2.0))

(define (width x)
  (/ (- (upper-bound x) (lower-bound x)) 2.0))

(define (percent x)
  (/ (width x) (center x)))
