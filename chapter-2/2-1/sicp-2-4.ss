;; sicp-2-4.ss: Here is an alternative procedural representation of pairs. For
;; this representation, verify that (car (cons x y)) yields x for any objects
;; x and y.
;; (define (cons x y)
;;   (lambda (m) (m x y)))
;; (define (car z)
;;   (z (lambda (p q) p)))
;; What is the corresponding definition of cdr? (Hint: To verify that this
;; works, make use of the substitution model of section 1.1.5)

(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))

(define (cdr z)
  (z (lambda (p q) q)))

;; *Analysis of car*:
;;
;;   (car z)
;;=> (car (lambda (m) (m x y)))
;;=> ((z (lambda (p q) p)) (lambda (m) (m x y)))
;; The car procedure takes a procedure z as an argument and applies it to
;; (lambda (p q) p), so there's one more substitution we need to do here
;; before this step is really done. We need to take the second lambda in the
;; expression above and replace z with it.
;;
;;=> ((lambda (m) (m x y)) (lambda (p q) p))
;;
;; That might look scary, but it's just a procedure applied to another
;; procedure. Since the procedure on the left takes one formal parameter, we
;; can substitute the procedure on the right for that parameter
;;
;; => ((lambda (p q) p) x y)
;;
;; Now it should be clear that this expression is a procedure that takes two
;; parameters p and q, and passes two parameters to it. The procedure returns
;; the first of the two parameters passed to it, so this expression simplifies
;; to x.
