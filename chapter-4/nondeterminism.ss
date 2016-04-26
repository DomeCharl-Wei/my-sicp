;;; abbreviation for call-with-current-continuation
(define call/cc call-with-current-continuation)

;;; This function is re-assigned in `choose` and `fail` itself.
(define fail #f)

;;; function for nondeterminism
(define (choose . ls)
  (if (null? ls)
      (fail)
      (let ((fail0 fail))
	(call/cc
	 (lambda (cc)
	   (set! fail (lambda ()
			(set! fail fail0)
			(cc (apply choose (cdr ls)))))
	   (cc (car ls)))))))

;;; write following at the end of file
;;; initial value for fail
(call/cc
 (lambda (cc)
   (set! fail (lambda ()
		(cc 'no-choice)))))

;;; testing
(define (sq x) (* x x))

(define (pythag a b c)
  (if (=  (+ (sq a) (sq b)) (sq c))
      (list a b c)
      (choose)))

(pythag (choose 1 2 3)
	(choose 3 4 5)
	(choose 4 5 6))
