;; sicp 4.16
;;
;; 通过lambda表达式的语法变换, 在求值lambda表达式的体之前, 首先扫描并且删除
;; 掉这个过程体里的所有内部定义, 并用一个let创建这些内部定义的变量, 而后通过
;; 赋值设置他们的值. 举个例子, 过程
;; 
;; (lambda (<vars>)
;;   (define u <e1>)
;;   (define v <e2>)
;;   <e3>)
;; 
;; 将被翻译为:
;;
;; (lambda (<vars>)
;;   (let ((u '*unassigned*)
;;         (v '*unassigned*))
;;     (set! u <e1>)
;;     (set! v <e2>)
;;     <e3>))

(require 'scheme)

;; a. 修改lookup-variable-value, 使它在发现的值是符号 *unassigned* 时
;; 发出一个出错信号
(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
	     (env-loop (enclosing-environment env)))
	    ((eq? var (car vars))
	     ;; checking if value equal to '*unassigned*
	     (if (eq? (car vals) '*unassigned*)
		 (error "variable unassigned --" var)
		 (car vals)))
	    (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
	(error "Unbound variable" var)
	(let ((frame (first-frame env)))
	  (scan (frame-variables frame)
		(frame-values frame)))))
  (env-loop env))
