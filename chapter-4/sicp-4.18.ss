;; 对于练习sicp-4.16, 如果采用以下方式变换:
;;
;; (lambda (<vars>)
;;   (let ((u '*unassigned*)
;;         (v '*unassigned*))
;;     (let ((a <e1>)
;; 	     (b <e2>))
;;       (set! u a)
;;       (set! v b)
;;       <e3>)))
;;
;; 对于3.5.4节的solve过程:
;; (define (solve f y0 dt)
;;   (define y (intergral (delay dy) y0 dt))
;;   (define dy (stream-map f y))
;;   y)
;; 还能正常工作吗?
;; 如果采用之前的方式变换, 还能正常工作吗?

;; 1. 如果采用这种方式变换, solve会变换成:
;; (define (solve f y0 dt)
;;   (let ((y '*unassigned*)
;; 	   (dy '*unassigned*))
;;     (let ((a (integral (delay dy) y0 dt))
;;	     (b (stream-map f y)))
;;       (set! y a)
;;       (set! dy b))
;;     y))
;; 然而let是lambda的语法糖衣, 最终到解释器中, solve会变换成:
;; (define (solve f y0 dy)
;;   ((lambda (y dy)
;;      (lambda (a b)
;;        (set! y a)
;;        (set! dy b))
;;      (integral (delay dy) y0 dt)
;;      (stream-map f y))
;;    '*unassigned*
;;    '*unassigned*))
;; 外层lambda的参数是*unassigned*, *unassigned*; 当传递到内层时, 值仍旧是
;; *unassigned*, *unassigned*, 所以这种变换方式无法正常工作

;; 2. 如果使用这种方式变换, 可以正常工作, 
;; (define (solve f y0 dt)
;;   (let ((y '*unassigned*)
;;	   (dy '*unassigned*))
;;     (set! y (integral (delay dy) y0 dt))
;;     (set! dy (stream-map f y))
;;     y))
;; let又变换成lambda, 最终将变换成
;; (define (solve f y0 dt)
;;   ((lambda (y dy)
;;      (set! y (intergral (delay dy) y0 dt))
;;      (set! dy (stream-map f y))
;;      y)
;;    '*unassigned*
;;    '*unassigned*))
;; 传递到lambda体中的时候, delay会使dy延时求值, 而y会变成一个延时求值的对象,
;; (set! dy (stream-map f y))又会使dy值改变, 所以这种方式可以正常工作
