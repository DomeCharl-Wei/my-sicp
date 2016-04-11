;; 实现let的派生表达形式
#lang racket

(require 'scheme)
;; let expression
;;  format:
;;   (let
;;      ((<var1> <exp1>)
;;      ...
;;       (<var n> <exp n>))
;;      <body>)
(define (make-let var-pair-list body)
  (list 'let var-pair-list body))

(define (let? exp) (tagged-list? exp 'let))
(define (let-variable-pairs exp) (cadr exp))
(define (let-body exp) (caddr exp))
(define (let->lambda exp)
  (expand-varialbe-pairs (let-variable-pairs exp)
			 (let-body exp)))

(define (expand-variable-pairs pairs body)
  (let ((vars (map car pairs))
	(vals (map cadr pairs)))
    (apply (make-lambda vars body) vals)))

(provide sicp-4.6)
