#lang racket
;; 重写list-of-values, 使得求值顺序从右到左

(require 'scheme)


;; 从左到右的求值顺序
(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (cons (eval (first-operand exp) env)
	    (list-of-values (rest-operand exps) env))))

;; 从右到左的求值顺序
(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (cons (list-of-values (rest-operand exps) env)
	    (eval (first-operand exp) env))))

