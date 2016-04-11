;; 重新定义frame, 使之为约束的表

(define (make-frame vars vals)
  (if (null? vars)
      '()
      (cons (cons (car vars)
		  (car vals))
	    (make-frame (cdr vars) (cdr vals)))))
(define (frame-variables frame)
  (map car frame))
(define (frame-values frame)
  (map cdr frame))

(define (add-binding-to-frame! var val frame)
  (set! frame
	(cons (cons var val)
	      frame)))

(define (lookup-variable-value var env)
  (define (scan frame)
    (cond ((null? frame) (lookup-variable-value var
						(enclosing-environment env)))
	  ((eq? var (caar frame)) (cadr frame))
	  (else (scan (cdr frame)))))
	
  (if (null? env)
      (error "Unbound variable" var)
      (scan (first-frame env))))
	
(define (set-variable-value! var val env)
  (define (scan frame)
    (cond ((null? frame) (set-variable-value! var
					      (enclosing-environment env)))
	  ((eq? var (caar frame)) (set-cdr! (car frame) val))
	  (else (scan (cdr frame)))))
  (if (null? env)
      (error "Unbound variable -- SET!" var)
      (scan (first-frame env))))


(define (define-variable! var val env)
  (define (scan frame)
    (cond ((null? frame) (add-binding-to-frame! var val frame))
	  ((eq? var (caar frame)) (set-cdr! (car frame) val))
	  (else (scan (cdr frame)))))
  (scan (first-frame env)))
					       
