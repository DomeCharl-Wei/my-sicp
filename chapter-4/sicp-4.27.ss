;; 惰性求值分析

;; 惰性求值表达式定义
(define count 0)
(define (id x)
  (set! count (+ count 1))
  x)

;; 求下面表达式的值
(define w (id (id 10)))
;;
;; count 一开始是0
;; 当在解释器中输入w之后, count变成2
