;; sicp 4.7
#lang racket

(require 'scheme)
(require 'sicp-4.6)

(define (let*? exp)
  (tagged-list? exp 'let*))

(define (let*->nested-lets exp)
  (expand-let*-variable (let-variable-pairs exp) (let-body exp)))))

(define (first-pair pairs)
  (car pairs))
(define (rest-pairs pairs)
  (cdr pairs))

(define (expand-let*-variable pairs body)
  (if (null? pairs)
      body
      (make-let (list (first pairs))
		(expand-let*-variable (rest-pairs pairs) body))))
