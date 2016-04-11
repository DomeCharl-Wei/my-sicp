;; RC电路
(load "/Users/enzo/test/scheme/basic-stream.ss")

(define (RC r c dt)
  (lambda (i v0)
    (cons-stream v0
                 (add-streams (scale-stream (integral i 0 dt)
                                            (/ 1 c))
                              (scale-stream i r)))))

(define RC1 (RC 5 1 0.5))
