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


;; b. 请写出一个过程scan-out-defines, 它以一个过程体为参数, 返回一个不包括
;;    内部定义的等价表达式, 完成上面描述的变换


(define (scan-out-defines fn-body)
  (define let-vars '())
  (define let-body '())
  (define (inter-definition-variable exp) (cadr exp))
  (define (inter-definition-body exp) (caddr exp))
  (define (internal-definition->let exp)
    (set! let-vars (append (list (list (inter-definition-variable exp)
				       '*unassigned*))
			   let-vars))
    (set! let-body (append (list (list 'set!
				       (inter-definition-variable exp)
				       (inter-definition-body exp)))
			   let-body)))
  (define (help exps)
    (cond ((null? exps) '())
	  ((eq? (caar exps) 'define) (begin (internal-definition->let (car exps))
					    (help (cdr exps))))
	  (else (begin (set! let-body (append (car exps)
					      let-body))
		       (help (cdr exps))))))
  (append (list 'let
		let-vars)
	  let-body)) 


;; community.schemewiki.org上 b的实现
;;  link: http://community.schemewiki.org/?sicp-ex-4.16
(define (scan-out-defines body)
  (define (name-unassigned defines)
    (map (lambda (x)
	   (list (definition-variable x) '*unassigned*))
	 defines))
  (define (set-values defines)
    (map (lambda (x)
	   (list 'set! (definition-variable x) (definition-value x)))
	 defines))
  (define (defines->let exprs defines not-defines)
    (cond ((null? exprs) (if (null? defines)
			     body
			     (list (list 'let
					 (name-unassigned defines)
					 (make-begin (append (set-values defines)
							     (reverse not-defines)))))))
	  ((definition? (car exprs)) (defines->let
				       (cdr exprs)
				       (cons (car exprs)
					     defines)
				       not-defines))
	  (else (defines->let
		  (cdr exprs)
		  defines
		  (cons (car exprs)
			not-defines)))))
  (defines->let body '() '()))


