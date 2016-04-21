;; 比较正文中的 analyze-sequence 和 Alyssa版本的 analyze-sequence

;; 正文中的 analyze-sequence
(define (analyze-sequence-1 exps)
  (define (sequentially proc1 proc2)
    (lambda (env) (proc1 env) (proc2 env)))
  (define (loop first-proc rest-procs)
    (if (null? rest-procs)
	first-proc
	(loop (sequentially first-proc (car rest-procs))
	      (cdr rest-procs))))
  (let ((procs (map analyze exps)))
    (if (null? procs)
	(error "Empty sequence -- ANALYZE"))
    (loop (car procs)
	  (cdr procs))))


;; Alyssa版本的 analyze-sequence
(define (analyze-sequence-2 exps)
  (define (execute-sequence procs env)
    (cond ((null? (cdr procs)) ((car procs) env))
	  (else ((car procs) env)
		(execute-sequence (cdr procs) env))))
  (let ((procs (map analyze exps)))
    (if (null? procs)
	(error "Empty sequence -- ANALYZE"))
    (lambda (env) (execute-sequence procs env))))


;; 当处理的序列只有一个表达式时, 例如'((+ 1 2))
;;   analyze-sequence-1 返回的结果是
;;     (lambda (env) (+ 1 2))
;;   analyze-sequence-2 返回的结果是
;;     (lambda (env) (execute-sequence (list (lambda (env) (+ 1 2))) env))
;;
;;
;; 当处理的序列有多个表达式时, 例如
;; '((+ 1 2)
;;   (- 2 1))
;;
;;  analyze-sequence-1 返回的结果是
;;    (lambda (env) ((lambda (env) (+ 1 2)) env)
;;                  ((lambda (env) (- 2 1)) env))
;;  analyze-sequence-2 返回结果是
;;     (lambda (env) (execute-sequence (list (lambda (env) (+ 1 2))
;;      	        	             (lambda (env) (- 2 1)))
;;      				env))
;;
;;
;; analyze-sequence-1 基本上在语法分析过程把 所有表达式都表示成lambda表达式,
;; 执行的时候, 直接传入env就可以了
;; 而analyze-sequence-2则需要循环调用表达式
