#lang racket

;; sicp 4.13
;;  实现make-unbound!解除变量的约束
(require 'sicp-4.11)

(define (make-unbound! var env)
  (define (scan frame)
    (cond ((null? frame) (make-unbound! var
					(enclosing-environment env)))
	  ((eq? var (caar frame)) (set-car! frame (cdr frame)))
	  (else (scan (cdr frame)))))
  (if (null? env)
      (error "Unbound variable" var)
      (scan (first-frame env))))
