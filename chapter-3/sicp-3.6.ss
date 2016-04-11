;; sicp 3.6

(define (rand-update x)
  (let ((a (expt 2 32))
        (c 1103515245)
        (m 12345))
    (modulo (+ (* a x) c) m)))

(define random-init 137)

(define rand
  (let ((x random-init))
    (define _rand
      (lambda ()
        (set! x (rand-update x))
        x))
    (define (reset value)
      (set! x value)
      x)
    (define (dispatch m)
      (cond ((eq? m 'generate) (_rand))
            ((eq? m 'reset) reset)
            (else (error "Unsupport method"))))
    dispatch))

(rand 'generate)
((rand 'reset) 3062)
