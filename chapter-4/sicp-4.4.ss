#lang racket

(require 'scheme)

;;;;;;;;;;;;;;;;;;;;
;; 实现and和or表达式
;;;;;;;;;;;;;;;;;;;;

;;; common selector
(define (predicates exp)
  (cdr exp))

(define (first-predicate preds)
  (car preds))

(define (rest-predicates preds)
  (cdr preds))

;;; and表达形式: (and <and-predicate 1> ... <and-predicate n>)
;;; and 谓词
(define (and? exp)
  (tagged-list? exp 'and))

(define (eval-and preds env)
  (cond ((null? preds) #t)
	((not (true? (eval (first-predicate preds) env))) #f)
	(else (eval-and (rest-predicates preds) env))))



;;; or 表达形式: (or <predicate 1> ... <predicate n>)
(define (or? exp)
  (tagged-list? exp 'or))

(define (eval-or preds env)
  (cond ((null? preds) #f)
	((true? (eval (first-predicate preds) env)) #t)
	(else (eval-or (rest-predicates preds) env))))


;;;;;;;;;;;;;;;;;;;;;;;;;
;; 用派生方式实现 eval-or
;;;;;;;;;;;;;;;;;;;;;;;;;

(define (eval-or preds env)
  (if (not (eval-and (frist-predicate preds)))
      #t
      (eval-or (rest-predicates preds) env)))
  
