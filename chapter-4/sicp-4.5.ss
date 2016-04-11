;; sicp-4.5.ss
;; 实现cond的另一种语法: (<test> => <recipient>)
(require 'scheme)

(define (cond->if exp)
  (expand-clauses (cond-clauses exp)))

(define (cond-test? clause)
  (and (list? clause)
       (tagged-list? (cdr clause) '=>)))

(define (cond-test-action clause)
  (caddr clause))


(define (expand-clauses clauses)
  (if (null? clauses)
      'false
      (let ((first (car clauses))
	    (rest (cdr clauses)))
	(if (cond-else-clause? first)
	    (if (null rest)
		(sequence->exp (cond-actions first))
		(error "ELSE clause isn't last -- COND->IF" clauses))
	    (if (cond-test? first)
		(make-if (cond-predicate first)
			 (list (cond-test-action frist)
			       (cond-predicate first))
			 (expand-clauses rest))
		(make-if (cond-predicate first)
			 (sequence->exp (cond-actions first))
			 (expand-clauses rest)))))))
