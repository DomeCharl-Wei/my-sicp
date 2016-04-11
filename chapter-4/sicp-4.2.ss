#lang racket

;; 
;; a) 由于application?谓词定义的过于宽泛, Louis 的计划会导致有些特殊形式不能被正确执行

;; b) 修改被求值语言的语法, 使得每个过程应用都以call开始
;;    表达形式: (call <operator> <operand1> ... <operand n>)
(define (application? exp)
  (tagged-list? exp 'call))

(define (operator exp)
  (cadr exp))

(define (operands exp)
  (cddr exp))
