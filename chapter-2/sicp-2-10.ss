;; sicp-2-10.ss: Ben Bitdiddle, an expert systems programmer, looks over
;; Alyssa's shoulder and comments that it is not clear what it means to divide
;; by an interval that spans zero. Modify Alyssa's code to check for this
;; condition and to signal an error if it occurs

(load "sicp-2-7.ss")

(define (div-interval a b)
  (if (= (width b) 0)
      (error "difference of interval b is zero")
      (let ((random-number (random 100)))
        (mul-interval a (make-interval (/ 1.0 (+ (upper-bound b) random-number))
                                       (/ 1.0 (+ (lower-bound b) random-number)))))))
