;; implement a accumulator

(define (make-accumulator init-value)
  (lambda (another-value)
    (set! init-value (+ init-value another-value))
    init-value))

;; test case
(define A (make-accumulator 5))
(A 10)
;; => 15
(A 10)
;; => 25
