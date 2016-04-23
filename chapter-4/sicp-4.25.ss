;; 对于unless的定义, 比较在factorial函数中, 正则序和应用序的表现

(define (unless condition usual-value exceptional-value)
  (if condition exceptional-value usual-value))


(define (factorial n)
  (unless (= n 1)
    (* n (factorial (- n 1)))
    1))

;; 计算表达式 (factorial 5)
;; 对于应用序而言,
;;    (factorial 5)
;; => (unless (= 5 1) (* 5 (factorial 4)) 1)
;; 根据应用序规则, (* 5 (factorial 4)) 会被继续求值
;; => (* 5 (unless (= 4 1) (* 4 (factorial 3)) 1))
;; 同理, (* 4 (factorial 3)) 又继续被求值
;; => (* 4 (unless (= 3 1) (* 3 (factorial 2)) 1))
;; ... ...
;; 以此类推, (* x (factorial (- x 1))) 这部分会被一直求值, 无穷无尽
;; 所以, 应用序对(factorial 5)最后将陷入死循环
;;
;;---------------------------------------------------------------
;; 对于正则序而言,
;;    (factorial 5)
;; => (unless (= 5 1) (* 5 (factorial 4)) 1)
;; 根据正则序的规则, (* 5 (factorial 4)) 将会在用到的时候求值, 所以上述
;; 表达式先求值(= 5 1), 得到false, 继续计算(* 5 (factorial 4))
;; => (* 5 (unless (= 4 1) (* 4 (factorial 3)) 1))
;; 同理,
;; => (* 5 (* 4 (unless (= 3 1) (* 3 (factorial 2)) 1)))
;; => (* 5 (* 4 (* 3 (unless (= 2 1) (* 2 (factorial 1)) 1))))
;; => (* 5 (* 4 (* 3 (* 2 1))))
;; => 120
;; 所以, 正则序对(factorial 5) 可以正常工作
;;
