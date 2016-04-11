;; sicp-2-56: Show how to extend the basic differentiator to handle more kinds
;; of expressions. For instance, implement the differentiation rule
;; \frac{d(u^n)}{d_r} = nu^{n-1}(\frac{d_u}{d_r})
;; by adding a new clause to the deriv program and defining appropiate
;; procedures exponentiation?, base, exponent, and make-exponentiation. (You
;; may use the symbol ** to denote exponnentiation.) Build in the rules that
;; anything raised to the power 0 is 1 and anything raised to the power 1 is
;; the thing itself.

(load "/Users/enzo/projects/github/my/my-sicp/chapter-2/2-3/sicp-deriv.ss")

(define (exponentiation? exp)
  (and (pair? exp) (eq? '** (car exp))))

(define (base exp) (cadr exp))

(define (exponent exp) (caddr exp))

(define (make-exponentiation base exponent)
  (cond ((= exponent 0) 1)
        ((= exponent 1) base)
        (else (list '** base exponent))))


(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv (multiplicand exp) var))
          (make-product (deriv (multiplier exp) var)
                        (multiplicand exp))))
        ((exponentiation? exp)
         (make-product (exponent exp)
                       (make-exponentiation (base exp) (- (exponent exp) 1))))
        (else (error "unknown expression type -- DERIV" exp))))
