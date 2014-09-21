;; sicp-2-57: Extend the differentiation program to handle sums and products
;; of arbitrary numbers of (two or more) terms. Then the last example above
;; above could be expressed as
;; (deriv '(* x y (+ x 3)) 'x)
;; Try to do this by changing only the representation for sums and products
;; without changing the deriv procedure at all. For example, the addend of a
;; sum would be the first term, and the augend would be the sum of the rest
;; of the terms.

(load "/Users/enzo/projects/github/my/my-sicp/chapter-2/2-3/sicp-deriv.ss")

;; The original implementations of these procedures simply returned the second
;; argument in a sum or product, respectively. Instead of returning a single
;; value or symbol, we'll need to modify these procedures so they can return
;; an expression.

(define (augend s)
  (if (null? (cdddr s))
      (caddr s)
      (cons '+ (cddr s))))



(define (multiplicand p)
  (if (null? (cdddr s))
      (caddr p)
      (cons '* (cddr p))))
