;; sicp 4.9
;;  实现迭代结构 do

(define (do? exp)
  (tagged-list? exp 'do))
(define (do-var exp) (cadr exp))
(define (do-var-name var)
  (if (null? var)
      '()
      (cons (caar var)
	    (do-var-name (cdr var)))))
(define (do-var-init var)
  (if (null? var)
      '()
      (cons (cadr (car var))
	    (do-var-init (cdr var)))))

(define (do-var-step var)
  (if (null? var)
      '()
      (cons (cadr (cdr (car var)))
	    (do-var-step (cdr var)))))

(define (do-test exp)
  (car (cadr (cdr exp))))

(define (do-command exp)
  (cadr (cadr (cdr exp))))

(define (do-combination exp)
  (transform-do (do-var exp)
		(do-test exp)
		(do-command exp)))

(define (transform-do var test command)
  (sequence->exp
   (list (cons 'define
	       (list (cons 'do-iter (do-var-name var))
		     (make-if test
			      command
			      (cons 'do-iter (do-var-step var)))))
	 (cons 'do-iter (do-var-init var)))))


;; testing

(define (fib n)
  (cond ((= n 0) 0)
	((= n 1) 1)
	(else
	 (do ((count 1 (+ count 1))
	      (b 0 a)
	      (a 1 (+ a b)))
	     ((= count n) a (* a 10))))))
	      
