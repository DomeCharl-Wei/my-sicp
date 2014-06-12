;; sicp-1-31.ss: a. The sum procedure is only the simplest of a vast number
;; of similar abstractions that can be captured as higher-order procedures.
;; Write an analogous procedure called product that returns the product of
;; the values of a function at points over a given range. Show how to define
;; factorial in terms of product. Also use product to compute approximations
;; to \pi using the formula:
;; \frac{\pi}{4} = \frac{2*4*4*6*6*8...}{3*3*5*5*7*7...}


;; iterative product function
(define (product term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))

;; factorial
(define (factorial n)
  (define (inc x) (+ x 1))
  (define (f x) x)
  (product f 1 inc n))


;; \frac{\pi}{2} = \prod_{n=1}^{\inf}{\frac{4n^2}{4n^2 - 1}}
(define (pi)
  (define (inc x) (+ x 1))
  (define (square x) (* x x))
  (define (term x)
    (/ (* 4.0 (square x))
       (- (* 4.0 (square x)) 1)))
  (* 2 (product term 1 inc 100)))



;; b. If your product procedure generates a recursive process, write one that
;; generates an iterative process. If it generates an iterative process, write
;; one that generates a recursive process

;; recursive product function
(define (product-recur term a next b)
  (if (> a b)
      1
      (* (term a)
         (product-recur term (next a) next b))))


;; (factorial 5)
(product-recur (lambda (n) n)
               1
               (lambda (n) (+ n 1))
               5)
