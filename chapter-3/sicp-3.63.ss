(load "basic-stream.ss")

;; 迭代模式的sqrt
;; sqrt:
;;  good-enough?
;;  guess
;;  improve
(define (average a b) (/ (+ a b) 2))
(define (sqrt n)
  (define c 0.0001)
  (define (square x) (* x x))
  (define (good-enough? guess)
    (< (abs (- (square guess) n)) c))
  (define (improve guess)
    (average guess (/ n guess)))
  (define (iter guess)
    (if (good-enough? guess)
        guess
        (iter (improve guess))))
  (iter 1.0))
(sqrt 2)

;; 流式处理sqrt
(define (sqrt-improve guess x)
  (average guess (/ x guess)))
(define (sqrt-stream x)
  (define guesses
    (cons-stream 1.0
                 (stream-map (lambda (guess)
                               (sqrt-improve guess x))
                             guesses)))
  guesses)

(display-stream (stream-take 100 (sqrt-stream 2)))

;; Louis Reasoner版的sqrt-stream
(define (sqrt-stream x)
  (cons-stream 1.0
               (stream-map (lambda (guess)
                             (sqrt-improve guess x))
                           (sqrt-stream x))))
